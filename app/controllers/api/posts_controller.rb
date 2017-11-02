
module Api
  class PostsController < ApplicationController
    def index
      render json: Post.all_posts
    end

    def search
      render json: Post.search_results_for(params)
    end
  end
end
