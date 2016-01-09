class Lit < ActiveRecord::Base

	#belongs_to :personne
	has_one :personne
	has_and_belongs_to_many :personnes
	belongs_to :chambre

    # rend un lit accessible à une personne
    def set_accesible_a(personne)
        self.personnes << personne
    end

    # import des lits et chambres depuis un csv
    # atribution des chambres accèssibles au personne à partir des numéros de commande 
    def self.import_from_csv (csv,event)
        require 'csv'

        possibilities={}

        csv.each do |r|
            possibilities[r['Commande']]=r.to_hash.select{|k,v| v=='1'}.keys
        end


        headers=csv.headers
        headers.shift #suppression du header de la première colonne

        self.init_from_array(headers,event)


        Chambre.where(event_id: event).map{|c|  c.id}

        lits_ids=Lit.where(chambre_id: Chambre.where(event_id: event).map{|c|  c.id}).map{|l|[l.name, l.id]}
        lits_ids= Hash[lits_ids.map {|key, value| [key, value]}]
        inserts_possibilities=[]
        # INSERT INTO `lits_personnes` ("lit_id", "personne_id") VALUES
        possibilities.each do |commande_id,lits|
            raise "Commande #{commande_id} inconnue" unless commande=Commande.find_by_idlong(commande_id)
            raise "Personne inconnue" unless personne=commande.personne
            lits.each do |l_s|
                l=lits_ids[l_s.to_i]
                inserts_possibilities << "(#{l}, #{personne.id})"
            end
        end

        sql_possibilities='INSERT INTO `lits_personnes` (`lit_id`, `personne_id`) VALUES '+inserts_possibilities.join(', ')
        ActiveRecord::Base.connection.execute sql_possibilities

    end

    private     

        def self.init_from_array (array,event)

            self.clear_for_event event


            chambres=Hash.new

            array.each do |lit_s|
                chambre_s=/(.*)\.(\d*)/.match(lit_s)[1]
                chambres[chambre_s]||=Hash.new
                chambres[chambre_s][:lits]||=[]
                chambres[chambre_s][:lits]<<lit_s
            end


            #INSERT INTO `chambres` ("created_at", "nbrplace", "numero", "updated_at") VALUES (?, ?, ?, ?)

            inserts_chambre =[]
            chambres.each do |k,v|
                inserts_chambre <<"(NOW(), #{v[:lits].length}, '#{k}', NOW(), #{event.id})"
            end

            sql_chambres='INSERT INTO `chambres` (`created_at`, `nbrplace`, `numero`, `updated_at`, `event_id`) VALUES '+inserts_chambre.join(', ')

            ActiveRecord::Base.connection.execute sql_chambres

            #INSERT INTO `lits` (`chambre_id", "created_at", "name", "updated_at") VALUES (?, ?, ?, ?)
            ActiveRecord::Base.transaction do
                Chambre.where(event_id: event).each do |c|
                    inserts_lits =[]
                    chambres[c.numero][:lits].each do |l|
                        inserts_lits << "(#{c.id}, NOW(), '#{l}', NOW())"
                    end
                    sql_lits='INSERT INTO `lits` (`chambre_id`, `created_at`, `name`, `updated_at`) VALUES '+inserts_lits.join(', ')
                    ActiveRecord::Base.connection.execute sql_lits
                end
            end
        end

        def self.clear_for_event event
            ActiveRecord::Base.transaction do
                id_lits=Lit.where(chambre_id: Chambre.where(event_id: event).map{|c|  c.id}).map{|l| l.id}
                if id_lits.any?
                    sql= 'DELETE FROM `lits_personnes` WHERE `lits_personnes`.`lit_id` IN ('+id_lits.join(', ')+')'
                    ActiveRecord::Base.connection.execute sql
                end
                Lit.where(chambre_id: Chambre.where(event_id: event).map{|c|  c.id}).delete_all
                Chambre.where(event_id: event).delete_all
            end
        end
end
