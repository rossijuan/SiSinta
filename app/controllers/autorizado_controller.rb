class AutorizadoController < ApplicationController
  before_filter :authenticate_usuario!
  check_authorization
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |e|
    flash[:error] = I18n.t 'unauthorized.default'
    redirect_to :back
  end

end