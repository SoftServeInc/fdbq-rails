require 'rails_helper'

RSpec.describe Fdbq::PluginHelper, type: :helper do
  describe '#fdbq_render' do
    let(:settings) { Fdbq.current_instance }

    subject { helper.fdbq_render }

    it 'generates script with data' do
      expect(subject).to include('(new Fdbq({"placement":')
      expect(subject).to include(settings['placement'])
      expect(subject).to include(settings.dig('modal', 'title'))
      expect(subject).to include(settings.dig('subHeader', 'title'))
      expect(subject).to include(settings.dig('subHeader', 'description'))

      settings['questions'].each do |question|
        expect(subject).to include("\"#{question['name']}\"")
        expect(subject).to include("\"#{question['label']}\"")
        expect(subject).to include("\"#{question['type']}\"")
        expect(subject).to include("#{question['required']}")
        expect(subject).to include("\"#{question['hint']}\"")
      end
    end
  end

  describe '#fdbq_responses' do
    let(:fields) { [{fields: { 'contact_email' => 'test1@mail.com'} }, { fields: { 'contact_email' => 'test2@mail.com' } }] }
    let(:list) { fields.map(&Fdbq::Feedback.method(:create!)) }

    subject { helper.fdbq_responses }

    it { is_expected.to contain_exactly(*list) }
    its(:klass) { is_expected.to eq(Fdbq::Feedback) }
  end
end
