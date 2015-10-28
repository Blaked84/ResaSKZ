#encoding: utf-8

#Rake verification des paiements depuis la base de platal

namespace :check_payment do
	desc "verification des paiements depuis la base de platal"
	task all: :environment do
		puts "Start"

		def validate_paiement(paiement_id_long, csv_amount_cents, reponse_code, banque_reponse_code)
	  	# retrourne un array de booleen.
	  	# [true si un paiement du site est validé, true si paiement refusé par la banque]


	  	if paiement_id_long.to_s.size < 4 && !paiement_id_long.nil?
		    # ceci est necessaire poour valider les premiers paiement suite à l'erreur dans le hash généré avec id et non idlong
		    paiement=Paiement.find_by(id: paiement_id_long.to_i)
		else
			paiement=Paiement.find_by(idlong: paiement_id_long)
		end
		if !paiement.nil? && !paiement.verif? && paiement.amount_cents.to_i ==  csv_amount_cents.to_i
			if reponse_code == "0" && banque_reponse_code == "0"
				paiement.set_verif
				return [true,false]
			else
				paiement.set_erreur(reponse_code)
				return [false,true]
			end
		    # logger.info "###########################Validation"

		else 
			return [false,false]   
		end
	end

	nbre_paiements_valides = 0
    nbre_paiements_refuses = 0
	
	transations = Plataltransaction.where("trans_date > '2015-10-01'").where(payment_id: 126)

	puts transations.count.to_s + " transations à analyser"
	transations.each do |t|
		valcode = validate_paiement(t.order_id, t.amount.to_i * 100, t.result.to_s, t.result.to_s)
		nbre_paiements_valides +=1 if valcode[0]
        nbre_paiements_refuses +=1 if valcode[1]
	end
		puts "ok:     "+ nbre_paiements_valides.to_s
		puts "refusé: "+ nbre_paiements_refuses.to_s
		puts "Done!"

	end





end