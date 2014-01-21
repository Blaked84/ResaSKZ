# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Prod
puts "Evenements"
Event.create(
	:name => "SKZ Semaine 1",
	:description => "ejfenbjbdjkcbkjvcbcjdc")
Event.create(
	:name => "SKZ Semaine 2",
	:description => "ejfenbjbdjkcbkjvcbcjdc")


puts "Categories"
listecategorries=["Pack","Options au food pack standard","Transport Aller","Transport Retour","Matériel de Glisse","Assurances","Animations complémentaires","Boulangerie","Assurances Complémentaires SKZ.
Attestation Responsabilité à fournir obligatoirement même dans le cas ou une assurance SKZ est sélectionnée"]
listecategorries.each {|c| Categorie.create(:nom =>c) }
Configurable[:id_cat_assurance]=Categorie.find_by( nom: 'Assurances').id.to_s
Configurable[:id_cat_busaller]=Categorie.find_by( nom: 'Transport Aller').id.to_s
Configurable[:id_cat_busretour]=Categorie.find_by( nom: 'Transport Retour').id.to_s
Configurable[:id_pack]=Categorie.find_by( nom: 'Pack').id.to_s

# puts "UserTypes"
# Usertype.create(:)

puts "Glisse"
Glisse.create(nom: 'Ski')
Glisse.create(nom: 'Snowboard')

puts "Genres"
Genre.create(:sexe => "H", :nom_cas => "male", :nom_complet => "Homme")
Genre.create(:sexe => "F", :nom_cas => "female", :nom_complet => "Femme")

puts "taillevetements"
listevet=["S","M","L","XL","XXL"]
listevet.each do |c|
	Taillevetement.create(:name =>c)
end

puts "tbk"
listet=[["Siber's","Metz","me"],["Clun's","Cluny","cl"],["Chalon's","Chalon-en-Champagne","ch"],["Bordel's","Bordeaux","bo"],["KIN","Aix-en-Provence","ai"],["Boquette","Angers","an"],["Birse","Lille","li"],["P3","Paris","pa"]].sort
listet.each do |c|
	Tbk.create(:nom =>c[0], :nom_pecs => c[1], :diminutif=>c[2])
end

listeproduits=[["Pack PG",30500,"",DateTime.new(2013,2,3),"De 213 à 211",1,1],
["Pack JP",33000,"",DateTime.new(2013,2,3),"De 210 à 206",1,1],
["Pack Archi",35000,"",DateTime.new(2013,2,3),"A partir de 205",1,1],
["Food Pack avec Porc",0,"",DateTime.new(2013,2,3),"",1,2],
["Food Pack sans Porc",700,"",DateTime.new(2013,2,3),"",1,2],
["Baguette",510,"",DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",1,8],
["Croissant",360,"",DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",1,8],
["Pain au chocolat",420,"",DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",1,8],
["Pack Saucisson",1000,"",DateTime.new(2013,2,3),"Pour 5 saucissons",1,2],
["Paris",3900,"",DateTime.new(2013,2,3),"",1,3],
["Lille",4900,"",DateTime.new(2013,2,3),"",1,3],
["Cluny",2500,"",DateTime.new(2013,2,3),"",1,3],
["Bordeaux",4800,"",DateTime.new(2013,2,3),"",1,3],
["Paris",3900,"",DateTime.new(2013,2,3),"",1,4],
["Lille",4900,"",DateTime.new(2013,2,3),"",1,4],
["Cluny",2500,"",DateTime.new(2013,2,3),"",1,4],
["Bordeaux",4800,"",DateTime.new(2013,2,3),"",1,4],
["Découverte - Pack Ski Complet",5200,"",DateTime.new(2013,2,3),"",1,5],
["Découverte - Chaussures ski seules",3300,"",DateTime.new(2013,2,3),"",1,5],
["Découverte - Skis seuls",4800,"",DateTime.new(2013,2,3),"",1,5],
["Eco - Pack Complet Ski",6200,"",DateTime.new(2013,2,3),"",1,5],
["Eco - Pack Complet Surf",6200,"",DateTime.new(2013,2,3),"",1,5],
["Eco - Chaussures ski seules",4200,"",DateTime.new(2013,2,3),"",1,5],
["Eco - Chaussures surf seules",4200,"",DateTime.new(2013,2,3),"",1,5],
["Eco - Skis seuls",5800,"",DateTime.new(2013,2,3),"",1,5],
["Eco - Snow seul",5800,"",DateTime.new(2013,2,3),"",1,5],
["Sensation - Pack Complet Ski",7800,"",DateTime.new(2013,2,3),"",1,5],
["Sensation - Pack Complet Surf",7800,"",DateTime.new(2013,2,3),"",1,5],
["Sensation - Chaussures ski seules",5800,"",DateTime.new(2013,2,3),"",1,5],
["Sensation - Chaussures surf seules",5800,"",DateTime.new(2013,2,3),"",1,5],
["Sensation - Skis seuls",7200,"",DateTime.new(2013,2,3),"",1,5],
["Sensation - Snow seul",7200,"",DateTime.new(2013,2,3),"",1,5],
["Annulation",1700,"",DateTime.new(2013,2,3),"Annulation jusqu'à 48h avant le séjour si condition valable (voir conditions sur le site)",1,9],
["Assistance rapatriement bagages",1700,"",DateTime.new(2013,2,3),"Rapatriement sur les pistes, en dehors des pistes et rapatriement chez vous avec vos bagages si besoin",1,9],
["Inter Ski Pass",1100,"",DateTime.new(2013,2,3),"En cas d'obligation de départ pour des raisons valables, remboursement de 35 euros par jour perdu (maximum remboursable 5 jours, voir précisions sur le site)",1,9],
["Tout compris",3300,"",DateTime.new(2013,2,3),"Les trois précédentes cumulées",1,9],
["Pas d'assurance",0,"",DateTime.new(2013,2,3),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",1,9],
["Luge",1000,"",DateTime.new(2013,2,3),"Course de luge Inter - TBK sur une piste de 6 kms",1,7],
["RCC",1050,"",DateTime.new(2013,2,3),"Tournée des bars attaché par groupe",1,7],
["Repas d'Altitude",2700,"",DateTime.new(2013,2,3),"Repas (fondue bourgignone 200g de viande, frites à volonté, 1/2 litre vin) + descente aux fambeaux + feu d'artifice",1,7],
["Pack PG",30500,"",DateTime.new(2013,2,3),"De 213 à 211",2,1],
["Pack JP",33000,"",DateTime.new(2013,2,3),"De 210 à 206",2,1],
["Pack Archi",35000,"",DateTime.new(2013,2,3),"A partir de 205",2,1],
["Food Pack avec Porc",0,"",DateTime.new(2013,2,3),"",2,2],
["Food Pack sans Porc",700,"",DateTime.new(2013,2,3),"",2,2],
["Baguette",510,"",DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",2,8],
["Croissant",360,"",DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",2,8],
["Pain au chocolat",420,"",DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",2,8],
["Pack Saucisson",1000,"",DateTime.new(2013,2,3),"Pour 5 saucissons",2,2],
["Paris",3900,"",DateTime.new(2013,2,3),"",2,3],
["Metz",4100,"",DateTime.new(2013,2,3),"",2,3],
["Châlons",3900,"",DateTime.new(2013,2,3),"",2,3],
["Aix-en-Provence",3000,"",DateTime.new(2013,2,3),"",2,3],
["Angers",4400,"",DateTime.new(2013,2,3),"",2,3],
["Paris",3900,"",DateTime.new(2013,2,3),"",2,4],
["Metz",4100,"",DateTime.new(2013,2,3),"",2,4],
["Châlons",3900,"",DateTime.new(2013,2,3),"",2,4],
["Aix-en-Provence",3000,"",DateTime.new(2013,2,3),"",2,4],
["Angers",4400,"",DateTime.new(2013,2,3),"",2,4],
["Découverte - Pack Ski Complet",5200,"",DateTime.new(2013,2,3),"",2,5],
["Découverte - Chaussures ski seules",3300,"",DateTime.new(2013,2,3),"",2,5],
["Découverte - Skis seuls",4800,"",DateTime.new(2013,2,3),"",2,5],
["Eco - Pack Complet Ski",6200,"",DateTime.new(2013,2,3),"",2,5],
["Eco - Pack Complet Surf",6200,"",DateTime.new(2013,2,3),"",2,5],
["Eco - Chaussures ski seules",4200,"",DateTime.new(2013,2,3),"",2,5],
["Eco - Chaussures surf seules",4200,"",DateTime.new(2013,2,3),"",2,5],
["Eco - Skis seuls",5800,"",DateTime.new(2013,2,3),"",2,5],
["Eco - Snow seul",5800,"",DateTime.new(2013,2,3),"",2,5],
["Sensation - Pack Complet Ski",7800,"",DateTime.new(2013,2,3),"",2,5],
["Sensation - Pack Complet Surf",7800,"",DateTime.new(2013,2,3),"",2,5],
["Sensation - Chaussures ski seules",5800,"",DateTime.new(2013,2,3),"",2,5],
["Sensation - Chaussures surf seules",5800,"",DateTime.new(2013,2,3),"",2,5],
["Sensation - Skis seuls",7200,"",DateTime.new(2013,2,3),"",2,5],
["Sensation - Snow seul",7200,"",DateTime.new(2013,2,3),"",2,5],
["Annulation",1700,"",DateTime.new(2013,2,3),"Annulation jusqu'à 48h avant le séjour si condition valable (voir conditions sur le site)",2,9],
["Assistance rapatriement bagages",1700,"",DateTime.new(2013,2,3),"Rapatriement sur les pistes, en dehors des pistes et rapatriement chez vous avec vos bagages si besoin",2,9],
["Inter Ski Pass",1100,"",DateTime.new(2013,2,3),"En cas d'obligation de départ pour des raisons valables, remboursement de 35 euros par jour perdu (maximum remboursable 5 jours, voir précisions sur le site)",2,9],
["Tout compris",3300,"",DateTime.new(2013,2,3),"Les trois précédentes cumulées",2,9],
["Pas d'assurance",0,"",DateTime.new(2013,2,3),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",2,9],
["Luge",1000,"",DateTime.new(2013,2,3),"Course de luge Inter - TBK sur une piste de 6 kms",2,7],
["RCC",1050,"",DateTime.new(2013,2,3),"Tournée des bars attaché par groupe",2,7],
["Repas d'Altitude",2700,"",DateTime.new(2013,2,3),"Repas (fondue bourgignone 200g de viande, frites à volonté, 1/2 litre vin) + descente aux fambeaux + feu d'artifice",2,7]]



listeproduits.each do |c|
	a=Product.create(
		:name => c[0],
		:price => c[1],
		:stock => c[2],
		:echeance => c[3],
		:description => c[4],
		:event_id => c[5],
		:categorie_id => c[6]
		)
	a.save
end

user_gorgu=User.create(
			email:"gorgu@gadz.org",
			password:"iresam157",
			first_name: 'Gorgu',
			last_name: 'Gadz',
			gender: 'male',
			cgu_accepted: true,
			inscription_terminee: true,
			moderated: true
			)
user_gorgu.add_role :gorgu
user_gorgu.add_role :gadz

user_admin=User.create(
		email:"admin@gadz.org",
		password:"iresam157",
		first_name: 'Admin',
		last_name: 'Gadz',
		gender: 'male',
		cgu_accepted: true,
		inscription_terminee: true,
		moderated: true
		)
user_admin.add_role :admin
user_admin.add_role :gadz