class User < ApplicationRecord
    
    has_secure_password
    
    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
    
    
    validates :first_name, :presence => true,
                                                   :length => { :maximum => 25 }
    validates :last_name, :presence => true,
                          :length => { :maximum => 50 }
    validates :email, :presence => true,
                      :length => { :maximum => 100 },
                      :format => EMAIL_REGEX,
                      :confirmation => true,
                      :uniqueness => true

    
    scope :sorted, lambda { order('last_name ASC, first_name ASC')}

    def name
      "#{first_name} #{last_name}"
      # Or: first_name + ' ' + last_name
      # Or: [first_name, last_name].join(' ')
    end
    
    has_many :checkouts
end
