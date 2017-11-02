
class Post < ApplicationRecord
  belongs_to :person
  belongs_to :social_media_account

  public

  def self.all_posts
    Post.joins(:person)
        .joins(social_media_account: :social_media_type)
        .select('people.name,
                people.surname,
                social_media_types.name as account,
                posts.content,
                posts.posted_at,
                posts.url,
                posts.original_url,
                posts.id')
  end

  def self.search_results_for(params)
    query = Post.all_posts
        .joins('inner join lists_people on people.id = lists_people.person_id')
        .joins('inner join lists on lists.id = lists_people.list_id')
    query = define_criteria(query, params)
    query.select('social_media_accounts.user_id as social_account')
        .group('social_account')
        .group('people.name')
        .group('people.surname')
        .group('lists.name')
        .group('social_media_types.name')
        .group('posts.url')
        .group('posts.original_url')
        .group('posts.content')
        .group('posts.posted_at')
        .group('posts.id').distinct
  end

  def self.define_criteria(query, params)
    search_input_criteria = params[:query]
    if search_input_criteria
      query = query.where('people.name LIKE ? OR
                people.surname LIKE ? OR
                lists.name LIKE ? OR
                social_media_types.name LIKE ? OR
                posts.url LIKE ? OR
                posts.original_url LIKE ? OR
                posts.content LIKE ?',
                          "#{search_input_criteria}%",
                          "#{search_input_criteria}%",
                          "#{search_input_criteria}%",
                          "#{search_input_criteria}%",
                          "#{search_input_criteria}%",
                          "#{search_input_criteria}%",
                          "#{search_input_criteria}%")
    end
    name = params[:name_query]
    if name
      query = query.where('people.name LIKE ?', "#{name}%")
    end
    surname = params[:surname_query]
    if surname
      query = query.where('people.surname LIKE ?', "#{surname}%")
    end
    account = params[:account_query]
    if account
      query = query.where('social_media_types.name LIKE ?', "#{account}%")
    end
    post = params[:post_query]
    if post
      query = query.where('posts.content LIKE ?', "#{post}%")
    end
    link = params[:link_query]
    if link
      query = query.where('posts.url LIKE ?', "#{link}%")
    end
    original_link = params[:original_link_query]
    if original_link
      query = query.where('posts.original_url LIKE ?', "#{original_link}%")
    end
    query
  end
end
