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
	:Name => "SKZ Semaine 1",
	:Description => "ejfenbjbdjkcbkjvcbcjdc")
Event.create(
	:Name => "SKZ Semaine 2",
	:Description => "ejfenbjbdjkcbkjvcbcjdc")


puts "Categories"
listecategorries=["Pack","Nourriture","Transport Aller","Transport Retour","RCC","Assurance"]
listecategorries.each {|c| Categorie.create(:nom =>c) }
Configurable[:id_cat_assurance]=Categorie.find_by( nom: 'Assurance').id.to_s
Configurable[:id_cat_busaller]=Categorie.find_by( nom: 'Transport Aller').id.to_s
Configurable[:id_cat_busretour]=Categorie.find_by( nom: 'Transport Retour').id.to_s

# puts "UserTypes"
# Usertype.create(:)

puts "Genres"
Genre.create(:sexe => "H", :nom_cas => "male", :nom_complet => "Homme")
Genre.create(:sexe => "F", :nom_cas => "female", :nom_complet => "Femme")

puts "taillevetements"
listevet=["S","M","L","XL","XXL"]
listevet.each do |c|
	Taillevetement.create(:name =>c)
end

puts "tbk"
listet=["Siber's","Clun's","Chalon's","Bordel's","KIN","Boquette","Birse","Paris"].sort
listet.each do |c|
	Tbk.create(:nom =>c)
end

listeproduits=[["PG",30500,0,DateTime.new(2013,2,3),"De 213 à 211",1,1],
["JP",32500,0,DateTime.new(2013,2,3),"De 210 à 206",1,1],
["ARCHI",34000,0,DateTime.new(2013,2,3),"A partir de 205",1,1],
["Avec Porc",0,0,DateTime.new(2013,2,3),"",1,2],
["Sans Porc",700,0,DateTime.new(2013,2,3),"",1,2],
["Baguette",0,0,DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",1,8],
["Croissant",0,0,DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",1,8],
["Pain au chocolat",0,0,DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",1,8],
["Pack Saucisson",1000,0,DateTime.new(2013,2,3),"Pour 5 saucissons",1,2],
["Paris",3900,0,DateTime.new(2013,2,3),"",1,3],
["Lille",4900,0,DateTime.new(2013,2,3),"",1,3],
["Cluny",2500,0,DateTime.new(2013,2,3),"",1,3],
["Bordeaux",4800,0,DateTime.new(2013,2,3),"",1,3],
["Paris",3900,0,DateTime.new(2013,2,3),"",1,4],
["Lille",4900,0,DateTime.new(2013,2,3),"",1,4],
["Cluny",2500,0,DateTime.new(2013,2,3),"",1,4],
["Bordeaux",4800,0,DateTime.new(2013,2,3),"",1,4],
["Découverte - Pack Ski Complet",5200,0,DateTime.new(2013,2,3),"",1,5],
["Découverte - Chaussures ski seules",3300,0,DateTime.new(2013,2,3),"",1,5],
["Découverte - Skis seuls",4800,0,DateTime.new(2013,2,3),"",1,5],
["Eco - Pack Complet Ski",6200,0,DateTime.new(2013,2,3),"",1,5],
["Eco - Pack Complet Surf",6200,0,DateTime.new(2013,2,3),"",1,5],
["Eco - Chaussures ski seules",4200,0,DateTime.new(2013,2,3),"",1,5],
["Eco - Chaussures surf seules",4200,0,DateTime.new(2013,2,3),"",1,5],
["Eco - Skis seuls",5800,0,DateTime.new(2013,2,3),"",1,5],
["Eco - Snow seul",5800,0,DateTime.new(2013,2,3),"",1,5],
["Sensation - Pack Complet Ski",7800,0,DateTime.new(2013,2,3),"",1,5],
["Sensation - Pack Complet Surf",7800,0,DateTime.new(2013,2,3),"",1,5],
["Sensation - Chaussures ski seules",5800,0,DateTime.new(2013,2,3),"",1,5],
["Sensation - Chaussures surf seules",5800,0,DateTime.new(2013,2,3),"",1,5],
["Sensation - Skis seuls",7200,0,DateTime.new(2013,2,3),"",1,5],
["Sensation - Snow seul",7200,0,DateTime.new(2013,2,3),"",1,5],
["Annulation",1700,0,DateTime.new(2013,2,3),"",1,6],
["Assistance rapatriement bagages",1700,0,DateTime.new(2013,2,3),"",1,6],
["Inter Ski Pass",1100,0,DateTime.new(2013,2,3),"",1,6],
["Tout compris",3300,0,DateTime.new(2013,2,3),"Les trois précédentes cumulées",1,6],
["Pas d'assurance",0,0,DateTime.new(2013,2,3),"Attestation responsabilité civile à fournir obligatoirement",1,6],
["Matériel Ski",0,0,DateTime.new(2013,2,3),"",1,6],
["Luge",1000,0,DateTime.new(2013,2,3),"Course de luge Inter - TBK sur une piste de 6 kms",1,7],
["RCC",1000,0,DateTime.new(2013,2,3),"Tournée des bars attaché par groupe",1,7],
["Repas d'Altitude",2700,0,DateTime.new(2013,2,3),"Repas (fondue bourgignone 200g de viande, frites à volonté, 1/2 litre vin) + descente aux fambeaux + feu d'artifice",1,7],
["PG",30500,0,DateTime.new(2013,2,3),"De 213 à 211",2,1],
["JP",32500,0,DateTime.new(2013,2,3),"De 210 à 206",2,1],
["ARCHI",34000,0,DateTime.new(2013,2,3),"A partir de 205",2,1],
["Avec Porc",0,0,DateTime.new(2013,2,3),"",2,2],
["Sans Porc",700,0,DateTime.new(2013,2,3),"",2,2],
["Baguette",0,0,DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",2,2],
["Croissant",0,0,DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",2,2],
["Pain au chocolat",0,0,DateTime.new(2013,2,3),"Par jour du dimanche au vendredi",2,2],
["Pack Saucisson",1000,0,DateTime.new(2013,2,3),"Pour 5 saucissons",2,2],
["Paris",3900,0,DateTime.new(2013,2,3),"",2,3],
["Metz",4100,0,DateTime.new(2013,2,3),"",2,3],
["Châlons",3900,0,DateTime.new(2013,2,3),"",2,3],
["Aix-en-Provence",3000,0,DateTime.new(2013,2,3),"",2,3],
["Angers",4400,0,DateTime.new(2013,2,3),"",2,3],
["Paris",3900,0,DateTime.new(2013,2,3),"",2,4],
["Metz",4100,0,DateTime.new(2013,2,3),"",2,4],
["Châlons",3900,0,DateTime.new(2013,2,3),"",2,4],
["Aix-en-Provence",3000,0,DateTime.new(2013,2,3),"",2,4],
["Angers",4400,0,DateTime.new(2013,2,3),"",2,4],
["Découverte - Pack Ski Complet",5200,0,DateTime.new(2013,2,3),"",2,5],
["Découverte - Chaussures ski seules",3300,0,DateTime.new(2013,2,3),"",2,5],
["Découverte - Skis seuls",4800,0,DateTime.new(2013,2,3),"",2,5],
["Eco - Pack Complet Ski",6200,0,DateTime.new(2013,2,3),"",2,5],
["Eco - Pack Complet Surf",6200,0,DateTime.new(2013,2,3),"",2,5],
["Eco - Chaussures ski seules",4200,0,DateTime.new(2013,2,3),"",2,5],
["Eco - Chaussures surf seules",4200,0,DateTime.new(2013,2,3),"",2,5],
["Eco - Skis seuls",5800,0,DateTime.new(2013,2,3),"",2,5],
["Eco - Snow seul",5800,0,DateTime.new(2013,2,3),"",2,5],
["Sensation - Pack Complet Ski",7800,0,DateTime.new(2013,2,3),"",2,5],
["Sensation - Pack Complet Surf",7800,0,DateTime.new(2013,2,3),"",2,5],
["Sensation - Chaussures ski seules",5800,0,DateTime.new(2013,2,3),"",2,5],
["Sensation - Chaussures surf seules",5800,0,DateTime.new(2013,2,3),"",2,5],
["Sensation - Skis seuls",7200,0,DateTime.new(2013,2,3),"",2,5],
["Sensation - Snow seul",7200,0,DateTime.new(2013,2,3),"",2,5],
["Annulation",1700,0,DateTime.new(2013,2,3),"",2,6],
["Assistance rapatriement bagages",1700,0,DateTime.new(2013,2,3),"",2,6],
["Inter Ski Pass",1100,0,DateTime.new(2013,2,3),"",2,9],
["Tout compris",3300,0,DateTime.new(2013,2,3),"Les trois précédentes cumulées",2,6],
["Pas d'assurance",0,0,DateTime.new(2013,2,3),"Attestation responsabilité civile à fournir obligatoirement",2,6],
["Matériel Ski",0,0,DateTime.new(2013,2,3),"",2,9],
["Luge",1000,0,DateTime.new(2013,2,3),"Course de luge Inter - TBK sur une piste de 6 kms",2,7],
["RCC",1000,0,DateTime.new(2013,2,3),"Tournée des bars attaché par groupe",2,7],
["Repas d'Altitude",2700,0,DateTime.new(2013,2,3),"Repas (fondue bourgignone 200g de viande, frites à volonté, 1/2 litre vin) + descente aux fambeaux + feu d'artifice",2,7]]
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
# test only 
case Rails.env
	when "development"

	puts "Seed dev"

	user_gorgu=User.create(
				email:"gorgu@gadz.org",
				password:"iresam157",
				first_name: 'Gorgu',
				last_name: 'Gadz',
				gender: 'male',
				cgu_accepted: true,
				inscription_terminee: true,
				)
	user_gorgu.add_role :gorgu

	user_georges=User.create(
				email:"mail@mail.fr",
				password:"iresam157",
				first_name: 'Georges',
				last_name: 'Duchemin',
				gender: 'male',
				cgu_accepted: false,
				inscription_terminee: false,
				)

	georges=user_georges.create_referant(
		:nom => "Duchemin",
		:prenom => "Georges",
		:phone => "0612345678",
		:assurance => 1,
		:documentassurance => 0,
		:adresse => "12 rue felix savart",
		:complement => "RESAM",
		:ville => "metz",
		:codepostal => "57000",
		:bucque => "bucquetrololo",
		:email => "mail@mail.fr",
		:fams => "84",
		:promo => "211",
		:naissance => DateTime.new(1990,2,3),
		:idGadzOrg => "georges.duchemin.2011",
		:taille => "184",
		:pointure => "42",
		:taillevetement_id => "2",
		:pnom => "Duchemin",
		:pprenom => "Robert",
	    :plienparente => "Pere",
	    :padresse => "84 rue du PG",
	    :pcomplement => "Resid's du gorgu",
	    :pville => "Paris",
	    :pcodepostal=> 75001,
	    :pphone => "068484848484",
	    :genre_id => 1
		)

	user_georges.save

	puts "User & Personnes created"
	
	# while i<200
	# 	com = georges.commandes.create(
	# 	:assurance => 0,
	# 	:status => 0,
	# 	:caution => 1,
	# 	:ean => (SecureRandom.random_number *10**14).to_s[0,13],
	# 	:tbk_id => SecureRandom.random_number(9)
	# )
	# 	i+=1
	# end
	com = georges.commandes.create(
		:assurance => 0,
		:status => 0,
		:caution => 1,
		:ean => (SecureRandom.random_number *10**14).to_s[0,13],
		:tbk_id => 1
	)
end