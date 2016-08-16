require 'web_helper'
feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, fred@example.com')
    expect(User.first.email).to eq('fred@example.com')
  end

  scenario 'requires a matching password for confirmation' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end
end