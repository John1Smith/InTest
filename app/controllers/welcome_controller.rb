class WelcomeController < ApplicationController
  def index
  	redirect_to url_for(:controller => :results)
  end
end
