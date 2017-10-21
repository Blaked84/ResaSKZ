class CommandeProduct < ActiveRecord::Base

	belongs_to :commande
	belongs_to :product

  # EXTRACT FROM SCHEMA :
	# create_table "commande_products", force: :cascade do |t|
	# 	t.integer  "commande_id"
	# 	t.integer  "product_id"
	# 	t.integer  "nombre"
	# 	t.datetime "created_at"
	# 	t.datetime "updated_at"
	# 	t.boolean  "en_attente",  default: false
	# end


end
