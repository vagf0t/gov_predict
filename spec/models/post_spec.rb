require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:person) }
  it { should belong_to(:social_media_account) }

  describe '#all_posts' do
    it 'should contain the right fields in the result set' do
      result = Post.all_posts.first.attributes
      expect(result.keys).to contain_exactly('name',
                                             'surname',
                                             'account',
                                             'content',
                                             'posted_at',
                                             'url',
                                             'original_url',
                                             'id')
    end
  end

  describe '#search_results_for' do
    it 'should contain the right fields in the result set' do
      result = Post.search_results_for('Darth').first.attributes
      expect(result.keys).to contain_exactly('name',
                                             'surname',
                                             'account',
                                             'content',
                                             'posted_at',
                                             'url',
                                             'original_url',
                                             'id',
                                             'social_account')
    end
  end
end
