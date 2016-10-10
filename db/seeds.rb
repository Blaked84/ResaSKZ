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

listeproduits=[["Pack PG",29900,0,DateTime.new(2016,10,30),".onscrit et de 215 à 213",1,1],
["Pack Archi",35000,0,DateTime.new(2016,10,30),"A partir de 212",1,1],
["Pack Extérieurs",35000,0,DateTime.new(2016,10,30),"Pour les non Gadz",1,1],
["Food Pack avec Porc",0,0,DateTime.new(2016,10,30),"",1,2],
["Food Pack sans Porc",0,0,DateTime.new(2016,10,30),"",1,2],
["Baguette",330,0,DateTime.new(2016,10,30),"Pour un pack baguettes",1,8],
["Croissant",330,0,DateTime.new(2016,10,30),"Pour un pack croissants",1,8],
["Pain au chocolat",360,0,DateTime.new(2016,10,30),"Pour un pack pain au chocolat",1,8],
["Pack Saucisson",1000,0,DateTime.new(2016,10,30),"Pour X saucissons",1,8],
["Pack Fromage",800,0,DateTime.new(2016,10,30),"Pour 3 fromages de 200g",1,8],
["Angers A/R",9000,0,DateTime.new(2016,10,30),"",1,3],
["Bordeaux A/R",9000,0,DateTime.new(2016,10,30),"",1,3],
["Paris A/R",8500,0,DateTime.new(2016,10,30),"",1,3],
["Metz A/R",8500,0,DateTime.new(2016,10,30),"",1,3],
["Angers aller",4500,0,DateTime.new(2016,10,30),"",1,4],
["Bordeaux  aller",4500,0,DateTime.new(2016,10,30),"",1,4],
["Paris  aller",4250,0,DateTime.new(2016,10,30),"",1,4],
["Metz  aller",4250,0,DateTime.new(2016,10,30),"",1,4],
["Angers retour",4500,0,DateTime.new(2016,10,30),"",1,5],
["Bordeaux retour",4500,0,DateTime.new(2016,10,30),"",1,5],
["Paris retour",4250,0,DateTime.new(2016,10,30),"",1,5],
["Metz retour",4250,0,DateTime.new(2016,10,30),"",1,5],
["Bronze - Pack Ski Complet",5400,0,DateTime.new(2016,10,30),"",1,6],
["Bronze - Chaussures ski seules",2200,0,DateTime.new(2016,10,30),"",1,6],
["Bronze - Skis seuls",4400,0,DateTime.new(2016,10,30),"",1,6],
["Argent - Pack Complet Ski",6500,0,DateTime.new(2016,10,30),"",1,6],
["Argent - Pack Complet Surf",6500,0,DateTime.new(2016,10,30),"",1,6],
["Argent - Chaussures ski seules",2900,0,DateTime.new(2016,10,30),"",1,6],
["Argent - Chaussures surf seules",2900,0,DateTime.new(2016,10,30),"",1,6],
["Argent - Skis seuls",5500,0,DateTime.new(2016,10,30),"",1,6],
["Argent - Snow seul",5500,0,DateTime.new(2016,10,30),"",1,6],
["Or - Pack Complet Ski",7900,0,DateTime.new(2016,10,30),"",1,6],
["Or - Pack Complet Surf",7900,0,DateTime.new(2016,10,30),"",1,6],
["Or - Chaussures ski seules",2900,0,DateTime.new(2016,10,30),"",1,6],
["Or - Chaussures surf seules",2900,0,DateTime.new(2016,10,30),"",1,6],
["Or - Skis seuls",7000,0,DateTime.new(2016,10,30),"",1,6],
["Or - Snow seul",7000,0,DateTime.new(2016,10,30),"",1,6],
["Annulation",1900,0,DateTime.new(2016,10,30),"Annulation jusqu'à 48h avant le séjour si condition valable (voir conditions sur le site)",1,9],
["Assistance rapatriement bagages",1700,0,DateTime.new(2016,10,30),"Rapatriement sur les pistes, en dehors des pistes et rapatriement chez vous avec vos bagages si besoin",1,9],
["Bris et Vol",1200,0,DateTime.new(2016,10,30),"Pour couvrir les bris et vols",1,9],
["Tout compris",3300,0,DateTime.new(2016,10,30),"Les trois précédentes cumulées",1,9],
["Pas d'assurance",0,0,DateTime.new(2016,10,30),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",1,9],
["RCC",1000,0,DateTime.new(2016,10,30),"Tournée des bars attaché par groupe",1,7],
["Pack Chill",2500,0,DateTime.new(2016,10,30),"Un Lamzac à un prix PG !",1,7]]

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

personne_gorgu=Personne.create!(
	nom:"Gorgu",
	prenom:"Gadz",
	phone:"+33601803255",
	email:"gorgu@gadz.org",
	assurance: false,
	created_at: DateTime.now,
	updated_at: DateTime.now,
	user_id: 1,
	adresse: "Foy'sss",
	ville: "Birse",
	codepostal: "60214",
	bucque: "The gorgu",
	fams: "0",
	promo: "li214",
	idGadzOrg: "",
	taille: 214,
	pointure: 60,
	taillevetement_id: 2,
	complement: "",
	pnom: "Maman gorgu",
	pprenom: "Gadz",
	plienparente: "mère",
	padresse: "Kfet",
	pville: "KIN",
	pcodepostal: "00000",
	type_pers: "Gadz",
	genre_id: 1,
	)