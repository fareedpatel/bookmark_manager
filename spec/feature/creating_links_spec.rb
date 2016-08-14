require_relative '../../app/models/tag'

feature 'adding links' do 
  it 'allows us to add a link' do
    visit('/links/new')
    fill_in('title', with: 'facebook')
    fill_in('url', with: 'facebook.com')
    click_button "submit"
  #we expect to be redirected back to the links page
  expect(current_path).to eq '/links'

    within 'ul#links' do
        expect(page).to have_content 'Title: facebook URL: facebook.com'
    end
  end
end