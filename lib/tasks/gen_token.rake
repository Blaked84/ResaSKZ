#encoding: utf-8

#Rake genrant les token d'inscription

namespace :gen_token do
  desc "genere les tokens"
  task all: :environment do

    liste = ["email1@truc.com", "email2@truc.com"]

  	liste.each do |mail|
      a = Preregistration.new
      a.email = mail
      a.generate_token
      a.save
    end
  end

end