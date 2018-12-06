class Parents::RegistrationsController < Devise::RegistrationsController
  layout "application_blank", :except=>["edit", "update"]
  has_mobile_fu
  has_mobile_fu_for :new,:edit

  def create
    super 
  end
end
