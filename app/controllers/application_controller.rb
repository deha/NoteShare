class ApplicationController < ActionController::Base
  protect_from_forgery

  # akcja gry nie mamy autoryzacji, podnoszony jest wyjatek i robione przekierowanie
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'You are not allowed to perform this action.'
    redirect_to root_path
  end
end
