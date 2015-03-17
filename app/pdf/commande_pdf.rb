class CommandePdf < Prawn::Document

  SMALL=8
  NORMAL=12
  MEDIUM=18
  LARGE=22
  INDENT=20

  EURO=I18n.translate(:'number.currency.format', :locale => :fr, :default => {})[:unit]

def initialize(commande, personne,total_euro)
    super(:page_size=> "A4",:top_margin => 60)

    text "Commande # #{commande.idlong}", :size => MEDIUM
    text "-> mettre le code barre"
    info(personne)
    commande.idlong
    options(commande,total_euro)

end

def info(personne)
	text personne.nom_complet

end

def options(commande,total_euro)
	data = [["Produit","Quantitée", "Prix TTC (€)"]]+commande.commande_products.map { |cprd|  [cprd.product.name,cprd.nombre,cprd.product.price_euro]}+[["Total","",total_euro]]

	table(data) do
		cells.padding = 5
	end
	end
end