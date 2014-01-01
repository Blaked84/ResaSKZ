class AdminController < ApplicationController
  def index
  	@nbrPersonnes = Personne.all.count.to_s
  	@nbrPersonnesNonAssuree = Personne.where( assurance: false).count

  end
end
