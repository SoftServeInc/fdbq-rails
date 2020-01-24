require 'rails_helper'

RSpec.describe Fdbq::Feedback, type: :model do
  it { is_expected.to serialize(:fields).as(Hash) }
end
