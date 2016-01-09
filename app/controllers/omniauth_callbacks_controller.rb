class OmniauthCallbacksController < Foyer::OmniauthCallbacksController
  def callback
    sign_in User.new(id: auth_hash.uid, email: auth_hash.info.email)

    redirect_to after_sign_in_path
  end

  # Override to support email store in session.
  def sign_in(user)
    session[Foyer.session_key] = {
      id: user.id,
      email: user.email,
      current_sign_in_at: Time.current,
      current_sign_in_ip: request.ip
    }.with_indifferent_access
  end
end
