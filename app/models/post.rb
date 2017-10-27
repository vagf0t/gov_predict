
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

  def self.search_results_for(query)
    Post.all_posts
        .joins('inner join lists_people on people.id = lists_people.person_id')
        .joins('inner join lists on lists.id = lists_people.list_id')
        .where('people.name LIKE ? OR
                people.surname LIKE ? OR
                lists.name LIKE ? OR
                social_media_types.name LIKE ? OR
                posts.url LIKE ? OR
                posts.original_url LIKE ? OR
                posts.content LIKE ?',
               "%#{query}%",
               "%#{query}%",
               "%#{query}%",
               "%#{query}%",
               "%#{query}%",
               "%#{query}%",
               "%#{query}%")
        .select('social_media_accounts.user_id as social_account')
        .group('social_account')
        .group('people.name')
        .group('people.surname')
        .group('lists.name')
        .group('social_media_types.name')
        .group('posts.url')
        .group('posts.original_url')
        .group('posts.content')
        .group('posts.posted_at')
        .group('posts.id').uniq
  end
end
