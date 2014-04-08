class Chambre < ActiveRecord::Base
	#################################################
    # Les chambres: on leur attribue des personnes
	#################################################

	belongs_to :event
	belongs_to :tbk
	has_and_belongs_to_many :personnes
	
	@@zones= %w(A C)

	validates :zone, :inclusion => {  :in => @@zones}
	validates :numero, :presence => true
	validates :nbrplace, :presence => true

	#attr_accessible :numero, :nbrplace, :zone

	attr_accessor :pers_messages

  def to_s
  	return self.numero 
  end

  def to_str
    return self.numero
  end

  def identifiant
  	return "#{self.event_id}#{self.nbrplace.to_s}#{self.tbk.nom_pecs[0..1]}#{self.numero}#{self.zone}"
  end

  def personnes_elligibles
  	
  	commandes=self.event.commandes.where(tbk_id: self.tbk_id).select{|c| c.etape_valide?(1)}

  	personnes=commandes.map{|c| c.personne}
  end

  def personne_elligible?(personne)
  	commande= personne.commandes.where(event_id: self.event_id).first

  	if commande
  		tbk_ok = commande.tbk_id == self.tbk_id
  		etape_ok = commande.etape_valide?(1)

  		tbk_ok && etape_ok
  	else
  		return false
  	end

  end

  def add_personne (personne)

  	if self.personnes.count < self.nbrplace
  		unless self.personnes.include? personne
  			self.personnes << personne
  		end
  	end
  end

  def remove_personne (personne)
	if self.personnes.include? personne
		self.personnes.delete(personne)
	end
  end
  
  def self.import_from_csv (csv_file)
  	CSV.foreach(csv_file.path,headers: true) do |row|
  		Chambre.create(
  			event_id: row['event_id'],
  			tbk_id: row['tbk_id'],
  			zone: row['zone'],
  			numero: row['numero'],
  			nbr_place: row['nbr_place'],
  			)
  	end
  end

  def check_errors (personne)
    commande=personne.commandes.where(event_id: self.event_id).first

    errors=[]

    errors << I18n.t('chambre.error.pers.wrong_event') unless commande
    errors << I18n.t('chambre.error.pers.already_assigned') if personne.chambres.where(event_id: self.event_id).any?

    return errors
  end

  def check_warnings (personne)
    commande=personne.commandes.where(event_id: self.event_id).first

    warnings=[]

    if commande
      warnings << I18n.t('chambre.warning.pers.wrong_tbk') unless commande.tbk_id == self.tbk_id
    end

    return warnings
  end

  def check (personne)
  	result=Hash.new
  	result[:errors]=self.check_errors
  	result[:warnings]=self.check_warnings
  	return result
  end

end
