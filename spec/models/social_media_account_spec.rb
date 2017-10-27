require 'rails_helper'

RSpec.describe SocialMediaAccount, type: :model do
  it { should have_many(:posts) }
  it { should belong_to(:person) }
  it { should belong_to(:social_media_type) }
end
