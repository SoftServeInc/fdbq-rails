RSpec.describe Fdbq do
  subject { described_class }

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
end
