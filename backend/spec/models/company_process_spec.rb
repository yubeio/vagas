require 'rails_helper'

describe CompanyProcess, type: :model do
  context ':validates' do
    %w[name description].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end

  context '#update_status' do
    let!(:company_process) { create(:company_process) }

    context 'status is valid' do
      let(:status) { "accepted" }
      let(:company) { create(:company, cnpj: Faker::CNPJ.unique.numeric) }
      subject do
        create(:company_process, company: company).tap do |cp|
          cp.update_status(status)
        end.reload
      end

      it 'update it' do
        subject.tap { |cp| cp.update_status(status) }.reload
        expect(subject.status).to eq 'accepted'
      end

      after do
        Company.unscoped.each(&:destroy)
        CompanyProcess.all.each(&:destroy)
      end
    end
  end
end
