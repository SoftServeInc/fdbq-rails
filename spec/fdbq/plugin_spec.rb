RSpec.describe Fdbq::Plugin do
  subject { Fdbq::Plugin.instance }

  describe '#reset!' do
    before(:each) do
      subject.param_key = :object
      subject.config_file_path = 'non-existing'
      subject.reset!
    end

    its(:param_key) { is_expected.to eq(Fdbq::Plugin::DEFAULT_PARAM_KEY) }
    its(:config_file_path) { is_expected.to be_nil }
  end

  context 'unconfigured' do
    before(:each) do
      subject.reset!
    end
  
    its(:config_file_path) { is_expected.to be_nil }
    its(:param_key) { is_expected.to eq(:feedback) }

    describe '#questions' do
      it 'raises an error' do
        expect { subject.questions }.to raise_error(TypeError)
      end
    end

    describe '#settings' do
      it 'raises and error' do
        expect { subject.settings }.to raise_error(TypeError)
      end
    end

    describe '#config' do
      it 'raises an error' do
        expect { subject.config }.to raise_error(TypeError)
      end
    end

    describe '#build_param_key' do
      it 'returns correct param key' do
        expect(subject.build_param_key('usage')).to eq('feedback[usage]')
      end
    end
  end

  context 'configured' do
    let(:config_path) { File.expand_path('../../support/fixtures/fdbq.yml', __FILE__) }

    before(:each) do
      subject.config_file_path = config_path
      subject.param_key = :questionarie
    end

    after(:each) do
      subject.reset!
    end

    its(:config_file_path) { is_expected.to eq(config_path) }
    its(:param_key) { is_expected.to eq(:questionarie) }
    its(:questions) { is_expected.to be_an(Array) }
    its(:settings) { is_expected.to be_a(Hash) }
    its(:config) { is_expected.to be_a(Hash) }

    context 'settings' do
      it 'returns config with list of questions with configured names' do
        config = subject.config

        expect(subject.settings['questions']).not_to be_empty

        subject.settings['questions'].each.with_index do |question, index|
          q = config['questions'][index]

          expect(question['name']).to eq("questionarie[#{q['name']}]")
          expect(question['label']).to eq(q['label'])
          expect(question['hint']).to eq(q['hint'])
          expect(question['placeholder']).to eq(q['placeholder'])
          expect(question['value']).to eq(q['value'])
          expect(question['type']).to eq(q['type'])
          expect(question['required']).to eq(q['required'])
        end 
      end
    end

    describe '#build_param_key' do
      it 'returns correct param key' do
        expect(subject.build_param_key('usage')).to eq('questionarie[usage]')
      end
    end
  end
end
