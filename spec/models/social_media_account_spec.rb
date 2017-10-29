require 'rails_helper'

RSpec.describe SocialMediaAccount, type: :model do
  it { should have_many(:posts) }
  it { should belong_to(:person) }
  it { should belong_to(:social_media_type) }

  it 'responds to dynamic methods' do
    SocialMediaType.all.each do |type|
      expect(subject).to respond_to("is_#{type.name.downcase}_account?".to_sym)
      expect(subject).to respond_to("find_#{type.name.downcase}_account".to_sym)
    end
  end

  describe '#update_federal_legislators' do
    it 'should be triggered upon save' do
      account = Person.find_by_name('Darth')
                    .social_media_accounts
                    .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                    .first
      expect(account).to receive(:update_federal_legislators)
      account.save!
    end

    context 'not a federal legislator' do
      it 'should do nothing' do
        account = Person.find_by_name('Darth')
                        .social_media_accounts
                        .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                        .first
        # If the following expectation fails, run the seeds
        expect(account).to be_present
        expect(account).not_to receive(:is_twitter_account?)
        account.save!
      end
    end

    context 'federal legislator' do
      context 'Twitter account' do
        it 'should use facebook account to update legislator' do
          account = Person.find_by_surname('Amidala')
                          .social_media_accounts
                          .where(social_media_type_id: SocialMediaType.find_by_name('Twitter').id)
                          .first
          # If the following expectation fails, run the seeds
          expect(account).to be_present
          expect(account).to receive(:update_legislator_by_facebook_account)
          account.save!
        end
      end

      context 'facebook account' do
        it 'should use twitter account to update legislator' do
          account = Person.find_by_surname('Amidala')
                          .social_media_accounts
                          .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                          .first
          # If the following expectation fails, run the seeds
          expect(account).to be_present
          expect(account).to receive(:update_legislator_by_twitter_account)
          account.save!
        end
      end

      context 'neither a facebook or a twitter account' do
        it 'should do nothing and log' do
          account = Person.find_by_surname('Amidala')
                          .social_media_accounts
                          .where(social_media_type_id: SocialMediaType.find_by_name('Pinterest').id)
                          .first
          # If the following expectation fails, run the seeds
          expect(account).to be_present
          expect(Rails.logger).to receive(:info).with('No record for federal legislator with name: Princess, surname: Amidala, account user id: Princess Pinterest, social media: Pinterest was inserted or updated in the legacy table federal_legislators.')
          account.save!
        end
      end

      describe '#update_legislator_by_facebook_account' do
        it 'will attempt to update or create legislator' do
          allow(subject).to receive(:person).and_return Person.find_by_name 'Darth'
          expect(subject).to receive(:update_or_create_legislator)
          subject.send(:update_legislator_by_facebook_account)
        end
      end

      describe '#update_legislator_by_twitter_account' do
        it 'will attempt to update or create legislator' do
          allow(subject).to receive(:person).and_return Person.find_by_name 'Darth'
          expect(subject).to receive(:update_or_create_legislator)
          subject.send(:update_legislator_by_twitter_account)
        end
      end

      describe '#update_or_create_legislator' do
        context 'Existent legislator' do
          let(:legislator) { double('legislator') }

          it 'should attempt to update legislator' do
            expect(legislator).to receive(:update_from).with(subject).and_return true
            subject.send(:update_or_create_legislator, legislator)
          end

          it 'should log if it failed to update' do
            account = Person.find_by_name('Darth')
                          .social_media_accounts
                          .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                          .first
            # If the following expectation fails, run the seeds
            expect(account).to be_present
            expect(legislator).to receive(:update_from).with(account).and_return false
            expect(Rails.logger).to receive(:info).with('Failed to update federal legislator with name: Darth, surname: Vader, account user id: Vader Facebook, social media: Facebook.')
            account.send(:update_or_create_legislator, legislator)
          end
        end

        context 'New legislator' do
          it 'should attempt to create a legislator' do
            account = Person.find_by_name('Darth')
                          .social_media_accounts
                          .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                          .first
            # If the following expectation fails, run the seeds
            expect(account).to be_present
            expect(account).to receive(:build_legislator).and_call_original
            expect_any_instance_of(FederalLegislator).to receive(:save)
            account.send(:update_or_create_legislator, nil)
          end

          it 'should log if it fails to create a legislator' do
            account = Person.find_by_name('Darth')
                          .social_media_accounts
                          .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                          .first
            # If the following expectation fails, run the seeds
            expect(account).to be_present
            expect(account).to receive(:build_legislator).and_call_original
            expect_any_instance_of(FederalLegislator).to receive(:save).and_return false
            expect(Rails.logger).to receive(:info).with('Failed to create federal legislator with name: Darth, surname: Vader, account user id: Vader Facebook, social media: Facebook.')
            account.send(:update_or_create_legislator, nil)
          end
        end
      end

      describe '#build_legislator' do
        it 'returns a federal legislator with a facebook id' do
          account = Person.find_by_name('Darth')
                        .social_media_accounts
                        .where(social_media_type_id: SocialMediaType.find_by_name('Facebook').id)
                        .first
          # If the following expectation fails, run the seeds
          expect(account).to be_present
          legislator = account.send(:build_legislator)
          expect(legislator).to be_a FederalLegislator
          expect(legislator.facebook_id).to eq 'Vader Facebook'
          expect(legislator.first_name).to eq 'Darth'
          expect(legislator.last_name).to eq 'Vader'
        end

        it 'returns a federal legislator with a twitter username' do
          account = Person.find_by_name('Darth')
                        .social_media_accounts
                        .where(social_media_type_id: SocialMediaType.find_by_name('Twitter').id)
                        .first
          # If the following expectation fails, run the seeds
          expect(account).to be_present
          legislator = account.send(:build_legislator)
          expect(legislator).to be_a FederalLegislator
          expect(legislator.twitter_username).to eq 'Vader Twitter'
          expect(legislator.first_name).to eq 'Darth'
          expect(legislator.last_name).to eq 'Vader'
        end

        it 'raises an exception if neither twitter or facebook account' do
          account = Person.find_by_name('Darth')
                        .social_media_accounts
                        .where(social_media_type_id: SocialMediaType.find_by_name('Instagram').id)
                        .first
          # If the following expectation fails, run the seeds
          expect(account).to be_present
          expect{ account.send(:build_legislator) }.to raise_error 'Cannot a build a legislator with no account!'
        end
      end
    end
  end
end
