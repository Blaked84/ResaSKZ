class Plataltransaction < ActiveRecord::Base
		establish_connection "platal_#{Rails.env}"
		self.table_name = "gpayment_transactions"
end