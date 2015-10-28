class Plataltransaction < ActiveRecord::Base
		#establish_connection "platal_#{Rails.env}"
		establish_connection "platal"
		self.table_name = "gpayment_transactions"
end