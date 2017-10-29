require 'rails_helper'

RSpec.describe FederalLegislator, type: :model do

  let(:face_book_type) { SocialMediaType.find_by_name('Facebook') }
  let(:twitter_type) { SocialMediaType.find_by_name('Twitter') }

  context 'on legislator create' do

    context 'non existent person' do

      before do
        subject.first_name = 'Indiana'
        subject.last_name = 'Jones'
        subject.facebook_id = 'Indy'
        subject.twitter_username = 'Ford'
      end

      it 'triggers the creation of a person and his social media accounts' do
        expect do
          subject.save!
        end.to change { Person.count }.by 1
        indiana = Person.last
        expect(indiana.name).to eq 'Indiana'
        expect(indiana.surname).to eq 'Jones'
        expect(indiana.social_media_accounts.size).to eq 2
        expect(indiana.social_media_accounts
                      .where(social_media_type_id: face_book_type.id).count)
                      .to eq 1
        indianas_facebook_account = indiana.social_media_accounts
                                           .where(social_media_type_id: face_book_type.id)
                                           .first
        expect(indianas_facebook_account.user_id).to eq 'Indy'
        expect(indiana.social_media_accounts
                      .where(social_media_type_id: twitter_type.id).count)
                      .to eq 1
        indianas_twitter_account = indiana.social_media_accounts
                                          .where(social_media_type_id: twitter_type.id)
                                          .first
        expect(indianas_twitter_account.user_id).to eq 'Ford'
      end
    end

    context 'existent person' do

      before do
        subject.first_name = 'Darth'
        subject.last_name = 'Vader'
        subject.facebook_id = 'Dark Daddy'
        subject.twitter_username = 'Vader Twitter'
      end

      it 'does not trigger creation of any person and updates social media accounts' do
        expect do
          subject.save!
        end.not_to change { Person.count }
        darth = Person.find_by_name 'Darth'
        expect(darth.social_media_accounts
                    .where(social_media_type_id: face_book_type.id).count)
                    .to eq 1
        darths_facebook_account = darth.social_media_accounts
                                        .where(social_media_type_id: face_book_type.id)
                                        .first
        expect(darths_facebook_account.user_id).to eq 'Dark Daddy'
        expect(darth.social_media_accounts
                    .where(social_media_type_id: twitter_type.id).count)
                    .to eq 1
        darths_twitter_account = darth.social_media_accounts
                                      .where(social_media_type_id: twitter_type.id)
                                      .first
        expect(darths_twitter_account.user_id).to eq 'Vader Twitter'
      end

    end
  end

  context 'on legislator update' do

    before do
      subject.first_name = 'Indiana'
      subject.last_name = 'Jones'
      subject.facebook_id = 'Indy'
      subject.twitter_username = 'Ford'
      subject.save!
    end

    it 'does not trigger creation of any person and updates social media accounts' do
      expect do
        subject.first_name = 'Indiana'
        subject.last_name = 'Jones'
        subject.facebook_id = 'Harison'
        subject.twitter_username = 'Ford'
        subject.save!
      end.not_to change { Person.count }
      indiana = Person.last
      expect(indiana.name).to eq 'Indiana'
      expect(indiana.surname).to eq 'Jones'
      expect(indiana.social_media_accounts.size).to eq 2
      expect(indiana.social_media_accounts
                 .where(social_media_type_id: face_book_type.id).count)
          .to eq 1
      indianas_facebook_account = indiana.social_media_accounts
                                      .where(social_media_type_id: face_book_type.id)
                                      .first
      expect(indianas_facebook_account.user_id).to eq 'Harison'
      expect(indiana.social_media_accounts
                 .where(social_media_type_id: twitter_type.id).count)
          .to eq 1
      indianas_twitter_account = indiana.social_media_accounts
                                     .where(social_media_type_id: twitter_type.id)
                                     .first
      expect(indianas_twitter_account.user_id).to eq 'Ford'
    end

  end

  context 'on legislator delete' do

    before do
      subject.first_name = 'Indiana'
      subject.last_name = 'Jones'
      subject.facebook_id = 'Indy'
      subject.twitter_username = 'Ford'
      subject.save!
    end

    it 'does not delete any person and deletes the social media account' do
      indiana = Person.find_by_name 'Indiana'
      expect(indiana.social_media_accounts.size).to eq 2
      expect do
        subject.destroy!
      end.not_to change { Person.count }
      expect(indiana.name).to eq 'Indiana'
      expect(indiana.surname).to eq 'Jones'
      expect(indiana.social_media_accounts.size).to eq 0
    end

  end

  describe '#update_from' do

    context 'neither facebook or twitter account' do
      it 'returns false' do
        account = Person.find_by_name('Darth')
                      .social_media_accounts
                      .where(social_media_type_id: SocialMediaType.find_by_name('Instagram').id)
                      .first
        # If the following expectation fails, run the seeds
        expect(account).to be_present
        expect(subject.update_from account).to be false
      end
    end

    context 'facebook account' do
      it 'updates the legislator' do
        account = Person.find_by_name('Darth')
                      .social_media_accounts
                      .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                      .first
        # If the following expectation fails, run the seeds
        expect(account).to be_present
        expect(subject.update_from(account)).to be true
        expect(subject.facebook_id).to eq 'Vader Facebook'
      end
    end

    context 'twitter account' do
      it 'updates the legislator' do
        account = Person.find_by_name('Darth')
                      .social_media_accounts
                      .where(social_media_type_id: SocialMediaType.find_by_name('Twitter').id)
                      .first
        # If the following expectation fails, run the seeds
        expect(account).to be_present
        expect(subject.update_from account).to be true
        expect(subject.twitter_username).to eq 'Vader Twitter'
      end
    end

  end
end
