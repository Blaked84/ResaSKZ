#encoding: utf-8
namespace :incident030214 do
  desc "Liste les personnes qui n'ont pas de user associé"
  task regenproduct: :environment do
    # Attention, les lignes different du seed. Il y a un indice en plus qui est l'id du produit
    pl=[
      ["Pack PG",30500,"",DateTime.new(2013,2,3),"De 213 à 211",1,1,1],
      ["Pack Archi",35000,"",DateTime.new(2013,2,3),"A partir de 205",1,1,3],
      ["Pack Archi",35000,"",DateTime.new(2013,2,3),"A partir de 205",2,1,43],

    ]


    pl.each do |c|
      a=Product.create(
        :name => c[0],
        :price => c[1],
        :stock => c[2],
        :echeance => c[3],
        :description => c[4],
        :event_id => c[5],
        :categorie_id => c[6]
        )
      a.id=c[7]
      a.save
    end

  end

  desc "Retourne les id des commandes ayant des paiements de 15250cents"
  task paid_pg_command: :environment do

  com_pg=Commande.all.map{|c|  c.id if (c.paiements.map{|p| p.amount_cents}).include?(15250)}.compact
  com_pg_s1=com_pg.map{|c| c if Commande.find(c).event.id==1}.compact
  
  com_archi=Commande.all.map{|c|  c.id if (c.paiements.map{|p| p.amount_cents}).include?(17500)}.compact
  com_archi_s1=com_archi.map{|c| c if Commande.find(c).event.id==1}.compact
  com_archi_s2=com_archi.map{|c| c if Commande.find(c).event.id==2}.compact
  puts "==================================================="
  puts "id des commandes ayant des paiements de 15250cents"
  puts "==================================================="
  puts com_pg
  puts
  puts "==================================================="
  puts "id des commandes ayant des paiements de 15250cents pour l'event 1" 
  puts "==================================================="
  puts com_pg_s1
  puts
  puts "==================================================="
  puts "==================================================="
  puts "id des commandes ayant des paiements de 17500cents"
  puts "==================================================="
  puts com_archi
  puts
  puts "==================================================="
  puts "id des commandes ayant des paiements de 17500cents pour l'évent1"
  puts "==================================================="
  puts com_archi_s1
  puts "==================================================="
  puts "id des commandes ayant des paiements de 17500cents pour l'évent2"
  puts "==================================================="
  puts com_archi_s2
  puts "==================================================="




  end

  desc "restore l'association commande produit pour les commandes ayant des paiements de 15250cents"
  task paid_pg_command_restore: :environment do

  com_pg=Commande.all.map{|c|  c.id if (c.paiements.map{|p| p.amount_cents}).include?(15250)}.compact
  com_pg_s1=com_pg.map{|c| c if Commande.find(c).event.id==1}.compact
  
  com_archi=Commande.all.map{|c|  c.id if (c.paiements.map{|p| p.amount_cents}).include?(17500)}.compact
  com_archi_s1=com_archi.map{|c| c if Commande.find(c).event.id==1}.compact
  com_archi_s2=com_archi.map{|c| c if Commande.find(c).event.id==2}.compact


  com_pg_s1.map{|c| Commande.find(c).add_product(1)}
  com_archi_s1.map{|c| Commande.find(c).add_product(3)}
  com_archi_s2.map{|c| Commande.find(c).add_product(43)}
 
  end

  desc "find commande with product with id 85 86 87 88"
  task check_wrong_products: :environment do

    id=[85,86,87,88]

    id.each do |i|
      puts "==================================================="
      puts "Commandes avec un produit ayant pour id " + i.to_s
      puts Commande.all.map{|c| c.id if (c.products.map{|p| p.id}).include?(i)}.compact
  end
  end

end
