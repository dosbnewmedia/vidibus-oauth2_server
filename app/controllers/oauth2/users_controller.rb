class Oauth2::UsersController < Oauth2Controller
  before_filter :ensure_token!
  before_filter :find_user

  def show
    render :json => @user.attributes.only(*%w[name email uuid])
  end

  protected

  def find_user
    @user = find_user_by_uuid(@access_token.user_id) or render(:nothing => true, :status => :bad_request)
  end

  def ensure_token!
    unless token = params[:access_token] || params[:oauth_token]
      raise Vidibus::Oauth2Server::MissingTokenError
    end
    @access_token = Oauth2Token.find!(:token => token)
  end
end
