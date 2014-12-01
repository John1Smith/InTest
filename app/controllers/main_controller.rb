class MainController < ApplicationController
	def index
    	@tests = Test.all
    end
    def save_all
    	render "save_all"
    end
end
