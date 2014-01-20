namespace :populate_rec do

	task :all => [:environment] do

		puts "CREATION DES UTILISATEURS DE RECETTE"

		puts "CREATION USER : Georges"
		user_georges=User.create!(
				email:"georges@mail.fr",
				password:"iresam157",
				first_name: 'Georges',
				last_name: 'Duchemin',
				gender: 'male',
				cgu_accepted: true,
				inscription_terminee: true,
				moderated: true
				)

		puts "CREATION PERSONNE : Georges"

		georges=user_georges.personnes.create!(
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
			:email => "georges@mail.fr",
			:fams => "84",
			:promo => "me211",
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
		    :pphone => "0684848484",
		    :genre_id => 1,
		    :enregistrement_termine => true,
		    :type_pers => 'Gadz'
		)

	user_georges.referant=georges
	user_georges.save
	user_georges.add_role :gadz

	puts "CREATION PERSONNE : Jeanne"

		Jeanne=user_georges.personnes.create!(
			:nom => "Duchemin",
			:prenom => "Jeanne",
			:phone => "0687654321",
			:assurance => 1,
			:documentassurance => 0,
			:adresse => "12 rue felix savart",
			:complement => "RESAM",
			:ville => "metz",
			:codepostal => "57000",
			:bucque => "bucquetrololo",
			:email => "jeanne@mail.fr",
			:naissance => DateTime.new(1990,2,3),
			:taille => "184",
			:pointure => "42",
			:taillevetement_id => "2",
			:pnom => "Duchemin",
			:pprenom => "Robert",
		    :plienparente => "Beau-Pere",
		    :padresse => "84 rue du PG",
		    :pcomplement => "Resid's du gorgu",
		    :pville => "Paris",
		    :pcodepostal=> 75001,
		    :pphone => "0684848484",
		    :genre_id => 2,
		    :enregistrement_termine => true,
		    type_pers: "Pec\'s"
		)

	puts "CREATION USER : Marcel"

	user_marcel=user_georges.filleuls.create!(
		email:"marcel@mail.fr",
		password:"iresam157",
		first_name: 'Marcel',
		last_name: 'LePoney',
		gender: 'male',
		cgu_accepted: false,
		inscription_terminee: false,
		moderated: false
		)

	puts "CREATION PERSONNE : Marcel"
	marcel=user_marcel.personnes.create!(
			:nom => "LePoney",
			:prenom => "Marcel",
			:phone => "0687654321",
			:assurance => 0,
			:documentassurance => 0,
			:adresse => "12 rue felix savart",
			:complement => "RESAM",
			:ville => "metz",
			:codepostal => "57000",
			:bucque => "bucquetrololo",
			:email => "marcel@mail.fr",
			:naissance => DateTime.new(1990,2,3),
			:taille => "184",
			:pointure => "42",
			:taillevetement_id => "2",
			:pnom => "Duchemin",
			:pprenom => "Robert",
		    :plienparente => "Beau-Pere",
		    :padresse => "84 rue du PG",
		    :pcomplement => "Resid's du gorgu",
		    :pville => "Paris",
		    :pcodepostal=> 75001,
		    :pphone => "0684848484",
		    :genre_id => 2,
		    :enregistrement_termine => false,
		    type_pers: 'Pec\'s'
		)

	user_marcel.referant=marcel
	user_marcel.save


	end


end
