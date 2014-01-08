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
listecategorries=["Pack","Nourriture","RCC","Transport aller","Transport retour"]
listecategorries.each do |c|
	Categorie.create(:nom =>c)
cat_assurance = Categorie.create(:nom =>"Assurance")
Configurable[:id_cat_assurance]=cat_assurance.id


end

# puts "UserTypes"
# Usertype.create(:)

puts "Genres"
Genre.create(:sexe => "H")
Genre.create(:sexe => "F")

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

# test only 
case Rails.env
	when "development"

	puts "Seed dev"

	user_gorgu=User.create(
				email:"gorgu@gadz.org",
				password:"iresam157")
	user_gorgu.add_role :gorgu

	user_georges=User.create(
				email:"mail@mail.fr",
				password:"iresam157")

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
	    :pphone => "068484848484"
		)

	user_georges.save

	tarte = Product.create(
		:name => "Tarte",
		:price => 8400,
		:stock => 211,
		:echeance => DateTime.new(2013,2,3),
		:description => "MIAM MAIM",
		:event_id => 1,
		:categorie_id => 2
		)
	gato = Product.create(
		:name => "GATO",
		:price => 15700,
		:stock => 211,
		:echeance => DateTime.new(2013,2,3),
		:description => "Scrunch Scrunch !",
		:event_id => 2,
		:categorie_id => 3
		)
	com = georges.commandes.create(
		:assurance => 0,
		:status => 0)

	com.add_product(gato)

	com.paiements.create(
		:amount_cents => 8400)
end