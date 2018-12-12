class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :signed_only

  def signed_only
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end

  def writer_only
    unless (current_user.has_role? :writer or current_user.has_role? :admin)
      redirect_to(root_path, :alert => "Brak dostępu, nie jesteś pisarzem!")
    end
  end

  def reader_only
    unless (current_user.has_role? :reader or current_user.has_role? :admin)
      redirect_to(root_path, :alert => "Brak dostępu, nie jesteś czytelnikiem!")
    end
  end

  def admin_only
    unless current_user.has_role? :admin
      redirect_to(root_path, :alert => "Brak dostępu, tylko dla administratorów!")
    end
  end

end
