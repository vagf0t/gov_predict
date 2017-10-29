
class SocialMediaAccount < ApplicationRecord
  belongs_to :social_media_type
  belongs_to :person
  has_many :posts

  # Note: Depending on the load of SocialMediaAccount objects being created,
  # the following trigger could be scheduled asynchronously with a Delayed::Job
  # and therefore decouple the answer of our CREATE action of this resource from
  # the creation of a FederalLegislator and reduce the response time as well. Another
  # approach is to let an exception be thrown and return 500 to any client,
  # trying to create a SocialMediaAccount, in case something goes wrong with the
  # creation of a FederalLegislator. Here, I have assumed that we will not block
  # the creation of a SocialMediaAccount if a FederalLegislator fails to be created.
  # Nevertheless, I log the fails to cope with them in the context of a task,
  # external to this service. There is also a pending question, as to whether we
  # create a FederalLegislator with neither a Facebook or a Twitter account. Can
  # external systems, making use of the federal_legislators table, handle such cases?
  # I have made the assumption that they do not and I log such cases.
  after_save :update_federal_legislators

  # Define a method for each social media type to reply
  # whether this account of this type or not.
  SocialMediaType.all.each do |type|
    define_method :"is_#{type.name.downcase}_account?" do
      social_media_type == type
    end
  end

  # Define a method for each social media type to find
  # a social media account of the specific type, belonging to the same person
  SocialMediaType.all.each do |type|
    define_method :"find_#{type.name.downcase}_account" do
      person.social_media_accounts.where(social_media_type_id: type.id).first
    end
  end

  private

  def update_federal_legislators
    return unless person.lists.where(name: 'Federal Legislators').first

    if is_twitter_account?
      # use the person's facebook account as an identifier
      update_legislator_by_facebook_account
    elsif is_facebook_account?
      # use the person's twitter account as an identifier
      update_legislator_by_twitter_account
    else
      logger.info "No record for federal legislator with name: #{person.name}, surname: #{person.surname}, account user id: #{user_id}, social media: #{social_media_type.name} was inserted or updated in the legacy table federal_legislators."
    end
  end

  def update_legislator_by_facebook_account
    facebook_id = find_facebook_account.try(:user_id)
    legislator = if facebook_id
                   FederalLegislator
                     .where(first_name: person.name)
                     .where(last_name: person.surname)
                     .where(facebook_id: facebook_id)
                     .last
                 end
    update_or_create_legislator legislator
  end

  def update_legislator_by_twitter_account
    twitter_username = find_twitter_account.try(:user_id)
    legislator = if twitter_username
                   FederalLegislator
                     .where(first_name: person.name)
                     .where(last_name: person.surname)
                     .where(twitter_username: twitter_username)
                     .last
                 end
    update_or_create_legislator legislator
  end

  def update_or_create_legislator(legislator)
    if legislator
      unless legislator.update_from self
        logger.info "Failed to update federal legislator with name: #{person.name}, surname: #{person.surname}, account user id: #{user_id}, social media: #{social_media_type.name}."
      end
    else
      unless build_legislator.save
        logger.info "Failed to create federal legislator with name: #{person.name}, surname: #{person.surname}, account user id: #{user_id}, social media: #{social_media_type.name}."
      end
    end
  end

  def build_legislator
    raise 'Cannot a build a legislator with no account!' unless (is_twitter_account? || is_facebook_account?)

    legislator = FederalLegislator.new
    legislator.first_name = person.name
    legislator.last_name = person.surname
    if is_twitter_account?
      legislator.twitter_username = user_id
    else
      legislator.facebook_id = user_id
    end
    legislator
  end
end
