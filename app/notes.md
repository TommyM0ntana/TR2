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
