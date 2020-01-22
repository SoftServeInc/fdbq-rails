RSpec.describe Fdbq::Rails do
  describe '::controller_parent' do
    context 'old release' do
      before(:each) do
        allow(described_class).to receive(:latest?).and_return(false)
      end

      its(:controller_parent) { is_expected.to eq('ActionController::Base') }
    end

    context 'latest releases' do
      before(:each) do
        allow(described_class).to receive(:latest?).and_return(true)
      end

      its(:controller_parent) { is_expected.to eq('ApplicationController') }
    end
  end

  describe '::model_parent' do
    context 'old release' do
      before(:each) do
        allow(described_class).to receive(:latest?).and_return(false)
      end

      its(:model_parent) { is_expected.to eq('ActiveRecord::Base') }
    end

    context 'latest releases' do
      before(:each) do
        allow(described_class).to receive(:latest?).and_return(true)
      end

      its(:model_parent) { is_expected.to eq('ApplicationRecord') }
    end
  end

  describe '::latest?' do
    context 'rails 4' do
      before(:each) do
        allow(Rails).to receive(:version).and_return('4.3')
      end

      its(:latest?) { is_expected.to be_falsey }
    end

    context 'rails 5' do
      before(:each) do
        allow(Rails).to receive(:version).and_return('5.0')
      end

      its(:latest?) { is_expected.to be_truthy }
    end

    context 'rails 6' do
      before(:each) do
        allow(Rails).to receive(:version).and_return('6.0')
      end

      its(:latest?) { is_expected.to be_truthy }
    end
  end
end
