class User < ActiveRecord::Base
	has_secure_password

  def self.from_omniauth(auth)
    user = find_or_create_by(provider: auth.provider, uid: auth.uid)
    
    user.name                   = auth.info.name
    user.oauth_token            = auth.credentials.token
    user.oauth_token_expires_at = Time.at(auth.credentials.expires_at)
    user.save

    user
  end
end
