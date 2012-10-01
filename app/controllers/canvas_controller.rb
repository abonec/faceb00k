class CanvasController < ApplicationController
  def index
    results = parse_request.with_indifferent_access
    if results[:oauth_token]
      user = User.find_or_initialize_by_oauth_token(results[:oauth_token])
      if user.new_record?
        user.provider = 'facebook'
        user.uid = results[""]
        user.name = results[""]
        user.oauth_token = results[:oauth_token]
        user.oauth_expires_at = Time.at(results[:h].to_i)
        user.save!
      end
    end
      render json: [parse_request, session[:user_id], env["omniauth.auth"]]
  end


  private
  def parse_request
    sign, param = params['signed_request'].split '.'
    param = Base64.decode64 param
    param << "}" if param.last != "}"
    param = JSON.parse param
    param
  end
end
