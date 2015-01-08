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
listecategorries=["Pack","Options au food pack standard","Transport Aller/Retour","Transport Aller","Transport Retour","Matériel de Glisse","Animations complémentaires","Boulangerie","Assurances","Supplément food"]
listecategorries.each {|c| Categorie.create(:nom =>c) }
Configurable[:id_cat_assurance]=Categorie.find_by( nom: 'Assurances').id.to_s
Configurable[:id_cat_busaller]=Categorie.find_by( nom: 'Transport Aller').id.to_s
Configurable[:id_cat_busretour]=Categorie.find_by( nom: 'Transport Retour').id.to_s
Configurable[:id_pack]=Categorie.find_by( nom: 'Pack').id.to_s

puts "Date paiements"
Configurable[:echeances_paiement1]=DateTime.new(2013,2,9)
Configurable[:echeances_paiement2]=DateTime.new(2013,2,23)
Configurable[:echeances_paiement3]=DateTime.new(2013,3,16)
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
listet=[["Kanak","Karlsruhe","ka"],["Siber's","Metz","me"],["Clun's","Cluny","cl"],["Chalon's","Chalon-en-Champagne","ch"],["Bordel's","Bordeaux","bo"],["KIN","Aix-en-Provence","ai"],["Boquette","Angers","an"],["Birse","Lille","li"],["P3","Paris","pa"]].sort
listet.each do |c|
	Tbk.create(:nom =>c[0], :nom_pecs => c[1], :diminutif=>c[2])
end

listeproduits=[["Pack PG",29900,"",DateTime.new(2015,3,14),"De 214 à 212",1,1],
["Pack Archi",35000,"",DateTime.new(2015,3,14),"A partir de 211",1,1],
["Pack Extérieurs",35000,"",DateTime.new(2015,3,14),"Pour les non Gadz",1,1],
["Food Pack avec Porc",0,"",DateTime.new(2015,3,14),"",1,2],
["Food Pack sans Porc",0,"",DateTime.new(2015,3,14),"",1,2],
["Baguette",522,"",DateTime.new(2015,3,14),"Par jour du dimanche au vendredi",1,8],
["Croissant",390,"",DateTime.new(2015,3,14),"Par jour du dimanche au vendredi",1,8],
["Pain au chocolat",450,"",DateTime.new(2015,3,14),"Par jour du dimanche au vendredi",1,8],
["Pack Saucisson",1000,"",DateTime.new(2015,3,14),"Pour 5 saucissons",1,10],
["Pack Fromage",1000,"",DateTime.new(2015,3,14),"Pour 5 fromages",1,10],
["Angers A/R",9000,"",DateTime.new(2015,3,14),"",1,3],
["Bordeaux A/R",9800,"",DateTime.new(2015,3,14),"",1,3],
["Paris A/R",9000,"",DateTime.new(2015,3,14),"",1,3],
["Metz A/R",9000,"",DateTime.new(2015,3,14),"",1,3],
["Angers aller",4750,"",DateTime.new(2015,3,14),"",1,4],
["Bordeaux  aller",5150,"",DateTime.new(2015,3,14),"",1,4],
["Paris  aller",4750,"",DateTime.new(2015,3,14),"",1,4],
["Metz  aller",4750,"",DateTime.new(2015,3,14),"",1,4],
["Angers retour",4750,"",DateTime.new(2015,3,14),"",1,5],
["Bordeaux retour",5150,"",DateTime.new(2015,3,14),"",1,5],
["Paris retour",4750,"",DateTime.new(2015,3,14),"",1,5],
["Metz retour",4750,"",DateTime.new(2015,3,14),"",1,5],
["Eco - Pack Ski Complet",5300,"",DateTime.new(2015,3,14),"",1,6],
["Eco - Chaussures ski seules",3300,"",DateTime.new(2015,3,14),"",1,6],
["Eco - Skis seuls",4800,"",DateTime.new(2015,3,14),"",1,6],
["Découverte - Pack Complet Ski",6400,"",DateTime.new(2015,3,14),"",1,6],
["Découverte - Pack Complet Surf",6400,"",DateTime.new(2015,3,14),"",1,6],
["Découverte - Chaussures ski seules",4200,"",DateTime.new(2015,3,14),"",1,6],
["Découverte - Chaussures surf seules",4200,"",DateTime.new(2015,3,14),"",1,6],
["Découverte - Skis seuls",6000,"",DateTime.new(2015,3,14),"",1,6],
["Découverte - Snow seul",6000,"",DateTime.new(2015,3,14),"",1,6],
["Sensation - Pack Complet Ski",7900,"",DateTime.new(2015,3,14),"",1,6],
["Sensation - Pack Complet Surf",7900,"",DateTime.new(2015,3,14),"",1,6],
["Sensation - Chaussures ski seules",5800,"",DateTime.new(2015,3,14),"",1,6],
["Sensation - Chaussures surf seules",5800,"",DateTime.new(2015,3,14),"",1,6],
["Sensation - Skis seuls",7400,"",DateTime.new(2015,3,14),"",1,6],
["Sensation - Snow seul",7400,"",DateTime.new(2015,3,14),"",1,6],
["Annulation",1700,"",DateTime.new(2015,3,14),"Annulation jusqu'à 48h avant le séjour si condition valable (voir conditions sur le site)",1,9],
["Assistance rapatriement bagages",1700,"",DateTime.new(2015,3,14),"Rapatriement sur les pistes, en dehors des pistes et rapatriement chez vous avec vos bagages si besoin",1,9],
["Inter Ski Pass",1100,"",DateTime.new(2015,3,14),"En cas d'obligation de départ pour des raisons valables, remboursement de 35 euros par jour perdu (maximum remboursable 5 jours, voir précisions sur le site)",1,9],
["Tout compris",3300,"",DateTime.new(2015,3,14),"Les trois précédentes cumulées",1,9],
["Pas d'assurance",0,"",DateTime.new(2015,3,14),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",1,9],
["RCC",1100,"",DateTime.new(2015,3,14),"Tournée des bars attaché par groupe",1,7],
["Repas d'Altitude",2100,"",DateTime.new(2015,3,14),"Repas (fondue bourgignone 200g de viande, frites à volonté, 1/2 litre vin) + descente aux fambeaux + feu d'artifice",1,7],
["Espace Killy",3500,"",DateTime.new(2015,3,14),"Extention de forfait à l'Espace Killy",1,7],
["Pack PG",29900,"",DateTime.new(2015,3,14),"De 214 à 212",2,1],
["Pack Archi",35000,"",DateTime.new(2015,3,14),"A partir de 211",2,1],
["Pack Extérieurs",35000,"",DateTime.new(2015,3,14),"Pour les non Gadz",2,1],
["Food Pack avec Porc",0,"",DateTime.new(2015,3,14),"",2,2],
["Food Pack sans Porc",0,"",DateTime.new(2015,3,14),"",2,2],
["Baguette",522,"",DateTime.new(2015,3,14),"Par jour du dimanche au vendredi",2,8],
["Croissant",390,"",DateTime.new(2015,3,14),"Par jour du dimanche au vendredi",2,8],
["Pain au chocolat",450,"",DateTime.new(2015,3,14),"Par jour du dimanche au vendredi",2,8],
["Pack Saucisson",1000,"",DateTime.new(2015,3,14),"Pour 5 saucissons",2,10],
["Pack Fromage",1000,"",DateTime.new(2015,3,14),"Pour 5 fromages",2,10],
["Châlons",8400,"",DateTime.new(2015,3,14),"",2,3],
["Cluny",7000,"",DateTime.new(2015,3,14),"",2,3],
["Aix-en-Provence",7800,"",DateTime.new(2015,3,14),"",2,3],
["Lille",9800,"",DateTime.new(2015,3,14),"",2,3],
["Châlon aller",4450,"","","Supplément logistique",2,4],
["Cluny aller",3750,"","","Supplément logistique",2,4],
["Aix-en-Provence aller",4150,"","","Supplément logistique",2,4],
["Lille aller",5150,"","","Supplément logistique",2,4],
["Châlon retour",4450,"","","Supplément logistique",2,5],
["Cluny retour",3750,"","","Supplément logistique",2,5],
["Aix-en-Provence retour",4150,"","","Supplément logistique",2,5],
["Lille retour",5150,"","","Supplément logistique",2,5],
["Découverte - Pack Ski Complet",5300,"",DateTime.new(2015,3,14),"",2,6],
["Découverte - Chaussures ski seules",3300,"",DateTime.new(2015,3,14),"",2,6],
["Découverte - Skis seuls",4800,"",DateTime.new(2015,3,14),"",2,6],
["Eco - Pack Complet Ski",6400,"",DateTime.new(2015,3,14),"",2,6],
["Eco - Pack Complet Surf",6400,"",DateTime.new(2015,3,14),"",2,6],
["Eco - Chaussures ski seules",4200,"",DateTime.new(2015,3,14),"",2,6],
["Eco - Chaussures surf seules",4200,"",DateTime.new(2015,3,14),"",2,6],
["Eco - Skis seuls",6000,"",DateTime.new(2015,3,14),"",2,6],
["Eco - Snow seul",6000,"",DateTime.new(2015,3,14),"",2,6],
["Sensation - Pack Complet Ski",7900,"",DateTime.new(2015,3,14),"",2,6],
["Sensation - Pack Complet Surf",7900,"",DateTime.new(2015,3,14),"",2,6],
["Sensation - Chaussures ski seules",5800,"",DateTime.new(2015,3,14),"",2,6],
["Sensation - Chaussures surf seules",5800,"",DateTime.new(2015,3,14),"",2,6],
["Sensation - Skis seuls",7400,"",DateTime.new(2015,3,14),"",2,6],
["Sensation - Snow seul",7400,"",DateTime.new(2015,3,14),"",2,6],
["Annulation",1700,"",DateTime.new(2015,3,14),"Annulation jusqu'à 48h avant le séjour si condition valable (voir conditions sur le site)",2,9],
["Assistance rapatriement bagages",1700,"",DateTime.new(2015,3,14),"Rapatriement sur les pistes, en dehors des pistes et rapatriement chez vous avec vos bagages si besoin",2,9],
["Inter Ski Pass",1100,"",DateTime.new(2015,3,14),"En cas d'obligation de départ pour des raisons valables, remboursement de 35 euros par jour perdu (maximum remboursable 5 jours, voir précisions sur le site)",2,9],
["Tout compris",3300,"",DateTime.new(2015,3,14),"Les trois précédentes cumulées",2,9],
["Pas d'assurance",0,"",DateTime.new(2015,3,14),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",2,9],
["RCC",1100,"",DateTime.new(2015,3,14),"Tournée des bars attaché par groupe",2,7],
["Repas d'Altitude",2100,"",DateTime.new(2015,3,14),"Repas (fondue bourgignone 200g de viande, frites à volonté, 1/2 litre vin) + descente aux fambeaux + feu d'artifice",2,7],
["Espace Killy",3500,"",DateTime.new(2015,3,14),"Extention de forfait à l'Espace Killy",2,7]]

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

puts "Configuration des max"
Categorie.find_by( nom: 'Assurances').products.each do |p|
	p.update_attribute(:max_par_personne,1)
end

Categorie.find_by( nom: 'Supplément food').products.each do |p|
	p.update_attribute(:max_par_personne,1)
end

Categorie.find_by( nom: 'Animations complémentaires').products.each do |p|
	p.update_attribute(:max_par_personne,1)
end

Categorie.find_by( nom: 'Boulangerie').products.each do |p|
	p.update_attribute(:max_par_personne,5)
end

Categorie.find_by( nom: 'Options au food pack standard').update_attribute(:max_par_personne,1)
Categorie.find_by( nom: 'Pack').update_attribute(:max_par_personne,1)
Categorie.find_by( nom: 'Transport Aller/Retour').update_attribute(:max_par_personne,1)
Categorie.find_by( nom: 'Transport Aller').update_attribute(:max_par_personne,1)
Categorie.find_by( nom: 'Transport Retour').update_attribute(:max_par_personne,1)
Categorie.find_by( nom: 'Matériel de Glisse').update_attribute(:max_par_personne,1)


user_gorgu=User.create!(
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

user_admin=User.create!(
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