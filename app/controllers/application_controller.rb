class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

 
  after_action :verify_authorized
  after_action :verify_policy_scoped, if: -> { action_name == "index" }

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  private

  def pundit_user
    resume_session
    Current.user
  end

  def forbidden
    return request_authentication if Current.user.nil?  

    render "errors/forbidden", status: :forbidden
  end
end