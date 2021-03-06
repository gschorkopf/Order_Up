class Order < ApplicationRecord
	has_many :restaurants
	has_and_belongs_to_many :items
	accepts_nested_attributes_for :items, allow_destroy: true

	validates_presence_of :restaurant_id
	validates_presence_of :section
	validates_presence_of :seat

	before_save :set_location

	SECTION = ['A', 'B', 'C', 'D', 'E']

	private

		def set_location
			self.location = ['A', 'B', 'C'].include?(section) ? 'BREW' : 'COMD'
		end
end
