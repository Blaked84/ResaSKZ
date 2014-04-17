#encoding: utf-8

#Rake genrant les ean code pour toutes les commandes

namespace :gen_ean do
  desc "genere les codebarre"
  task all: :environment do
  	Commande.all.map{|c| c.gen_and_record_ean13 if c.personne}
  	puts "Done!"
  end

  desc "genere les images de codes barre"
  task images: :environment do

  	puts "Rails Environment = #{Rails.env}"
    require 'barby/barcode/ean_13'
    require 'barby/outputter/png_outputter'

    
    Commande.all.each do |c|
      if c.ean
          
          puts c.ean.to_s[0...12]

          barcode = Barby::EAN13.new(c.ean.to_s[0...12])
          

          Dir.mkdir("codes_barres") unless File.exists?("codes_barres")
          File.open("codes_barres/#{barcode.to_s}.png", 'w'){|f| f.write barcode.to_png }
      end
    end

  end
end