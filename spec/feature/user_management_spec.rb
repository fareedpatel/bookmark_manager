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

  scenario 'with a password confirmation that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password and confirmation password do not match')
  end

  scenario 'I cannot sign up without an e-mail address' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    # expect(page).to have_content('Please input a valid e-mail address')
  end

  scenario 'i cannot sign up with an invalid e-mail address' do
    expect {sign_up(email: 'fred@invalid') }.not_to change(User, :count)
  end
end