require 'rails_helper'

RSpec.describe Fdbq::Feedback, type: :model do
  it { is_expected.to serialize(:fields).as(Hash) }

  describe '#controller_log_if_present' do
    context 'when present and valid' do
      subject { described_class.new(fields: { 'contact_email' => 'test' }, log: 'Feedback extension') }

      it { is_expected.to be_valid }
    end

    context 'when present and invalid' do
      subject { described_class.new(fields: { 'contact_email' => 'test' }, log: 'Feedback') }

      it 'have errors on base' do
        expect(subject).not_to be_valid
        expect(subject.errors[:base]).to include('is invalid')
      end
    end
  end
end
