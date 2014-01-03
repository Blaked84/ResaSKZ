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

ActiveRecord::Schema.define(version: 20140102233708) do

  create_table "activites", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "categories", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chambres", force: true do |t|
    t.string   "numero"
    t.integer  "nbrplace"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "commandes", force: true do |t|
    t.boolean  "assurance"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "personne_id"
  end

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "Name"
    t.string   "Description"
  end

  create_table "genres", force: true do |t|
    t.string   "sexe"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "taillevetements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tbks", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "usertypes", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
