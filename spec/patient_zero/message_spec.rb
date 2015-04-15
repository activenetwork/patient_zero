require 'spec_helper'

module PatientZero
  describe Message do
    describe '.for_platform' do
      let(:data_hash) { { } }
      context 'when platform is Facebook' do
        let(:platform) { 'FB' }
        it 'news up a Message::Facebook object' do
          expect(Message.for_platform(platform, data_hash)).to be_a Message::Facebook
        end
      end

      context 'when platform is Twitter' do
        let(:platform) { 'TW' }
        it 'news up a Message::Twitter object' do
          expect(Message.for_platform(platform, data_hash)).to be_a Message::Twitter
        end
      end

      context 'when platform is Instagram' do
        let(:platform) { 'IG' }
        it 'news up a Message::Instagram object' do
          expect(Message.for_platform(platform, data_hash)).to be_a Message::Instagram
        end
      end
    end
  end
end
