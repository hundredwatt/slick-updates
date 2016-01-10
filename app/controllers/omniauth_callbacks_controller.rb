class OmniauthCallbacksController < Foyer::OmniauthCallbacksController
  def callback
    @user = User.find_or_create_by(uid: auth_hash.uid)
    @user.update_attributes \
      email: auth_hash.info.email,
      current_sign_in_at: Time.current,
      current_sign_in_ip: request.ip

    sign_in @user

    redirect_to after_sign_in_path
  end

  def after_sign_in_path
    return origin if origin.to_s.match(%r{^\/}) || origin.to_s.match(%r{^#{request.scheme}://#{request.host}})
    update_forms_path
  end
end
