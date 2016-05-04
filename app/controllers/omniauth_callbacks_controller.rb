class OmniauthCallbacksController < Foyer::OmniauthCallbacksController
  def callback
    find_or_create_user
    sign_in @user
    
    # Set logged in user id to get it in ActionCable connection for current_user
    cookies.signed['user.id'] = @user.id

    redirect_to after_sign_in_path
  end

  private
  def after_sign_in_path
    return origin if origin.to_s.match(%r{^\/}) || origin.to_s.match(%r{^#{request.scheme}://#{request.host}})
    update_forms_path
  end
  
  def find_or_create_user
    @user = User.find_by(uid: auth_hash.uid) 
    if @user.blank? 
      @user = User.find_by_email(auth_hash.info.email) 
      @user.update_attributes(:uid => auth_hash.uid) if @user.present?
    end
    @user = User.create(uid: auth_hash.uid, email: auth_hash.info.email) if @user.blank?
    
    udpate_user_details
    @user
  end
  
  def udpate_user_details
    @user.update_attributes \
      current_sign_in_at: Time.current,
      current_sign_in_ip: request.ip
  end
end
