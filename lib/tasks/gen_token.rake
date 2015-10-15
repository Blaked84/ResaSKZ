#encoding: utf-8

#Rake genrant les token d'inscription

#rake gen_token:all[email_sender,IPserveur] 

namespace :gen_token do
  desc "genere les tokens"
  task all: :environment do
    require 'csv'

    path = "mail_to_send/"
    bath_file = "sendmail.sh"
    csv_path ="listemails.csv"

    csv_text = File.read(csv_path)
    csv_file = CSV.parse(csv_text)

    liste= []

    csv_file.each do |row|
      e=row[0].to_s
      liste.push(*e)
    end

  	liste.each_with_index do |mail, i|
      a = Preregistration.new
      a.email = mail
      a.generate_token
      a.save

      content = "From:SKZ <" + Configurable[:sender_mail].to_s + ">\nSubject: Inscriptions SKZ\nSal's!\nNous venons de t'ouvrir un accès sur le site de résevation de SKZ! Pour t'inscrire, clique sur le lien suivant ou copie le dans ton navigateur: https://resaskz.gadz.org/users/register/" + a.token + "\n\nÀ bientôt,\nLa Team SKZ"

      filename= "mail"+i.to_s+".eml"
      File.open(path+filename, "w+") do |f|
        f.write(content)
      end

      File.open(path+bath_file, "a") do |f|
        f.puts("swaks -t " + mail + " -s " + Configurable[:serveur_mail].to_s + " -d ./"+filename+" >> mailsent \n")
      end
      puts (mail + " Done!" ).to_s
    end
  end

end