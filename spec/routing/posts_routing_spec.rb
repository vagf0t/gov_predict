require 'rails_helper'

RSpec.describe 'routes for Posts', type: :routing do
  it 'routes api/posts to the posts controller' do
    expect(get: '/api/posts').to route_to(controller: 'api/posts', action: 'index')
  end

  it 'routes api/posts/search to the posts controller' do
    expect(get: '/api/posts/search').to route_to(controller: 'api/posts', action: 'search')
  end
end