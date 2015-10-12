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
	:description => " Du 18 au 25 avril 2015, Boquette, Bordel'sss, Siber'sss, Kanak,P3 ")
# Event.create(
# 	:name => "SKZ Semaine 2",
# 	:description => " Du 25 avril au 2 mai 2015, Birse, Chalon'sss, Clun'sss,KIN")


puts "Categories"
listecategorries=["Pack de base","Options au food pack standard","Transport Aller","Transport Retour","Matériel de Glisse","Animations complémentaires","Boulangerie","Assurances"]
listecategorries.each {|c| Categorie.create(:nom =>c) }
Configurable[:id_cat_assurance]=Categorie.find_by( nom: 'Assurances').id.to_s
Configurable[:id_cat_busaller]=Categorie.find_by( nom: 'Transport Aller').id.to_s
Configurable[:id_cat_busretour]=Categorie.find_by( nom: 'Transport Retour').id.to_s
Configurable[:id_pack]=Categorie.find_by( nom: 'Pack de base').id.to_s

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

listeproduits=[["Pack PG",29000,0,DateTime.new(2015,11,1),"De 215 à 213",1,1],
["Pack Archi",34000,0,DateTime.new(2015,11,1),"A partir de 212",1,1],
["Pack Extérieurs",34000,0,DateTime.new(2015,11,1),"Pour les non Gadz",1,1],
["Food Pack sans Porc",0,0,DateTime.new(2015,11,1),"",1,2],
["Baguette",0,0,DateTime.new(2015,11,1),"1 par jour (du dimanche au vendredi)",1,7],
["Croissant",0,0,DateTime.new(2015,11,1),"1 par jour (du dimanche au vendredi)",1,7],
["Chocolatine",0,0,DateTime.new(2015,11,1),"1 par jour (du dimanche au vendredi)",1,7],
["Pack Saucisson",1000,0,DateTime.new(2015,11,1),"Pour 5 saucissons",1,2],
["Pack Fromage",0,0,DateTime.new(2015,11,1),"",1,],
["Paris aller simple",4700,0,DateTime.new(2015,11,1),"",1,3],
["Paris aller-retour",8500,0,DateTime.new(2015,11,1),"",1,4],
["Lille aller simple",5300,0,DateTime.new(2015,11,1),"",1,3],
["Lille aller-retour",9500,0,DateTime.new(2015,11,1),"",1,4],
["Cluny aller simple",3600,0,DateTime.new(2015,11,1),"",1,3],
["Cluny aller-retour",6500,0,DateTime.new(2015,11,1),"",1,4],
["Bordeaux aller simple",5300,0,DateTime.new(2015,11,1),"",1,3],
["Bordeaux aller-retour",9500,0,DateTime.new(2015,11,1),"",1,4],
["Aix en provence aller simple",3100,0,DateTime.new(2015,11,1),"",1,3],
["Aix en provence aller-retour",5500,0,DateTime.new(2015,11,1),"",1,4],
["Metz aller simple",4700,0,DateTime.new(2015,11,1),"",1,3],
["Metz aller-retour",8500,0,DateTime.new(2015,11,1),"",1,4],
["Angers aller simple",5300,0,DateTime.new(2015,11,1),"",1,3],
["Angers aller-retour",9500,0,DateTime.new(2015,11,1),"",1,4],
["Châlons aller simple",4700,0,DateTime.new(2015,11,1),"",1,3],
["Châlons aller-retour",8500,0,DateTime.new(2015,11,1),"",1,4],
["Eco - Pack Ski Complet",5300,0,DateTime.new(2015,11,1),"",1,5],
["Eco - Chaussures ski seules",3300,0,DateTime.new(2015,11,1),"",1,5],
["Eco - Skis seuls",4500,0,DateTime.new(2015,11,1),"",1,5],
["Découverte - Pack Complet Ski",6300,0,DateTime.new(2015,11,1),"",1,5],
["Découverte - Pack Complet Surf",6300,0,DateTime.new(2015,11,1),"",1,5],
["Découverte - Chaussures ski seules",4200,0,DateTime.new(2015,11,1),"",1,5],
["Découverte - Chaussures surf seules",4200,0,DateTime.new(2015,11,1),"",1,5],
["Découverte - Skis seuls",5800,0,DateTime.new(2015,11,1),"",1,5],
["Découverte - Snow seul",5800,0,DateTime.new(2015,11,1),"",1,5],
["Sensation - Pack Complet Ski",7900,0,DateTime.new(2015,11,1),"",1,5],
["Sensation - Pack Complet Surf",7900,0,DateTime.new(2015,11,1),"",1,5],
["Sensation - Chaussures ski seules",5800,0,DateTime.new(2015,11,1),"",1,5],
["Sensation - Chaussures surf seules",5800,0,DateTime.new(2015,11,1),"",1,5],
["Sensation - Skis seuls",7200,0,DateTime.new(2015,11,1),"",1,5],
["Sensation - Snow seul",7200,0,DateTime.new(2015,11,1),"",1,5],
["Excellence - Pack Complet Ski",11300,0,DateTime.new(2015,11,1),"",1,5],
["Excellence - Pack Complet Surf",11300,0,DateTime.new(2015,11,1),"",1,5],
["Excellence - Chaussures ski seules",9400,0,DateTime.new(2015,11,1),"",1,5],
["Excellence - Skis seuls",10900,0,DateTime.new(2015,11,1),"",1,5],
["Excellence - Snow seul",10900,0,DateTime.new(2015,11,1),"",1,5],
["Annulation",1800,0,DateTime.new(2015,11,1),"Annulation jusqu'à 48h avant le séjour si condition valable (voir conditions sur le site)",1,8],
["Assistance rapatriement bagages",1800,0,DateTime.new(2015,11,1),"Permet en cas de blessures lors du séjour d’être remboursé des frais de rapatriement jusqu’au lieu de soin et/ou de domicile",1,8],
["Inter Ski Pass",1200,0,DateTime.new(2015,11,1),"Permet en cas de problème majeur (ex : blessure pendant votre semaine) justifié par un document officiel/médical de se faire rembourser le prix du forfait au pro rata des jours non-skiés.",1,8],
["Tout compris",3500,0,DateTime.new(2015,11,1),"Les trois précédentes cumulées",1,8],
["Pas d'assurance",0,0,DateTime.new(2015,11,1),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",1,8],
["RCC",1050,0,DateTime.new(2015,11,1),"Pars faire le tour des bars de Risoul attaché à tes potes",1,6],
["Carte Gold Grotte du Yéti",5000,0,DateTime.new(2015,11,1),"Charge ta Gold card de la Grotte du Yéti et accède à des prix incroyable pour tes consos",1,6],
["Initiation Telemark",0,0,DateTime.new(2015,11,1),"Attention ne comprend que les cours ESF (pas la location du matériel)",1,6],
["Initiation ARVA",0,0,DateTime.new(2015,11,1),"Initiation à l'utilisation du système ARVA encadrée par l'ESF",1,6]]

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

# Categorie.find_by( nom: 'Supplément food').products.each do |p|
# 	p.update_attribute(:max_par_personne,1)
# end

Categorie.find_by( nom: 'Animations complémentaires').products.each do |p|
	p.update_attribute(:max_par_personne,1)
end

Categorie.find_by( nom: 'Boulangerie').products.each do |p|
	p.update_attribute(:max_par_personne,5)
end

Categorie.find_by( nom: 'Options au food pack standard').update_attribute(:max_par_personne,1)
Categorie.find_by( nom: 'Pack de base').update_attribute(:max_par_personne,1)
# Categorie.find_by( nom: 'Transport Aller/Retour').update_attribute(:max_par_personne,1)
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