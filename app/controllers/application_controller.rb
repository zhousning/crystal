class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers

#  before_filter :set_locale
#     
#  def set_locale
#    I18n.locale = params[:locale] || I18n.default_locale
#  end

  before_filter :force_tablet_html

  def force_tablet_html
    session[:tablet_view] = false
  end

  before_filter :user_access_log

  def user_access_log
    session_id = session[:session_id] || ""
    parent_id = (current_parent && current_parent.id) || ""
    parent_name = (current_parent && current_parent.name) || ""
    teacher_id = (current_teacher && current_teacher.id) || ""
    teacher_name = (current_teacher && current_teacher.name) || ""
    STAT_LOGGER.info "[access]\t#{request.request_method}\t#{request.url}\t#{request.referer}\t#{request.remote_ip}\t#{request.user_agent}\t#{session_id}\t#{parent_id}\t#{parent_name}\t#{teacher_id}\t#{teacher_name}"
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= case
                         when current_admin_user
                           Ability.new(current_admin_user)
                         when current_parent
                           Ability.new(current_parent)
                         when current_teacher
                           Ability.new(current_teacher)
                         else
                           Ability.new(nil)
                         end
  end
end
