class HomeController < ApplicationController
  def index 
    @engine = Koala::Facebook::API.new(current_user.oauth_token)

    @name = @engine.get_object("me")["name"]
  end
end
