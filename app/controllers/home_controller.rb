class HomeController < ApplicationController

  def index
    @clients = Client.where("status = ?", 0)
    @client = Client.new
  end

end
