require 'rails_helper'

feature 'Sender' do
	let!(:user) { FactoryBot.create(:user) }
	let!(:restaurant) { FactoryBot.create(:restaurant) }
	let!(:item_1) { FactoryBot.create(:item, restaurant_id: restaurant.id) }
	let!(:item_2) { FactoryBot.create(:item, restaurant_id: restaurant.id) }
	let!(:item_3) { FactoryBot.create(:item, restaurant_id: restaurant.id) }

	context 'when a Sender arrives to orders#new' do
		scenario 'the restaurant dropdown is visible', focus: true, js: true do
			# user = FactoryBot.create(:user)
			# restaurant = FactoryBot.create(:restaurant)
			# item_1 = FactoryBot.create(:item, restaurant_id: restaurant.id)
			# item_2 = FactoryBot.create(:item, restaurant_id: restaurant.id)
			# item_3 = FactoryBot.create(:item, restaurant_id: restaurant.id)

			sign_in(user)

			## Select if you're a sender or a receiver
			click_on 'Sender'
			## Choose a Restaurant
			select(restaurant.name, from: 'order[restaurant_id]')
			
			## Select a Section
			select('A', from: 'order[section]')

			## Select a Seat number
			select(rand(5..50), from: 'order[seat]')
			
			## Select 2 items from the menu
			find_first_action('add-item').click
			find_last_action('add-item').click

			## Send order and check that an order is created on the backend
			allow(Item).to receive(:all).and_return([item_1, item_2, item_3])
			
			expect do
				click_on 'Create Order'
			end.to change(Order, :count).by(1)
		end
	end
end