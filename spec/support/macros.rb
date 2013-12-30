def set_current_user
  alice = Fabricate(:regular_user)
  session[:user_id] = alice.id
end

def current_user
  RegularUser.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def set_current_admin(admin=nil)
  session[:user_id] = (admin || Fabricate(:admin)).id
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:regular_user)
  visit sign_in_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end

def sign_out
  visit sign_out_path
end