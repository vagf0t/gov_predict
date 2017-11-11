
# Princess Amidala's Posts
person = Person.where(name: 'Princess').where(surname: 'Amidala').first
if person.posts.blank?
  person.social_media_accounts.each do |account|
    post = Post.new
    post.content = "#{account.social_media_type.name} content"
    post.posted_at = Time.now
    post.url = "#{account.social_media_type.name} link"
    post.original_url = "original #{account.social_media_type.name} link"
    post.social_media_account = account
    post.person = person
    post.save!
  end
end

# Master Yoda's posts
person = Person.where(name: 'Master').where(surname: 'Yoda').first
if person.posts.blank?
  person.social_media_accounts.each do |account|
    post = Post.new
    post.content = "#{account.social_media_type.name} content"
    post.posted_at = Time.now
    post.url = "#{account.social_media_type.name} link"
    post.original_url = "original #{account.social_media_type.name} link"
    post.social_media_account = account
    post.person = person
    post.save!
  end
end


# Luke Skywalker's Posts
person = Person.where(name: 'Luke').where(surname: 'Skywalker').first
if person.posts.blank?
  person.social_media_accounts.each do |account|
    post = Post.new
    post.content = "#{account.social_media_type.name} content"
    post.posted_at = Time.now
    post.url = "#{account.social_media_type.name} link"
    post.original_url = "original #{account.social_media_type.name} link"
    post.social_media_account = account
    post.person = person
    post.save!
  end
end

# Darth Vader's Posts
person = Person.where(name: 'Darth').where(surname: 'Vader').first
if person.posts.blank?
  person.social_media_accounts.each do |account|
    post = Post.new
    post.content = "#{account.social_media_type.name} content"
    post.posted_at = '2017-10-2'
    post.url = "#{account.social_media_type.name} link"
    post.original_url = "original #{account.social_media_type.name} link"
    post.social_media_account = account
    post.person = person
    post.save!
  end
end