#encoding: utf-8
namespace :regenproduct do
  desc "Liste les personnes qui n'ont pas de user associé"
  task incident030214: :environment do
    # Attention, les lignes different du seed. Il y a un indice en plus qui est l'id du produit
    pl=[
      ["Pack PG",30500,"",DateTime.new(2013,2,3),"De 213 à 211",1,1,1]
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

end
