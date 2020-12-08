class User < ApplicationRecord

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: { message: 'Password cannot be blank' }
    validates :password, length: { minimum: 6 }, allow_nil: true
    
    after_initialize :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(email, password)
        user = User.find_by(email:email)

        return user if user && user.is_password?(password)
        nil
    end

    def is_password?(password)
        bcrypt_password = BCrypt::Password.new(self.password_digest) # <= converts password_digest string to BCrypt object
        bcrypt_password.is_password?(password)
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64 #default 16 bits
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token # <= uses user's current session token or creates a new one and saves to db
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    
end
