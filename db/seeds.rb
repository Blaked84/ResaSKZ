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
	:description => " Du 14 au 21 janvier 2017, tous les TBK ")



puts "Categories"
listecategorries=["Pack de base","Options au food pack standard","Transport Aller/Retour","Transport Aller","Transport Retour","Matériel de Glisse","Animations complémentaires","Boulangerie","Assurances"]
listecategorries.each {|c| Categorie.create(:nom =>c) }
Configurable[:id_cat_assurance]=Categorie.find_by( nom: 'Assurances').id.to_s
Configurable[:id_cat_busaller]=Categorie.find_by( nom: 'Transport Aller').id.to_s
Configurable[:id_cat_busretour]=Categorie.find_by( nom: 'Transport Retour').id.to_s
Configurable[:id_pack]=Categorie.find_by( nom: 'Pack de base').id.to_s

puts "Date paiements"
Configurable[:echeances_paiement1]=DateTime.new(2017,10,31)
Configurable[:echeances_paiement2]=DateTime.new(2017,11,10)
Configurable[:echeances_paiement3]=DateTime.new(2017,11,20)
# puts "UserTypes"
# Usertype.create(:)

puts "Glisse"
Glisse.create(nom: 'Ski')
Glisse.create(nom: 'Snowboard')

puts "Genres"
Genre.create(:sexe => "H", :nom_cas => "male", :nom_complet => "Homme")
Genre.create(:sexe => "F", :nom_cas => "female", :nom_complet => "Femme")

#Mensuration
puts "taillevetements"
listevet=["S","M","L","XL","XXL"]
listevet.each do |c|
	Taillevetement.create(:name =>c)
end
puts "tour tete"
listetrtete=["56-59 cm","59-62 cm"]
listetrtete.each do |c|
	TourTete.create(:mesure =>c)
end
puts "Niveau SKI"
listeniveau=["Débutant","Intermédiaire","Avancé"]
listeniveau.each do |c|
	NiveauSki.create(:nom =>c)
end
puts "Gammes Ski"
listegammes=["Ecoski","Découverte","Sensation","Excellence"]
listegammes.each do |c|
	Gamme.create(:nom =>c)
end
puts "Type produits (anim's)"
listetproduits=["Slalom","Derby","Boardercross"]
listetproduits.each do |c|
	TypeProduct.create(:nom =>c)
end
puts "tbk"
listet=[["Kanak","Karlsruhe","ka"],["Siber's","Metz","me"],["Clun's","Cluny","cl"],["Chalon's","Chalons-en-Champagne","ch"],["Bordel's","Bordeaux","bo"],["KIN","Aix-en-Provence","ai"],["Boquette","Angers","an"],["Birse","Lille","li"],["P3","Paris","pa"]].sort
listet.each do |c|
	Tbk.create(:nom =>c[0], :nom_pecs => c[1], :diminutif=>c[2])
end

listeproduits=[["Pack PG",29500,0,DateTime.new(2017,10,30),".onscrit et de 216 à 214",1,1],
["Pack Archi",34500,0,DateTime.new(2017,10,30),"promo 213 et antérieures",1,1],
["Pack Extérieurs",34500,0,DateTime.new(2017,10,30),"Pour les non Gadz",1,1],
["Food Pack avec Porc",0,0,DateTime.new(2017,10,30),"",1,2],
["Food Pack sans Porc",0,0,DateTime.new(2017,10,30),"",1,2],
["Baguette",350,0,DateTime.new(2017,10,30),"Le pack baguette : 1 baguette tous les matins pour 3€50",1,8],
["Croissant",330,0,DateTime.new(2017,10,30),"Le pack croissant : 1 croissant tous les matins pour 3€30",1,8],
["Pain au chocolat",360,0,DateTime.new(2017,10,30),"Le pack chocolatin's : 1 chocolatine tous les matins pour 3€60",1,8],
["Pack Saucisson",1000,0,DateTime.new(2017,10,30),"Le pack saucisson : 5 saucissons pour 10€",1,8],
["Pack Fromage",1000,0,DateTime.new(2017,10,30),"Le pack fromage : 5 fromages pour 10€",1,8],
["Angers A/R",9000,0,DateTime.new(2017,10,30),"",1,3],
["Bordeaux A/R",9000,0,DateTime.new(2017,10,30),"",1,3],
["Paris A/R",9000,0,DateTime.new(2017,10,30),"",1,3],
["Metz A/R",8500,0,DateTime.new(2017,10,30),"",1,3],
["Cluny A/R",6000,0,DateTime.new(2017,10,30),"",1,3],
["Aix-en-Provence A/R",6000,0,DateTime.new(2017,10,30),"",1,3],
["Chalons A/R",8000,0,DateTime.new(2017,10,30),"",1,3],
["Lille A/R",8500,0,DateTime.new(2017,10,30),"",1,3],
["Je viendrai par mes propres moyens A/R",0,0,DateTime.new(2017,10,30),"",1,3],
["Lille aller",4750,0,DateTime.new(2017,10,30),"",1,4],
["Angers aller",4500,0,DateTime.new(2017,10,30),"",1,4],
["Bordeaux  aller",4500,0,DateTime.new(2017,10,30),"",1,4],
["Paris  aller",4250,0,DateTime.new(2017,10,30),"",1,4],
["Metz  aller",4250,0,DateTime.new(2017,10,30),"",1,4],
["Cluny aller",3500,0,DateTime.new(2017,10,30),"",1,4],
["Aix-en-Provence aller",3000,0,DateTime.new(2017,10,30),"",1,4],
["Chalons aller",4000,0,DateTime.new(2017,10,30),"",1,4],
["Je viendrai par mes propres moyens aller",0,0,DateTime.new(2017,10,30),"",1,4],
["Lille retour",4750,0,DateTime.new(2017,10,30),"",1,5],
["Angers retour",4500,0,DateTime.new(2017,10,30),"",1,5],
["Bordeaux retour",4500,0,DateTime.new(2017,10,30),"",1,5],
["Paris retour",4250,0,DateTime.new(2017,10,30),"",1,5],
["Metz retour",4250,0,DateTime.new(2017,10,30),"",1,5],
["Cluny retour",3500,0,DateTime.new(2017,10,30),"",1,5],
["Aix-en-Provence retour",3000,0,DateTime.new(2017,10,30),"",1,5],
["Chalons retour",4000,0,DateTime.new(2017,10,30),"",1,5],
["Je viendrai par mes propres moyens aller",0,0,DateTime.new(2017,10,30),"",1,5],
["Ecoski - Skis + Chaussures",5000,0,DateTime.new(2017,10,30),"",1,6,1],
["Ecoski - Skis seul",4500,0,DateTime.new(2017,10,30),"",1,6,1],
["Ecoski - Chaussures seules",3500,0,DateTime.new(2017,10,30),"",1,6,1],
["Découverte - Skis + Chaussures",6500,0,DateTime.new(2017,10,30),"",1,6,2],
["Découverte - Skis seul",5900,0,DateTime.new(2017,10,30),"",1,6,2],
["Découverte - Chaussures seules",4500,0,DateTime.new(2017,10,30),"",1,6,2],
["Sensation - Skis + Chaussures",8200,0,DateTime.new(2017,10,30),"",1,6,3],
["Sensation - Skis seul",7400,0,DateTime.new(2017,10,30),"",1,6,3],
["Sensation - Chaussures seules",6100,0,DateTime.new(2017,10,30),"",1,6,3],
["Excellence - Skis + Chaussures",11600,0,DateTime.new(2017,10,30),"",1,6,4],
["Excellence - Skis seul",11100,0,DateTime.new(2017,10,30),"",1,6,4],
["Excellence - Chaussures seules",9800,0,DateTime.new(2017,10,30),"",1,6,4],
["Assurance Annulation",2000,0,DateTime.new(2017,10,30),"Permet en cas de problème majeur (blessure, décès d’un proche…) justifié par un document officiel 48h avant le départ de se faire rembourser du prix du package (hors coût de l’assurance).",1,9],
["Assistance rapatriement/bagages",2000,0,DateTime.new(2017,10,30),"Permet en cas de blessures lors du séjour d’être remboursé des frais de rapatriement jusqu’au lieu de soin et/ou de domicile. (exemple barquette + frais pisteurs en cas de rapatriement sur les pistes, rapatriement par hélicoptère…). Attention elle ne sera pas valable en cas de rapatriement hors pistes ou en cas de comportement non autorisé.",1,9],
["Assurance interruption ski-pass",1500,0,DateTime.new(2017,10,30),"Permet en cas de problème majeur (ex : blessure pendant votre semaine) justifié par un document officiel/médical de se faire rembourser le prix du forfait et du matériel au pro rata des jours non-skiés.",1,9],
["Tout compris",3300,0,DateTime.new(2017,10,30),"Les trois assurances précédentes cumulées",1,9],
["Pas d'assurance",0,0,DateTime.new(2017,10,30),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",1,9],
["RCC",1000,0,DateTime.new(2017,10,30),"Tournée des bars attaché par groupe",1,7],
["Freeride",0,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Raquette",0,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Biathlon",500,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Handiski",0,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Telemark",1000,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Sortie rando",1500,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Sortie ski",0,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Initiation snow",0,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Initiation ARVA",0,0,DateTime.new(2017,10,30),"",1,7,nil,nil,true],
["Slalom Ski Homme",0,0,DateTime.new(2017,10,30),"",1,7,nil,1],
["Slalom Ski Femme",0,0,DateTime.new(2017,10,30),"",1,7,nil,1],
["Slalom Snow Homme",0,0,DateTime.new(2017,10,30),"",1,7,nil,1],
["Slalom Snow Femme",0,0,DateTime.new(2017,10,30),"",1,7,nil,1],
["Derby Ski Homme",0,0,DateTime.new(2017,10,30),"",1,7,nil,2],
["Derby Ski Femme",0,0,DateTime.new(2017,10,30),"",1,7,nil,2],
["Derby Snow Homme",0,0,DateTime.new(2017,10,30),"",1,7,nil,2],
["Derby Snow Femme",0,0,DateTime.new(2017,10,30),"",1,7,nil,2],
["Boardercross Ski Homme",0,0,DateTime.new(2017,10,30),"",1,7,nil,3],
["Boardercross Ski Femme",0,0,DateTime.new(2017,10,30),"",1,7,nil,3],
["Boardercross Snow Homme",0,0,DateTime.new(2017,10,30),"",1,7,nil,3],
["Boardercross Snow Femme",0,0,DateTime.new(2017,10,30),"",1,7,nil,3],
["Snakegli's",0,0,DateTime.new(2017,10,30),"",1,7],
["Show-competition freestyle",0,0,DateTime.new(2017,10,30),"",1,7],
["Descente aux flambeaux",0,0,DateTime.new(2017,10,30),"",1,7]]


listeproduits.each do |c|
	produits_hash = {
		:name => c[0],
		:price => c[1],
		:stock => c[2],
		:echeance => c[3],
		:description => c[4],
		:event_id => c[5],
		:categorie_id => c[6],
                :gamme_id => c[7],
                :type_product_id => c[8],
                :votable => c[9],
	}.reject { |k, v| v.nil? }

	a=Product.create(produits_hash)
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
        tour_tete_id: 1,
        niveau_ski_id: 1,
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
