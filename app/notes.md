1 Q.Has_secure_password, Password_digest e Bcrypt how they actualy collaborate behind the scenes not having a direct relationship?

--Differences between Users and Sessions

# Users | Sessions

1.Data Database(model) | Cookie

2.Routes get,post,patch,delete | get,post,delete

---

In comune: both have Controlles and routes, restfull come resources (their routes,http request,URL's and actions).
Difference: Users have model, Sessions instead have Cookies.

4.Q Fixtures - we will use it often like in this case for valid user in the test database?

5.Reset Session and “Session Fixation"",involves an attacker setting your session id,but if i reset in upon autenticated will reset also all the data that wish to preserve.

Resets the session by clearing out all the objects stored within and initializing a new session object.it's not better put it when signout?

6.Difference between Temporary and Permanent Sessions.

# Temporary | Permanent

1.Data Database(model) | Cookie

2.Routes get,post,patch,delete | get,post,delete

---

7.Cookies vulnerability of sessions hijicking.
-have you ever have some kind of attack?

8.cookies.permanent.encrypted[:user_id] = user.id
Permanent ?When expires? is equivalent to 20.years.from_now

cookies[:remember_token] = { value: remember_token,
expires: 20.years.from_now.utc }
|| ?
cookies.permanent[:remember_token] = remember_token

Where i can see when my cookie will actually expire?

9. Refactoring

# Returns the user corresponding to the remember token cookie.

def current_user
if (user_id = session[:user_id])
@current_user ||= User.find_by(id: user_id)
elsif (user_id = cookies.encrypted[:user_id])
user = User.find_by(id: user_id)
if user && user.authenticated?(cookies[:remember_token])
log_in user
@current_user = user
end
end
end

def current_user
if session[:user_id]
@current_user ||= User.find_by(id: session[:user_id])
elsif cookies.encrypted[:user_id]
user = User.find_by(id: cookies.encrypted[:user_id])
if user && user.autenticated?(cookies[:remember_token])
log_in user
@current_user = user
end
end
end

10. In user.rb the forget method.
    Why not set also the remember_token to nil, or its like automaticaly that making the remember digest to nil ,so
    remember_token can't be used anymore
    def forget
    update_attribute(:remember_digest, nil)
    #remember_token = nul
    end



12) Edit form.
13) Inspecting we notice that we have in the form tag POST Request and it should be PATCH. E sotto invece nell'input abbiamo il value= 'PATCH'.é cosi che finge un patch nel browser?
    Browsers can't send PATCH requests natively
    finge una PATCH request inside of the browser.
    with the extra input field.

Why? is all automated by users :resources like just knows that routes this post request and if value patch to actually make a patch request to the right action on the users contoller?
So patch update action.
How it knows to put this extra input fields?
The code in the both forms new and edit is exatcly the same :
<%= form_with(model: @user, local: true) do |f| %>
HTTPrequest URL Action Named route Purpose

GET /users/1/edit edit edit_user_path to edit user id 1

DELETE /users/1 destroy user_path(user) delete user

He expalains with the new_record method,thet is actually a boolean meethod to understand if the user is new and on the base on that just knows that if is new to create a post request and if not new already exist will create a PATCH request.



10.1.4 Successful Edits

Test di accetazione. TDD

test 'successful edit' do
  get edit_user_path(@user)
  assert_template 'users/edit'
  name = 'Tommy'
  email = 'tommy@gmail.com'
  patch user_path(@user), params: { user: { name: name,
  email: email,
  password:'',
  password_confirmation:'' }}

  assert_not flash.empty?
  assert_redirected_to @user
  @user.reload
  assert_equal name, @user.name
  assert_equal email, @user.email
end
