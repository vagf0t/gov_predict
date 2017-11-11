
class Post < ApplicationRecord
  belongs_to :person
  belongs_to :social_media_account

  public

  def self.all_posts
    Post.joins(:person)
        .joins(social_media_account: :social_media_type)
        .select('people.name')
        .select('people.surname')
        .select('social_media_types.name as account')
        .select('posts.content')
        .select('posts.posted_at')
        .select('posts.url')
        .select('posts.original_url')
        .select('posts.id')
  end

  def self.search_results_for(params)
    query = Post.all_posts
        .joins('inner join lists_people on people.id = lists_people.person_id')
        .joins('inner join lists on lists.id = lists_people.list_id')
    query = define_criteria(query, params)
    query.select('social_media_accounts.user_id as social_account')
        .group('social_media_accounts.user_id')
        .group('people.name')
        .group('people.surname')
        .group('lists.name')
        .group('social_media_types.name')
        .group('posts.url')
        .group('posts.original_url')
        .group('posts.content')
        .group('posts.posted_at')
        .group('posts.id').distinct.order(:id)
  end

  def self.define_criteria(query, params)
    search_input_criteria = params[:query]
    unless search_input_criteria.blank?
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
    query = query.where('people.name LIKE ?', "#{name}%") unless name.blank?
    surname = params[:surname_query]
    query = query.where('people.surname LIKE ?', "#{surname}%") unless surname.blank?
    account = params[:account_query]
    query = query.where('social_media_types.name LIKE ?', "#{account}%") unless account.blank?
    post = params[:post_query]
    query = query.where('posts.content LIKE ?', "#{post}%") unless post.blank?
    link = params[:link_query]
    query = query.where('posts.url LIKE ?', "#{link}%") unless link.blank?
    original_link = params[:original_link_query]
    query = query.where('posts.original_url LIKE ?', "#{original_link}%") unless original_link.blank?
    from = params[:from_query]
    query = query.where('posts.posted_at >= ?', from.to_s) unless from.blank?
    to = params[:to_query]
    query = query.where('posts.posted_at <= ?', to.to_s) unless to.blank?
    federal_legislators = params[:federal_legislators_query]
    query = query.where('lists.name = ?', 'Federal Legislators') if federal_legislators == 'true'
    industry = params[:industry_query]
    query = query.where('lists.name = ?', 'Industry') if industry == 'true'
    state_governors = params[:state_governors_query]
    query = query.where('lists.name = ?', 'State Governors') if state_governors == 'true'
    federal_agency = params[:federal_agency_query]
    query = query.where('lists.name = ?', 'Federal Agency') if federal_agency == 'true'
    query
  end
end
