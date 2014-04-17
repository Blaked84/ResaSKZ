#encoding: utf-8

#Rake genrant les ean code pour toutes les commandes

namespace :gen_ean do
  desc "genere les codebarre"
  task all: :environment do
  	Commande.all.map{|c| c.gen_and_record_ean13 if c.personne}
  	puts "Done!"
  end
end