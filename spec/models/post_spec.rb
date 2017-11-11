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
    context 'general search' do
      it 'should contain the right fields in the result set' do
        result = Post.search_results_for(query: 'Darth').first.attributes
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

      it 'should search in the name field' do
        results = Post.search_results_for(query: 'Darth')
        expect(results.count('people.name').size).to eq 4
      end

      it 'should search in the surname field' do
        results = Post.search_results_for(query: 'Vader')
        expect(results.count(:surname).size).to eq 4
      end

      it 'should search in the account field' do
        results = Post.search_results_for(query: 'Twitter')
        expect(results.all.map(&:account).size).to eq 4
      end

      it 'should search in the content field' do
        results = Post.search_results_for(query: 'Twitter content')
        expect(results.all.map(&:content).size).to eq 4
      end

      it 'should search in the url field' do
        results = Post.search_results_for(query: 'Twitter link')
        expect(results.all.map(&:url).size).to eq 4
      end

      it 'should search in the original url field' do
        results = Post.search_results_for(query: 'original Twitter link')
        expect(results.all.map(&:original_url).size).to eq 4
      end
    end

    context 'name filter' do
      it 'should filter by name' do
        results = Post.search_results_for(name_query: 'Darth')
        expect(results.count('people.name').size).to eq 4
      end
    end

    context 'surname filter' do
      it 'should filter by surname' do
        results = Post.search_results_for(surname_query: 'Vader')
        expect(results.count(:surname).size).to eq 4
      end
    end

    context 'account filter' do
      it 'should filter by account' do
        results = Post.search_results_for(account_query: 'Twitter')
        expect(results.all.map(&:account).size).to eq 4
      end
    end

    context 'post filter' do
      it 'should filter by post' do
        results = Post.search_results_for(post_query: 'Twitter content')
        expect(results.all.map(&:content).size).to eq 4
      end
    end

    context 'link filter' do
      it 'should filter by link' do
        results = Post.search_results_for(link_query: 'Twitter link')
        expect(results.all.map(&:url).size).to eq 4
      end
    end

    context 'original link filter' do
      it 'should filter by original link' do
        results = Post.search_results_for(original_link_query: 'original Twitter link')
        expect(results.all.map(&:original_url).size).to eq 4
      end
    end

    context 'date filters' do
      it 'should filter by from date' do
        results = Post.search_results_for(from_query: '2017-10-3')
        expect(results.all.map(&:posted_at).size).to eq 9
      end

      it 'should filter by to date' do
        results = Post.search_results_for(to_query: '2017-10-3')
        expect(results.all.map(&:posted_at).size).to eq 4
      end

      it 'should filter by from-to dates' do
        results = Post.search_results_for(from_query: '2017-10-2', to_query: '2017-10-3')
        expect(results.all.map(&:posted_at).size).to eq 4
      end
    end

    context 'lists' do
      it 'should filter federal legislators` posts' do
        results = Post.search_results_for(federal_legislators_query: 'true')
        expect(results.count(:all).size).to eq 6
        expect(results.all.map(&:surname).uniq).to eq ['Amidala', 'Yoda']
      end

      it 'should filter industry posts' do
        results = Post.search_results_for(industry_query: 'true')
        expect(results.count(:all).size).to eq 4
        expect(results.all.map(&:surname).uniq).to eq ['Vader']
      end

      it 'should filter state governors` posts' do
        results = Post.search_results_for(state_governors_query: 'true')
        expect(results.count(:all).size).to eq 6
        expect(results.all.map(&:surname).uniq).to eq ['Amidala', 'Yoda']
      end

      it 'should filter federal agency posts' do
        results = Post.search_results_for(federal_agency_query: 'true')
        expect(results.count(:all).size).to eq 5
        expect(results.all.map(&:surname).uniq).to eq ['Yoda', 'Skywalker']
      end
    end

    context 'composite searches' do
      it 'should filter federal legislators` posts on Twitter' do
        results = Post.search_results_for(federal_legislators_query: 'true', account_query: 'Twitter')
        expect(results.count(:all).size).to eq 2
        expect(results.all.map(&:surname).uniq).to eq ['Amidala', 'Yoda']
      end

      it 'should filter posts on Twitter by from-to dates' do
        results = Post.search_results_for(from_query: '2017-10-2', to_query: '2017-10-3', account_query: 'Twitter')
        expect(results.count(:all).size).to eq 1
        expect(results.all.map(&:surname).uniq).to eq ['Vader']
      end

      it 'should filter posts by a general phrase and from-to dates' do
        results = Post.search_results_for(from_query: '2017-10-2', to_query: '2017-10-3', query: 'Twitter')
        expect(results.count(:all).size).to eq 1
        expect(results.all.map(&:surname).uniq).to eq ['Vader']
      end

      it 'should filter Facebook posts of Master Yoda' do
        results = Post.search_results_for(name_query: 'Master', surname_query: 'Yoda', account_query: 'Facebook')
        expect(results.all.map(&:posted_at).size).to eq 1
      end
    end
  end
end
