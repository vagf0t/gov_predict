require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should have_many(:posts).through :social_media_accounts }
  it { should have_many(:social_media_accounts) }
  it { should have_and_belong_to_many(:lists) }

  it 'responds to dynamic methods' do
    SocialMediaType.all.each do |type|
      expect(subject).to respond_to("has_#{type.name.downcase}_account?".to_sym)
    end
  end
end
