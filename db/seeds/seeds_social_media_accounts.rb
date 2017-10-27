
facebook = SocialMediaType.find_by_name 'Facebook'
twitter = SocialMediaType.find_by_name 'Twitter'
instagram = SocialMediaType.find_by_name 'Instagram'
pinterest = SocialMediaType.find_by_name 'Pinterest'

# Princess Amidala's Accounts
p = Person.where(name: 'Princess').where(surname: 'Amidala').first
unless p.has_twitter_account?
  a = SocialMediaAccount.new
  a.user_id = 'Princess Twitter'
  a.social_media_type = twitter
  a.person = p
  a.save!
end

unless p.has_facebook_account?
  a = SocialMediaAccount.new
  a.user_id = 'Princess Facebook'
  a.social_media_type = facebook
  a.person = p
  a.save!
end

unless p.has_instagram_account?
  a = SocialMediaAccount.new
  a.user_id = 'Princess Instagram'
  a.social_media_type = instagram
  a.person = p
  a.save!
end

unless p.has_pinterest_account?
  a = SocialMediaAccount.new
  a.user_id = 'Princess Pinterest'
  a.social_media_type = pinterest
  a.person = p
  a.save!
end

# Master Yoda's accounts
p = Person.where(name: 'Master').where(surname: 'Yoda').first
unless p.has_twitter_account?
  a = SocialMediaAccount.new
  a.user_id = 'Yoda Twitter'
  a.social_media_type = twitter
  a.person = p
  a.save!
end

unless p.has_facebook_account?
  a = SocialMediaAccount.new
  a.user_id = 'Yoda Facebook'
  a.social_media_type = facebook
  a.active = false
  a.person = p
  a.save!
end

# Luke Skywalker's Accounts
p = Person.where(name: 'Luke').where(surname: 'Skywalker').first
unless p.has_twitter_account?
  a = SocialMediaAccount.new
  a.user_id = 'Skywalker Twitter'
  a.social_media_type = twitter
  a.person = p
  a.save!
end

unless p.has_facebook_account?
  a = SocialMediaAccount.new
  a.user_id = 'Skywalker Facebook'
  a.social_media_type = facebook
  a.person = p
  a.save!
end

unless p.has_instagram_account?
  a = SocialMediaAccount.new
  a.user_id = 'Skywalker Instagram'
  a.social_media_type = instagram
  a.active = false
  a.person = p
  a.save!
end

# Darth Vader's Accounts
p = Person.where(name: 'Darth').where(surname: 'Vader').first
unless p.has_twitter_account?
  a = SocialMediaAccount.new
  a.user_id = 'Vader Twitter'
  a.social_media_type = twitter
  a.person = p
  a.save!
end

unless p.has_facebook_account?
  a = SocialMediaAccount.new
  a.user_id = 'Vader Facebook'
  a.social_media_type = facebook
  a.person = p
  a.active = false
  a.save!
end

unless p.has_instagram_account?
  a = SocialMediaAccount.new
  a.user_id = 'Vader Instagram'
  a.social_media_type = instagram
  a.active = false
  a.person = p
  a.save!
end

unless p.has_pinterest_account?
  a = SocialMediaAccount.new
  a.user_id = 'Vader Pinterest'
  a.social_media_type = pinterest
  a.active = false
  a.person = p
  a.save!
end