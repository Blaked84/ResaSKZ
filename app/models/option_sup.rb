class OptionSup < ActiveRecord::Base
  has_many :products

  def self.couleurs_cadre
    return ["Bleu","Rouge","Rose","Blanc","Jaune"]
  end

  def self.couleurs_cadre_form
    arr = []
    self.couleurs_cadre.each do |p|
      arr << [p,p]
    end
    return arr
  end


  def self.couleurs_verre
    return ["Bleu","Noir","Rouge"]
  end

  def self.couleurs_verre_form
    arr = []
    self.couleurs_verre.each do |p|
      arr << [p,p]
    end
    return arr
  end
end
