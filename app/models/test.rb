class Test < ActiveRecord::Base
	has_many :questions
	has_many :scales , :dependent => :delete_all
	has_many :answers, through: :questions	
end
