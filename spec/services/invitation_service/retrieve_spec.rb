# spec/services/invitation_service/retrieve_spec.rb
require 'rails_helper'

RSpec.describe InvitationService::Retrieve do
  let(:params) { { search: 'test-query', guest_source: 'groom', attendance_type: Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony]} }

  subject { InvitationService.retrieve(params) }

  describe '#perform' do
    let(:mock_relation) { instance_double(ActiveRecord::Relation) }

    context 'when params[:search] is exist' do
      before do
        params[:guest_source] = nil
        params[:attendance_type] = -1

        allow(Invitation).to receive(:joins).with(:invitation_guests).and_return(mock_relation)
        allow(mock_relation).to receive(:joins).with("INNER JOIN guests ON guests.id = invitation_guests.guest_id").and_return(mock_relation)

        allow(mock_relation).to receive(:where).with("guests.name ILIKE ?", "%test-query%").and_return(mock_relation)

        allow(mock_relation).to receive(:uniq).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when params[:attendance_type] is exist' do
      before do
        params[:search] = ''
        params[:guest_source] = nil

        allow(Invitation).to receive(:joins).with(:invitation_guests).and_return(mock_relation)
        allow(mock_relation).to receive(:joins).with("INNER JOIN guests ON guests.id = invitation_guests.guest_id").and_return(mock_relation)
      end

      context 'and it is holy_matrimony' do
        before do
          params[:attendance_type] = Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony]
          allow(mock_relation).to receive(:where).with("attendance_type IN (?)", [0, 2]).and_return(mock_relation)

          allow(mock_relation).to receive(:uniq).and_return(mock_relation)
        end

        it 'should return no error and success retrieve' do
          subject

          expect { subject }.to_not raise_error
        end
      end

      context 'and it is reception' do
        before do
          params[:attendance_type] = Invitation::ATTENDANCE_TYPE_ENUM[:reception]
          allow(mock_relation).to receive(:where).with("attendance_type IN (?)", [1, 2]).and_return(mock_relation)

          allow(mock_relation).to receive(:uniq).and_return(mock_relation)
        end

        it 'should return no error and success retrieve' do
          subject

          expect { subject }.to_not raise_error
        end
      end

      context 'and it is both' do
        before do
          params[:attendance_type] = Invitation::ATTENDANCE_TYPE_ENUM[:both]
          allow(mock_relation).to receive(:where).with("attendance_type IN (?)", [2]).and_return(mock_relation)

          allow(mock_relation).to receive(:uniq).and_return(mock_relation)
        end

        it 'should return no error and success retrieve' do
          subject

          expect { subject }.to_not raise_error
        end
      end
    end

    context 'when params[:search] & params[:guest_source] is exist' do
      before do
        params[:attendance_type] = -1

        allow(Invitation).to receive(:joins).with(:invitation_guests).and_return(mock_relation)
        allow(mock_relation).to receive(:joins).with("INNER JOIN guests ON guests.id = invitation_guests.guest_id").and_return(mock_relation)

        allow(mock_relation).to receive(:where).with("guests.name ILIKE ?", "%test-query%").and_return(mock_relation)
        allow(mock_relation).to receive(:where).with("guests.from_groom = ?", true).and_return(mock_relation)

        allow(mock_relation).to receive(:uniq).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when all params is exist' do
      before do
        allow(Invitation).to receive(:joins).with(:invitation_guests).and_return(mock_relation)
        allow(mock_relation).to receive(:joins).with("INNER JOIN guests ON guests.id = invitation_guests.guest_id").and_return(mock_relation)

        allow(mock_relation).to receive(:where).with("guests.name ILIKE ?", "%test-query%").and_return(mock_relation)
        allow(mock_relation).to receive(:where).with("guests.from_groom = ?", true).and_return(mock_relation)
        allow(mock_relation).to receive(:where).with("attendance_type IN (?)", [0, 2]).and_return(mock_relation)

        allow(mock_relation).to receive(:uniq).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when all params is not exist' do
      let(:params)  { { search: '' } }

      before do
        allow(Invitation).to receive(:all).and_return(mock_relation)

        allow(mock_relation).to receive(:uniq).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      let(:params)  { { search: '' } }

      before do
        allow(Invitation).to receive(:all).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
    context 'raise errors on params' do
      context 'when params is nil' do
        let(:params) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::MissingAttributes
        end
      end

      context 'when params[:search] is not a string' do
        let(:params) { { search: true } }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::InvalidServiceParameter
        end
      end
    end
  end
end
