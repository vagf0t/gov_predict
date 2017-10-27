require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  it { expect(ApplicationRecord.abstract_class).to be true }
end
