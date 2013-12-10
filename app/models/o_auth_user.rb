class OAuthUser

  attr_reader :provider, :user

  def initialize(creds, user=nil)
    @auth       = creds
    @user       = user
    @provider   = @auth.provider
  end
end