require 'rails_helper'

describe CompanyProcess, type: :model do
  context ':validates' do
    %w[name description].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end

  context '#update_status' do
    subject do
      create(:company_process).tap do |cp|
        cp.update_status(status)
      end.reload
    end

    context 'valid status' do
      let(:status) { "accepted" }

      it 'update it' do
        expect(subject.status).to eq 'accepted'
      end
    end

    context 'invalid status' do
      let(:status) { "invalid" }
      let(:error_message) { "Status can't be updated!" }
      it 'return a error message' do
        expect(subject.errors.full_messages).to include(error_message)
      end
    end
  end
end
