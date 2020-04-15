require 'rails_helper'

RSpec.describe 'BaseServer', type: :rpc_server do
  let!(:base_server) { BaseServer.new }
  describe '#validate_payload' do
    let!(:valid_payload) { { username: 'valid_name' }.to_json }
    let!(:not_string_payload) { Faker::Number.number(digits: 3) }

    context 'when payload is valid' do
      it {
        expect(base_server.validate_payload!(valid_payload)).to be(true)
      }
    end

    context 'when payload is NOT valid' do
      it {
        expect do
          base_server.validate_payload!(nil)
        end.to raise_error(StandardError)
      }

      it {
        expect do
          base_server.validate_payload!('')
        end.to raise_error(StandardError)
      }

      it 'is expected to raise StandardError when value is not String' do
        expect do
          base_server.validate_payload!(not_string_payload)
        end.to raise_error(StandardError)
      end
    end

    describe '#validate_headers' do
      let!(:valid_header) { { status_code: 200 } }
      let!(:no_status_code_payload) { { value: Faker::Number.number(digits: 3) } }

      context 'when header is valid' do
        it {
          expect(base_server.validate_headers!(valid_header)).to be(true)
        }
      end

      context 'when header is NOT valid' do
        it {
          expect do
            base_server.validate_headers!(nil)
          end.to raise_error(StandardError)
        }

        it {
          expect do
            base_server.validate_headers!('')
          end.to raise_error(StandardError)
        }

        it 'is expected to raise StandardError when has not key status_code' do
          expect do
            base_server.validate_headers!(no_status_code_payload)
          end.to raise_error(StandardError)
        end
      end
    end
  end
end
