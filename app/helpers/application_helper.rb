module ApplicationHelper


def conditional_format(c)
    render :partial => "shared/conditional_format", :locals => { :c => c}
  end
	
end
