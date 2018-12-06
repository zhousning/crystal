class Parents::SessionsController < Devise::SessionsController
  layout "application_blank", :except=>["edit", "update"]

  def create
    super 
  end
 
  def after_sign_in_path_for(resource)
    if session[:previous_url_id]
      new_order_path(:'course[id]' => session[:previous_url_id])
    else
      root_path
    end
  end

  def parent_validate
    @parent = Parent.find_by_phone(params[:p_phone])
    if @parent && @parent.valid_password?(params[:p_password])
      session[:previous_url_id] = params[:id]
      respond_to do |f|
        f.json { render :json => {res:'success'} }
      end
    else
      respond_to do |f|
        f.json { render :json => {res:'error'} }
      end
    end
  end
end
