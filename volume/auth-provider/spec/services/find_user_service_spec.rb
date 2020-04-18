require 'rails_helper'

RSpec.describe 'FindUserService', type: :service do
  let!(:user) { create :user }

  context 'When receive valid token' do
    subject do
      FindUserService.new.call({
        token: encode_user(user)
      }.to_json)
    end

    it { expect(subject_status_code).to eq(200) }

    it { expect(subject_data[:username]).to eq(user.username) }

    it { expect(subject_data[:userId]).to eq(user.id) }
  end

  context 'When receive invalid token' do
    subject do
      FindUserService.new.call({
        token: 'invalid token'
      }.to_json)
    end

    it { expect(subject_status_code).to eq(401) }

    it { expect(subject_errors[0][:error_message]).to eq('unauthorized :(') }
  end
end
