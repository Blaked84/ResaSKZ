# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140413163833) do

  create_table "activites", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "productid"
  end

  create_table "categories", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_par_personne"
  end

  create_table "chambres", force: true do |t|
    t.string   "numero"
    t.integer  "nbrplace"
    t.string   "zone"
    t.integer  "tbk_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chambres_personnes", force: true do |t|
    t.integer "chambre_id"
    t.integer "personne_id"
  end

  create_table "commande_products", force: true do |t|
    t.integer  "commande_id"
    t.integer  "product_id"
    t.integer  "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commandes", force: true do |t|
    t.boolean  "assurance"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "personne_id"
    t.boolean  "caution"
    t.string   "ean"
    t.integer  "tbk_id"
    t.integer  "bypasspaiement"
    t.integer  "bypassassurance"
    t.integer  "event_id"
    t.integer  "pack_id"
    t.integer  "glisse_id"
    t.string   "idlong"
    t.datetime "caution_updated_at"
  end

  create_table "configurables", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurables", ["name"], name: "index_configurables_on_name"

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
  end

  create_table "genres", force: true do |t|
    t.string   "sexe"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom_cas"
    t.string   "nom_complet"
  end

  create_table "glisses", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupes", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paiements", force: true do |t|
    t.string   "etape"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commande_id"
    t.integer  "amount_cents"
    t.string   "paiement_hash"
    t.boolean  "verif"
    t.string   "idlong"
    t.datetime "verified_at"
    t.integer  "erreur"
    t.integer  "verified_by"
    t.boolean  "verif_forced"
  end

  create_table "personnes", force: true do |t|
    t.string   "nom"
    t.string   "prenom"
    t.string   "phone"
    t.string   "email"
    t.boolean  "assurance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "adresse"
    t.string   "ville"
    t.integer  "codepostal"
    t.string   "bucque"
    t.string   "fams"
    t.string   "promo"
    t.string   "idGadzOrg"
    t.integer  "taille"
    t.integer  "pointure"
    t.integer  "taillevetement_id"
    t.string   "complement"
    t.string   "pnom"
    t.string   "pprenom"
    t.string   "plienparente"
    t.string   "padresse"
    t.string   "pcomplement"
    t.string   "pville"
    t.string   "pcodepostal"
    t.string   "pphone"
    t.datetime "naissance"
    t.boolean  "documentassurance"
    t.integer  "genre_id"
    t.boolean  "enregistrement_termine"
    t.string   "commentaires"
    t.string   "commentaires_admin"
    t.string   "type_pers"
    t.boolean  "moderated"
    t.datetime "assurance_uptated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "stock"
    t.date     "echeance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "event_id"
    t.integer  "categorie_id"
    t.integer  "max_par_personne"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "taillevetements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tbks", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom_pecs"
    t.string   "diminutif"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referant_id"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.boolean  "inscription_terminee"
    t.boolean  "cgu_accepted"
    t.integer  "parrain_id"
    t.boolean  "moderated"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
