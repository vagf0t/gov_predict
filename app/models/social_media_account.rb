class SocialMediaAccount < ApplicationRecord
  belongs_to :social_media_type
  belongs_to :person
  has_many :posts
end
