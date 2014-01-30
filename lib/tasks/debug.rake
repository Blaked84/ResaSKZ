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

end
