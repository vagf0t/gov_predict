class Person < ApplicationRecord
  has_and_belongs_to_many :lists
  has_many :social_media_accounts
  has_many :posts, through: :social_media_accounts

  # Define a method for each social media type to reply
  # whether this person has an account of this type or not.
  SocialMediaType.all.each do |type|
    define_method :"has_#{type.name.downcase}_account?" do
      social_media_accounts.where(social_media_type_id: type.id).first.present?
    end
  end
end
