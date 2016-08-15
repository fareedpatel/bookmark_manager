require_relative '../../app/models/link'
feature 'Adding tags' do

  scenario 'allows us to add a single tag to a link' do
    visit('/links/new')
    fill_in('title', with: 'facebook')
    fill_in('url', with: 'facebook.com')
    fill_in('tags', with: 'socialmedia')
    click_button "submit"
    link = Link.first
    expect(link.tags.map(&:name)).to include('socialmedia')
  end

    scenario 'allows us to add multiple tags to a link' do
    visit('/links/new')
    fill_in('title', with: 'facebook')
    fill_in('url', with: 'facebook.com')
    fill_in('tags', with: 'socialmedia news')
    click_button "submit"
    link = Link.first
    expect(link.tags.map(&:name)).to include('socialmedia', 'news')
  end
end