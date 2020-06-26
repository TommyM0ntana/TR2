class User < ApplicationRecord
 #add virtual attributes for the remember token 
  attr_accessor :remember_token, :activation_token
  #action that fires of before the active record obj was created
  before_create :create_activation_digest
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 201},
            format: { with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false }
            #autom creates virtual attributes pass & pass_confirmation
            #doesn't exist in the database
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

#Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
     BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)
  end

#Returns a random token 
  def User.new_token
    SecureRandom.urlsafe_base64
  end

#create corrinsponding digest to the token
#Remember a user in the database for use a persistent sessions when they log in
#calling the user.remember to find the user with the remember token that #is in database and create a remember digest 
  def remember
    #Create new token/remember token
    self.remember_token = User.new_token  
    update_attribute(:remember_digest, User.digest(remember_token)) #Update the remember_digest with the digest of the token
  end

# # Compair & returns true if the given remember token matches with the remember digest.
  # def authenticated?(remember_token)
  #     return false if remember_digest.nil?
  #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
  #     #Second way to do it
  #     #BCrypt::Password.new(remember_digest) == remember_token
  # end

def authenticated?(attribute, token)
  digest = send("#{attribute}_digest")
  return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(token)
end
 


#Just undo the remember, returning the digest with nil
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
  
  def downcase_email
    email.downcase!
    # self.email = email.downcase
  end

 #Create and assigns the activation token and digest to user.
  def create_activation_digest
    #create new activation_token to user
    self.activation_token = User.new_token
    #associate and save the digest in database automaticaly when we create the user
    self.activation_digest = User.digest(activation_token)
  end


end