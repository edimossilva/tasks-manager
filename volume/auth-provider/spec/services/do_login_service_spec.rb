require 'rails_helper'

RSpec.describe 'DoLoginService', type: :service do
  describe '#login' do
    let!(:user) { create :user }

    context 'When receive matching username and password' do
      subject do
        DoLoginService.new.call({
          username: user.username,
          password: user.password
        }.to_json)
      end

      it { expect(subject_status_code).to eq(200) }

      it { expect(subject_data[:username]).to eq(user.username) }

      it 'responds with a token related to the user id' do
        payload = decode_token(subject_data[:token])

        expect(payload[:user_id]).to eq(user.id)
      end
    end

    context 'When receive NOT matching username and password' do
      context 'And invalid username and password' do
        subject do
          DoLoginService.new.call({
            username: 'invalid username',
            password: 'invalid password'
          }.to_json)
        end

        it { expect(subject_status_code).to eq(401) }

        it { expect(subject_errors[0][:error_message]).to eq('unauthorized :(') }
      end

      context 'When valid username and invalid password' do
        subject do
          DoLoginService.new.call({
            username: user.username,
            password: 'invalid password'
          }.to_json)
        end

        it { expect(subject_status_code).to eq(401) }

        it { expect(subject_errors[0][:error_message]).to eq('unauthorized :(') }
      end
    end
  end
end
