require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  describe 'GET #index' do
    it 'renders the index json' do
      expect(Post).to receive(:all_posts).and_return 'foo'
      get :index
      expect(response.body).to eq 'foo'
    end
  end

  describe 'GET #search' do
    it 'renders the search json' do
      expect(Post).to receive(:search_results_for).with('bar').and_return 'foo'
      get :search, query: 'bar'
      expect(response.body).to eq 'foo'
    end
  end
end
