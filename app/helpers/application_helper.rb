module ApplicationHelper


def conditional_format(c)
    render :partial => "shared/conditional_format", :locals => { :c => c}
end

def conditional_badge(c)
    render :partial => "shared/conditional_badge", :locals => { :c => c}
end

# https://coderwall.com/p/ximm8a
# convert flash message to tostr
def custom_bootstrap_flash
  flash_messages = []
  flash.each do |type, message|
    type = :success if type == :notice
    type = :error   if type == :alert
    text = "<script>toastr.#{type}('#{message}');</script>"
    flash_messages << text.html_safe if message
  end
  flash_messages.join("\n").html_safe
end
	
end
