require 'rails_helper'

RSpec.describe List, type: :model do
  it { should have_and_belong_to_many(:people) }
end
