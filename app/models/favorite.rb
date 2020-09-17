class Favorite < ApplicationRecord
	belong_to :user
	brlong_to :book
end
