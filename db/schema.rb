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

ActiveRecord::Schema.define(version: 20171012195812) do

  create_table "activites", force: :cascade do |t|
    t.string   "nom",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "productid"
    t.boolean  "open"
    t.boolean  "quick_check"
  end

  create_table "activites_personnes", force: :cascade do |t|
    t.integer  "activite_id"
    t.integer  "personne_id"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "nom",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_par_personne"
  end

  create_table "chambres", force: :cascade do |t|
    t.string   "numero",     limit: 255
    t.integer  "nbrplace"
    t.string   "zone",       limit: 255
    t.integer  "tbk_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chambres_personnes", force: :cascade do |t|
    t.integer "chambre_id"
    t.integer "personne_id"
  end

  create_table "commande_products", force: :cascade do |t|
    t.integer  "commande_id"
    t.integer  "product_id"
    t.integer  "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commandes", force: :cascade do |t|
    t.boolean  "assurance"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "personne_id"
    t.boolean  "caution"
    t.string   "ean",                limit: 255
    t.integer  "tbk_id"
    t.integer  "bypasspaiement"
    t.integer  "bypassassurance"
    t.integer  "event_id"
    t.integer  "pack_id"
    t.integer  "glisse_id"
    t.string   "idlong",             limit: 255
    t.datetime "caution_updated_at"
  end

  create_table "configurables", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurables", ["name"], name: "index_configurables_on_name"

  create_table "events", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
  end

  create_table "gammes", force: :cascade do |t|
    t.string   "nom"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "sexe",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom_cas",     limit: 255
    t.string   "nom_complet", limit: 255
  end

  create_table "glisses", force: :cascade do |t|
    t.string   "nom",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupes", force: :cascade do |t|
    t.string   "nom",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lits", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "chambre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lits_personnes", force: :cascade do |t|
    t.integer "lit_id"
    t.integer "personne_id"
  end

  add_index "lits_personnes", ["lit_id"], name: "index_lits_personnes_on_lit_id"
  add_index "lits_personnes", ["personne_id"], name: "index_lits_personnes_on_personne_id"

  create_table "niveau_skis", force: :cascade do |t|
    t.string   "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packs", force: :cascade do |t|
    t.string   "nom",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paiements", force: :cascade do |t|
    t.string   "etape",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commande_id"
    t.integer  "amount_cents"
    t.string   "paiement_hash", limit: 255
    t.boolean  "verif"
    t.string   "idlong",        limit: 255
    t.datetime "verified_at"
    t.integer  "erreur"
    t.integer  "verified_by"
    t.boolean  "verif_forced"
  end

  add_index "paiements", ["idlong"], name: "index_paiements_on_idlong"

  create_table "personnes", force: :cascade do |t|
    t.string   "nom",                    limit: 255
    t.string   "prenom",                 limit: 255
    t.string   "phone",                  limit: 255
    t.string   "email",                  limit: 255
    t.boolean  "assurance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "adresse",                limit: 255
    t.string   "ville",                  limit: 255
    t.integer  "codepostal"
    t.string   "bucque",                 limit: 255
    t.string   "fams",                   limit: 255
    t.string   "promo",                  limit: 255
    t.string   "idGadzOrg",              limit: 255
    t.integer  "taille"
    t.integer  "pointure"
    t.integer  "taillevetement_id"
    t.string   "complement",             limit: 255
    t.string   "pnom",                   limit: 255
    t.string   "pprenom",                limit: 255
    t.string   "plienparente",           limit: 255
    t.string   "padresse",               limit: 255
    t.string   "pcomplement",            limit: 255
    t.string   "pville",                 limit: 255
    t.string   "pcodepostal",            limit: 255
    t.string   "pphone",                 limit: 255
    t.datetime "naissance"
    t.boolean  "documentassurance"
    t.integer  "genre_id"
    t.boolean  "enregistrement_termine"
    t.string   "commentaires",           limit: 255
    t.string   "commentaires_admin",     limit: 255
    t.string   "type_pers",              limit: 255
    t.boolean  "moderated"
    t.datetime "assurance_uptated_at"
    t.boolean  "disabled"
    t.integer  "typeresid_id"
    t.integer  "lit_id"
    t.integer  "tour_tete_id"
    t.integer  "niveau_ski_id"
  end

  add_index "personnes", ["lit_id"], name: "index_personnes_on_lit_id"

  create_table "preregistrations", force: :cascade do |t|
    t.string   "token",      limit: 255
    t.string   "email",      limit: 255
    t.boolean  "used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "price"
    t.integer  "stock"
    t.date     "echeance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",      limit: 255
    t.integer  "event_id"
    t.integer  "categorie_id"
    t.integer  "max_par_personne"
    t.integer  "gamme_id"
    t.integer  "preference"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "taillevetements", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tbks", force: :cascade do |t|
    t.string   "nom",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nom_pecs",   limit: 255
    t.string   "diminutif",  limit: 255
  end

  create_table "tour_tetes", force: :cascade do |t|
    t.string   "mesure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "typeresids", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referant_id"
    t.string   "uid",                    limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "gender",                 limit: 255
    t.boolean  "inscription_terminee"
    t.boolean  "cgu_accepted"
    t.integer  "parrain_id"
    t.boolean  "moderated"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
