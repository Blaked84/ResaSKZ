#encoding: utf-8
namespace :debug do
  desc "Liste les personnes qui n'ont pas de user associé"
  task list_personnes_without_user: :environment do

  	Personne.where(user_id: nil).each do |p|
  		puts "===== Personne n°#{p.id} ======================================================="
  		puts p.inspect
  	end

  end

  desc "supprime les personnes qui n'ont pas de user associé"
  task del_personnes_without_user: :environment do
  	Personne.where(user_id: nil).each do |p|
  		p.delete
  	end
  end

  desc "Liste les commandes qui n'ont pas de personne associé"
  task list_commandes_without_user: :environment do

  	Commande.where(personne_id: nil).each do |p|
  		puts "===== commande n°#{p.id} ======================================================="
  		puts p.inspect
  	end

  end

  desc "Liste les commandes qui n'ont pas de user associé"
  task del_commandes_without_user: :environment do

  	Commande.where(personne_id: nil).each do |p|
  		p.delete
  	end

  end

end
