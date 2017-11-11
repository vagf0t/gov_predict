require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  describe 'GET #index' do
    it 'renders the index json' do
      expect(Post).to receive(:all_posts).and_return 'foo'
      get :index
      expect(response.body).to eq 'foo'
      expect(response.code).to eq '200'
    end
  end

  describe 'GET #search' do
    context 'param query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param account query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            account_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, account_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param name_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            name_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, name_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param surname_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            surname_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, surname_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param post_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            post_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, post_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param from_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            from_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, from_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param to_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            to_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, to_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param link_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            link_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, link_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param original_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            original_link_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, original_link_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param federal_legislators_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            federal_legislators_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, federal_legislators_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param federal_agency_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            federal_agency_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, federal_agency_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param industry_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            industry: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, industry: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end

    context 'param state_governors_query' do
      it 'renders the search json' do
        expect(Post).to receive(:search_results_for).with(
            state_governors_query: 'bar',
            controller: 'api/posts',
            action: 'search').and_return 'foo'
        get :search, state_governors_query: 'bar'
        expect(response.body).to eq 'foo'
        expect(response.code).to eq '200'
      end
    end
  end
end
