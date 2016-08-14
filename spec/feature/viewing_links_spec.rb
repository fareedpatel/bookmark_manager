feature 'Viewing links' do

  	before(:each) do
  	Link.create(url:'www.google.com', title: 'Google', tags: [Tag.first_or_create(name:'searchengine')])
  	Link.create(url:'www.bing.com', title: 'Bing', tags: [Tag.first_or_create(name:'searchengine')])
  	Link.create(url:'www.ebay.co.uk', title: 'Ebay', tags: [Tag.first_or_create(name:'marketplace')])
  	Link.create(url:'www.etsy.com', title: 'Etsy', tags: [Tag.first_or_create(name:'marketplace')])
  	Link.create(url:'www.easyjet.com', title: 'easyjet', tags: [Tag.first_or_create(name:'flights')])
  end

  scenario 'I can filter by tag names' do
  visit '/tags/marketplace'
    expect(page.status_code).to eq 200


    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('youtube.com')
      expect(page).to have_content('Ebay')
      expect(page).to have_content('Etsy')
    end
  end
end