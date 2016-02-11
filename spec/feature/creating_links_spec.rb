require_relative '../../app/models/link'

feature 'adding links' do 
	it 'allows us to add a link' do
	visit('/links/new')
 	fill_in('linkname', with: 'facebook')
 	fill_in('url', with: 'facebook.com')
 	click_button "submit"
 	expect(page).to have_content 'facebook - facebook.com'
 end
end