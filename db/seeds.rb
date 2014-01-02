# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# test only 
case Rails.env
	when "development"

	puts "Seed dev"
	Personne.create(
		:nom => "Duchemin",
		:prenom => "Georges",
		:phone => "0612345678",
		:assurance => 0,
		:adresse => "12 rue felix savart",
		:ville => "metz",
		:codepostal => "57000",
		:bucque => "bucquetrololo",
		:fams => "84",
		:promo => "211",
		:idGadzOrg => "georges.duchemin.2011",
		:taille => "184",
		:pointure => "42"

		)

	Product.create(
		:name => "Tarte",
		:price => 8400,
		:stock => 211,
		:echeance => DateTime.new(2013,2,3),
		:description => "MIAM MAIM",
		:event_id => 1
		)
	Product.create(
		:name => "Tarte",
		:price => 8400,
		:stock => 211,
		:echeance => DateTime.new(2013,2,3),
		:description => "MIAM MAIM",
		:event_id => 2
		)
	Commande.create(
		:assurance => 0,
		:status => 0,
		:personne_id => 1)
end

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
end

puts "genres"
Genre.create(:sexe => "H")
Genre.create(:sexe => "F")

puts "taillevetements"
listevet=["S","M","L","XL","XXL"]
listevet.each do |c|
	Taillevetement.create(:name =>c)
end

puts "tbk"
listet=["Siber's","Clun's"]
listet.each do |c|
	Tbk.create(:nom =>c)
end