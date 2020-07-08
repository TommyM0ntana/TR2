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

Chapter 10

Domanda 1)

10.1.1

Perchè nel form di login e edit abbiamo lo stesso form e due metodi diversi?Quello dell'edit dovrebbe essere PATCH invece è POST.

Domanda 2)

10.1.4 Successful Edits

1. Store location. Relationship with the session?
2. Assegnamento password allow_nil del user. How it knows that have to goes to the integration test validation?
   3)Differenza tra assert e assert_not_nil?

Domanda 3)

10.3.2

Sample users / Seeds

Differenza tra metodo create e create! nel seeds?(eccezione se dovesse falire per un qualsiasi motivo )
Facilita il debugging impedendo che gli errori passino inosservati.

Chap 11

1.What means when user is saved in memory e in database?

assert user.reload.activated?
before make the update with reload.

2.Test utilities?
assert = true
assert_not_nil = that is not nil?

Chap 12

3.Non avendo disponibile la email come parametro nel reset_form si inserisce:
<%= hidden_field_tag :email, @user.email %>
E' l'unico modo di avere i parametri della email del user available?

http://example.com/password_resets/3BdBrXeQZSWqFIDRN8cxHA/edit?email=foo%40bar.com

chap 13

1.micropost_test/test

test 'User id should be present' do
@micropost.user_id = nil
assert_not @micropost.valid?

# assert @micropost.user_id.present?

# assert_not @micropost.user_id.blank?

# assert_not_nil @micropost.user_id

2. Differenza tra find_by e where?
   fare esempio nella console.

3. default_scope -> { order(created_at: :desc) }

4.microposts_controller/correct_user
