#encoding: utf-8

#Rake permettant de réparer la liste des produits suite à un socuis d'intervention.
#Il permet de recréer plusieusr produits ayant été supprimés.

namespace :unvalidatepayements do
  desc "Liste les personnes qui n'ont pas de user associé"
  task all: :environment do
  	Paiement.all.map{|p| p.set_unverif}
  end
end