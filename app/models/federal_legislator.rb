class FederalLegislator < ApplicationRecord

  # Attempts to update a legislator, based on a SocialMediaAccount
  # Returns a boolean, as the outcome of the attempt
  def update_from(account)
    return false unless ( account.is_facebook_account? || account.is_twitter_account? )

    self.facebook_id = account.user_id if account.is_facebook_account?
    self.twitter_username = account.user_id if account.is_twitter_account?

    save
  end
end
