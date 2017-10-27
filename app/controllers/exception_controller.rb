class ExceptionController < ApplicationController

  #Response
  respond_to :html, :xml, :json

  #Dependencies
  before_action :status

  # => Devise
  # => Voir http://stackoverflow.com/a/38531245/1143732 pour Rails 5 (futur upgrade)
  #skip_before_action :authenticate_user!, raise: false

  #Layout
  layout :layout_status

  ####################
  #      Action      #
  ####################

  #Show
  def show
    respond_with status: @status
  end

  ####################
  #   Dependencies   #
  ####################

  protected

  #Info
  def status
    @exception  = env['action_dispatch.exception']
    @status     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code # Ex : 404
    @response   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]  # Ex : not_found
  end

  #Format
  def details
    @details ||= {}.tap do |h|
      I18n.with_options scope: [:exception, :show, @response], exception_name: @exception.class.name, exception_message: @exception.message do |i18n|
        h[:name]    = i18n.t "#{@exception.class.name.underscore}.title", default: i18n.t(:title, default: @exception.class.name)
        h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
      end
    end
  end
  helper_method :details

  ####################
  #      Layout      #
  ####################

  private

  #Layout
  def layout_status
    # Il peut être interessant de changer le design de base en fonction de l'erreur. Ex pour l'erreur 500. TODO
    #@status.to_s == "404" ? "application" : "error"
    "landing"
  end

end
