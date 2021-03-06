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
	:description => " Du 13 au 20 janvier 2017, tous les TBK ")



puts "Categories"
listecategorries=["Pack de base","Options au food pack standard","Transport Aller/Retour","Transport Aller","Transport Retour","Matériel de Glisse","Animations complémentaires","Boulangerie","Assurances","Options supplémentaires"]
listecategorries.each {|c| Categorie.create(:nom =>c) }
Configurable[:id_cat_assurance]=Categorie.find_by( nom: 'Assurances').id.to_s
Configurable[:id_cat_busaller]=Categorie.find_by( nom: 'Transport Aller').id.to_s
Configurable[:id_cat_busretour]=Categorie.find_by( nom: 'Transport Retour').id.to_s
Configurable[:id_pack]=Categorie.find_by( nom: 'Pack de base').id.to_s

puts "Date paiements"
Configurable[:echeances_paiement1]=DateTime.new(2017,11,5)
Configurable[:echeances_paiement2]=DateTime.new(2017,11,20)
Configurable[:echeances_paiement3]=DateTime.new(2017,12,11)
# puts "UserTypes"
# Usertype.create(:)

puts "Glisse"
Glisse.create(nom: 'Ski')
Glisse.create(nom: 'Snowboard')

puts "Genres"
Genre.create(:sexe => "H", :nom_cas => "male", :nom_complet => "Homme")
Genre.create(:sexe => "F", :nom_cas => "female", :nom_complet => "Femme")

puts "Type Resids"
listeres=["Anim's +","Anim's","Calme"]
listeres.each do |c|
  Typeresid.create(:name =>c)
end

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

puts "Options supplémentaires"
liste_couleurs_cadre = ["Bleu","Rouge","Rose","Blanc","Jaune"]
liste_couleurs_verre = ["Bleu","Noir","Rouge"]
liste_options_sups = ["Masque Ryft"]
liste_options_sups.each do |c|
  liste_couleurs_cadre.each do |cc|
    liste_couleurs_verre.each do |cv|
      OptionSup.create(:nom => c, couleur_cadre: cc, couleur_verre: cv)
    end
  end
end

puts "tbk"
listet=[["Kanak","Karlsruhe","ka"],["Siber's","Metz","me"],["Clun's","Cluny","cl"],["Chalon's","Chalons-en-Champagne","ch"],["Bordel's","Bordeaux","bo"],["KIN","Aix-en-Provence","ai"],["Boquette","Angers","an"],["Birse","Lille","li"],["P3","Paris","pa"]].sort
listet.each do |c|
	Tbk.create(:nom =>c[0], :nom_pecs => c[1], :diminutif=>c[2])
end

puts "Produits"
listeproduits=[["Pack PG",29500,0,DateTime.new(2017,11,5),".onscrit et de 216 à 214",1,1],
["Pack Archi",34500,0,DateTime.new(2017,11,5),"promo 213 et antérieures",1,1],
["Pack Extérieurs",34500,0,DateTime.new(2017,11,5),"Pour les non Gadz",1,1],
["Food Pack avec Porc",0,0,DateTime.new(2017,11,5),"",1,2],
["Food Pack sans Porc",0,0,DateTime.new(2017,11,5),"",1,2],
["Baguette",350,0,DateTime.new(2017,11,5),"Le pack baguette : 1 baguette tous les matins pour 3€50",1,8],
["Croissant",330,0,DateTime.new(2017,11,5),"Le pack croissant : 1 croissant tous les matins pour 3€30",1,8],
["Pain au chocolat",360,0,DateTime.new(2017,11,5),"Le pack pain choc’s : 1 chocolatine tous les matins pour 3€60",1,8],
["Pack Saucisson",1000,0,DateTime.new(2017,11,5),"Le pack saucisson : 5 saucissons pour 10€",1,8],
["Pack Fromage",1000,0,DateTime.new(2017,11,5),"Le pack fromage : 5 fromages pour 10€",1,8],
["Angers A/R",9000,0,DateTime.new(2017,11,5),"",1,3],
["Bordeaux A/R",9000,0,DateTime.new(2017,11,5),"",1,3],
["Paris A/R",9000,0,DateTime.new(2017,11,5),"",1,3],
["Metz A/R",8500,0,DateTime.new(2017,11,5),"",1,3],
["Cluny A/R",6000,0,DateTime.new(2017,11,5),"",1,3],
["Aix-en-Provence A/R",6000,0,DateTime.new(2017,11,5),"",1,3],
["Chalons A/R",8000,0,DateTime.new(2017,11,5),"",1,3],
["Lille A/R",9500,0,DateTime.new(2017,11,5),"",1,3],
["Je viendrai par mes propres moyens A/R",0,0,DateTime.new(2017,11,5),"",1,3],
["Lille aller",5700,0,DateTime.new(2017,11,5),"",1,4],
["Angers aller",5400,0,DateTime.new(2017,11,5),"",1,4],
["Bordeaux  aller",5400,0,DateTime.new(2017,11,5),"",1,4],
["Paris  aller",5400,0,DateTime.new(2017,11,5),"",1,4],
["Metz  aller",5100,0,DateTime.new(2017,11,5),"",1,4],
["Cluny aller",3600,0,DateTime.new(2017,11,5),"",1,4],
["Aix-en-Provence aller",3600,0,DateTime.new(2017,11,5),"",1,4],
["Chalons aller",4800,0,DateTime.new(2017,11,5),"",1,4],
["Je viendrai par mes propres moyens aller",0,0,DateTime.new(2017,11,5),"",1,4],
["Lille retour",5700,0,DateTime.new(2017,11,5),"",1,5],
["Angers retour",5400,0,DateTime.new(2017,11,5),"",1,5],
["Bordeaux retour",5400,0,DateTime.new(2017,11,5),"",1,5],
["Paris retour",5400,0,DateTime.new(2017,11,5),"",1,5],
["Metz retour",5100,0,DateTime.new(2017,11,5),"",1,5],
["Cluny retour",3600,0,DateTime.new(2017,11,5),"",1,5],
["Aix-en-Provence retour",3600,0,DateTime.new(2017,11,5),"",1,5],
["Chalons retour",4800,0,DateTime.new(2017,11,5),"",1,5],
["Je viendrai par mes propres moyens aller",0,0,DateTime.new(2017,11,5),"",1,5],
["Ecoski - Skis + Chaussures",5000,0,DateTime.new(2017,11,5),"",1,6,1],
["Ecoski - Skis seul",4500,0,DateTime.new(2017,11,5),"",1,6,1],
["Ecoski - Chaussures seules",3500,0,DateTime.new(2017,11,5),"",1,6,1],
["Découverte - Skis + Chaussures",6500,0,DateTime.new(2017,11,5),"",1,6,2],
["Découverte - Skis seul",5900,0,DateTime.new(2017,11,5),"",1,6,2],
["Découverte - Chaussures seules",4500,0,DateTime.new(2017,11,5),"",1,6,2],
["Sensation - Skis + Chaussures",8200,0,DateTime.new(2017,11,5),"",1,6,3],
["Sensation - Skis seul",7400,0,DateTime.new(2017,11,5),"",1,6,3],
["Sensation - Chaussures seules",6100,0,DateTime.new(2017,11,5),"",1,6,3],
["Excellence - Skis + Chaussures",11600,0,DateTime.new(2017,11,5),"",1,6,4],
["Excellence - Skis seul",11100,0,DateTime.new(2017,11,5),"",1,6,4],
["Excellence - Chaussures seules",9800,0,DateTime.new(2017,11,5),"",1,6,4],
["Assurance Annulation",2000,0,DateTime.new(2017,11,5),"Permet en cas de problème majeur (blessure, décès d’un proche…) justifié par un document officiel 48h avant le départ de se faire rembourser du prix du package (hors coût de l’assurance).",1,9],
["Assistance rapatriement/bagages",2000,0,DateTime.new(2017,11,5),"Permet en cas de blessures lors du séjour d’être remboursé des frais de rapatriement jusqu’au lieu de soin et/ou de domicile. (exemple barquette + frais pisteurs en cas de rapatriement sur les pistes, rapatriement par hélicoptère…). Attention elle ne sera pas valable en cas de rapatriement hors pistes ou en cas de comportement non autorisé.",1,9],
["Assurance interruption ski-pass",1500,0,DateTime.new(2017,11,5),"Permet en cas de problème majeur (ex : blessure pendant votre semaine) justifié par un document officiel/médical de se faire rembourser le prix du forfait et du matériel au pro rata des jours non-skiés.",1,9],
["Tout compris",3300,0,DateTime.new(2017,11,5),"Les trois assurances précédentes cumulées",1,9],
["Pas d'assurance",0,0,DateTime.new(2017,11,5),"Attestation responsabilité civile à fournir obligatoirement, même en cas d'assurance complémentaire sélectionnée.",1,9],
["RCC",1000,0,DateTime.new(2017,11,5),"Tournée des bars attaché par groupe",1,7],
["Freeride",0,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Raquette",0,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Biathlon",500,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Handiski",0,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Telemark",1000,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Sortie rando",1500,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Sortie ski",0,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Initiation snow",0,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Initiation ARVA",0,0,DateTime.new(2017,11,5),"",1,7,nil,nil,true],
["Slalom Ski Homme",0,0,DateTime.new(2017,11,5),"",1,7,nil,1],
["Slalom Ski Femme",0,0,DateTime.new(2017,11,5),"",1,7,nil,1],
["Slalom Snow Homme",0,0,DateTime.new(2017,11,5),"",1,7,nil,1],
["Slalom Snow Femme",0,0,DateTime.new(2017,11,5),"",1,7,nil,1],
["Derby Ski Homme",0,0,DateTime.new(2017,11,5),"",1,7,nil,2],
["Derby Ski Femme",0,0,DateTime.new(2017,11,5),"",1,7,nil,2],
["Derby Snow Homme",0,0,DateTime.new(2017,11,5),"",1,7,nil,2],
["Derby Snow Femme",0,0,DateTime.new(2017,11,5),"",1,7,nil,2],
["Boardercross Ski Homme",0,0,DateTime.new(2017,11,5),"",1,7,nil,3],
["Boardercross Ski Femme",0,0,DateTime.new(2017,11,5),"",1,7,nil,3],
["Boardercross Snow Homme",0,0,DateTime.new(2017,11,5),"",1,7,nil,3],
["Boardercross Snow Femme",0,0,DateTime.new(2017,11,5),"",1,7,nil,3],
["Snakegli's",0,0,DateTime.new(2017,11,5),"",1,7],
["Show-competition freestyle",0,0,DateTime.new(2017,11,5),"",1,7],
["Descente aux flambeaux",0,0,DateTime.new(2017,11,5),"",1,7],
["Masque Ryft Cadre Bleu / Verre bleu",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,1,"/assets/masque/ryft_11.jpg"],
["Masque Ryft Cadre Bleu / Verre noir",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,2,"/assets/masque/ryft_12.jpg"],
["Masque Ryft Cadre Bleu / Verre rouge",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,3,"/assets/masque/ryft_13.jpg"],
["Masque Ryft Cadre Rouge / Verre bleu",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,4,"/assets/masque/ryft_21.jpg"],
["Masque Ryft Cadre Rouge / Verre noir",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,5,"/assets/masque/ryft_22.jpg"],
["Masque Ryft Cadre Rouge / Verre rouge",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,6,"/assets/masque/ryft_23.jpg"],
["Masque Ryft Cadre Rose / Verre bleu",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,7,"/assets/masque/ryft_31.jpg"],
["Masque Ryft Cadre Rose / Verre noir",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,8,"/assets/masque/ryft_32.jpg"],
["Masque Ryft Cadre Rose / Verre rouge",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,9,"/assets/masque/ryft_33.jpg"],
["Masque Ryft Cadre Blanc / Verre bleu",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,10,"/assets/masque/ryft_41.jpg"],
["Masque Ryft Cadre Blanc / Verre noir",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,11,"/assets/masque/ryft_42.jpg"],
["Masque Ryft Cadre Blanc / Verre rouge",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,12,"/assets/masque/ryft_43.jpg"],
["Masque Ryft Cadre Jaune / Verre bleu",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,13,"/assets/masque/ryft_51.jpg"],
["Masque Ryft Cadre Jaune / Verre noir",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,14,"/assets/masque/ryft_52.jpg"],
["Masque Ryft Cadre Jaune / Verre rouge",3300,0,DateTime.new(2017,11,5),"",1,10,nil,nil,nil,15,"/assets/masque/ryft_53.jpg"],

]


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
                :option_sup_id => c[10],
                :image => c[11]
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
Categorie.find_by( nom: 'Options supplémentaires').update_attribute(:max_par_personne,5)


user_gorgu=User.create!(
			email:"gorgu@gadz.org",
			password:"iresam157",
			first_name: 'Gorgu',
			last_name: 'Gadz',
			gender: 'male',
			referant_id: 1,
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
		referant_id: 2,
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
        typeresid_id: 1
	)
