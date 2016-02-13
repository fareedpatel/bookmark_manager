 require_relative '../../app/models/link'

feature 'Viewing Links' do 
		scenario 'I can see a list of links' do

			Link.create(title: 'GOOGLE', url: 'google.com')
			visit '/links'

			#the following expectation checks that everything is working.	
			expect(page.status_code).to eq 200	


			within 'ul#links' do
			expect(page).to have_content('Title: GOOGLE URL: google.com')
		end
	end
end

