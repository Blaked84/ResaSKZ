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
	def import_from_csv (csv_file)

		#lire les header pour creer les lits et chambres
			# on crée la chambre
			# on crée le lit
			# on ajoute le lit à la chambre

		# pour chaque ligne
			# pour chaque colonne
				# si la valeur est à 1, on ajoute la personne dans la liste des pessones qui ont acces à la chambre
	
	# exemple à modifier:
  	# CSV.foreach(csv_file.path,headers: true) do |row|
  	# 	Chambre.create(
  	# 		event_id: row['event_id'],
  	# 		tbk_id: row['tbk_id'],
  	# 		zone: row['zone'],
  	# 		numero: row['numero'],
  	# 		nbrplace: row['nbr_place'],
  	# 		)
  	end
  end

end
