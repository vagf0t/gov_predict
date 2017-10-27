
module Api
  class PostsController < ApplicationController
    def index
      render json: Post.all_posts
    end

    def search
      query = params[:query]
      render json: Post.search_results_for(query)
    end
  end
end
