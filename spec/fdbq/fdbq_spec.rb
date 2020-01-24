RSpec.describe Fdbq do
  subject { described_class }

  before(:each) do
    Fdbq.configure do |c|
      c.config_file_path = File.expand_path('../../support/fixtures/fdbq.yml', __FILE__)
    end
  end

  it { is_expected.to be_a_kind_of(Module) }

  describe '::param_key' do
    it 'calls to a plugin instance' do
      expect(Fdbq::Plugin.instance).to receive(:param_key).and_call_original

      subject.param_key
    end
  end

  describe '::questions' do
    it 'calls to a plugin instance' do
      expect(Fdbq::Plugin.instance).to receive(:questions).and_call_original

      subject.questions
    end
  end

  describe '::configure' do
    it 'calls to a plugin instance' do
      expect(Fdbq::Plugin.instance).to receive(:instance_eval).and_call_original

      subject.configure do
        # dummy
      end
    end
  end

  describe '::current_instance' do
    subject { Fdbq.current_instance }

    it 'returns instance config with re-configured questions names' do
      config = Fdbq::Plugin.instance.config

      expect(config['placement']).to eq(subject['placement'])
      expect(config.dig('modal', 'title')).to eq(subject.dig('modal', 'title'))
      expect(config.dig('subHeader', 'title')).to eq(subject.dig('subHeader', 'title'))
      expect(config.dig('subHeader', 'description')).to eq(subject.dig('subHeader', 'description'))
      
      subject['questions'].each.with_index do |question, i|
        expect(question['name']).to eq("feedback[#{config['questions'][i]['name']}]")
      end
    end
  end
end
