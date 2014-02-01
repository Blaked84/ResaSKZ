#encoding: utf-8
namespace :debug do
  desc "Liste les personnes qui n'ont pas de user associé"
  task list_personnes_without_user: :environment do

  	Personne.all.select{|p| not(p.user)}.each do |p|
  		puts "===== Personne n°#{p.id} ======================================================="
  		puts p.inspect
  	end

  end

  desc "supprime les personnes qui n'ont pas de user associé"
  task del_personnes_without_user: :environment do
  	Personne.all.select{|p| not(p.user)}.each do |p|
  		p.delete
  	end
  end

  desc "Liste les commandes qui n'ont pas de personne associé"
  task list_commandes_without_user: :environment do

  	Commande.all.select{|p| not(p.personne)}.each do |p|
  		puts "===== commande n°#{p.id} ======================================================="
  		puts p.inspect
  	end

  end

  desc "Liste les commandes qui n'ont pas de user associé"
  task del_commandes_without_user: :environment do

  	Commande.all.select{|p| not(p.personne)}.each do |p|
  		p.delete
  	end

  end

  desc "Liste les commande_products qui n'ont pas de product associé"
  task list_commande_products_without_product: :environment do

  	CommandeProduct.all.select{|p| not(p.product)}.each do |p|
  		puts "===== CommandeProduct n°#{p.id} ======================================================="
  		puts p.inspect
  	end

  end

  desc "supprime les commande_products qui n'ont pas de product associé"
  task del_commande_products_without_product: :environment do
  	CommandeProduct.all.select{|p| not(p.product)}.each do |p|
  		p.delete
  	end
  end

  desc "Liste les paiements qui n'ont pas de commande associé"
  task list_paiements_without_commande: :environment do

  	Paiement.all.select{|p| not(p.commande)}.each do |p|
  		puts "===== Paiement n°#{p.id} ======================================================="
  		puts p.inspect
  	end

  end

  desc "supprime les paiements qui n'ont pas de commande associé"
  task del_paiements_without_commande: :environment do
  	Paiement.all.select{|p| not(p.commande)}.each do |p|
  		p.delete
  	end
  end

end
