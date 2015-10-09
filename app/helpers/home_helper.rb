module HomeHelper
def devise_mapping
  @devise_mapping ||= request.env["devise.mapping"]
end
def resource_name
  devise_mapping.name
end

def resource_class
  devise_mapping.to
end
def resource
    @resource ||= User.new
end
end
