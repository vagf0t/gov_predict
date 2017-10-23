
unless SocialMediaType.find_by_name 'Facebook'
  st = SocialMediaType.new
  st.name = 'Facebook'
  st.description = 'A social platform to connect with friends, family and other
  people you know. Share photos and videos, send messages and get updates'
  st.save!
end

unless SocialMediaType.find_by_name 'Twitter'
  st = SocialMediaType.new
  st.name = 'Twitter'
  st.description = 'From breaking news and entertainment to sports and politics,
  get the full story with all the live commentary.'
  st.save!
end

unless SocialMediaType.find_by_name 'Pinterest'
  st = SocialMediaType.new
  st.name = 'Pinterest'
  st.description = 'Discover recipes, home ideas, style inspiration and other ideas to try.'
  st.save!
end

unless SocialMediaType.find_by_name 'Instagram'
  st = SocialMediaType.new
  st.name = 'Instagram'
  st.description = ' A simple, fun & creative way to capture, edit & share photos,
  videos & messages with friends & family.'
  st.save!
end