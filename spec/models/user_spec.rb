# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#confirm!' do
    let(:subject) { build_stubbed(:user) }

    before do
      allow(subject).to receive(:save!)
    end

    it 'should not raise any error' do
      expect { subject.confirm! }.to_not raise_error
    end
  end

  describe '#confirmed?' do
    let(:subject) { build_stubbed(:user, :confirmed) }

    context 'when user is confirmed' do
      let(:subject) { build_stubbed(:user, :confirmed) }

      it 'should return true' do
        expect(subject.confirmed?).to be_truthy
      end
    end

    context 'when user is not yet confirmed' do
      let(:subject) { build_stubbed(:user) }

      it 'should return false' do
        expect(subject.confirmed?).to be_falsey
      end
    end
  end

end