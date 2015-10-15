class Preregistration < ActiveRecord::Base

	def generate_token
		self.token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless Preregistration.exists?(token: random_token)
		end
	end

	def set_used
		self.used = true
		self.save
	end

	def used?
		self.used
	end

end
