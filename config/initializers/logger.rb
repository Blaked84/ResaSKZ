LooklaDev::Application.configure do

	#Chemin de stockage des logs, sans '/' final
	path=Rails.root.to_s+'/log/'

	config.logger = ActiveSupport::Logger.new(path+'resaskz.'+Rails.env+'.log')

end