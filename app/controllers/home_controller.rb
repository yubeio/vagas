class HomeController < ApplicationController

  def index
    @client = Client.all
  end

end
