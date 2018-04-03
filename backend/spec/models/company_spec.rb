# frozen_string_literal: true

require 'rails_helper'

describe Company, type: :model do
  context ':validates' do
    %w[name cnpj employees_number processes_number].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    it { is_expected.to validate_uniqueness_of('cnpj') }
  end

  context ':default_scope' do
    let(:company_one) { create(:company, cnpj: Faker::CNPJ.unique.numeric) }
    let!(:company_two) { create(:company, status: 'deleted') }
    subject { described_class.all }
    it do
      expect(subject).to include(company_one)
    end
  end

  context ':all_with_deleted' do
    let(:company) { create(:company) }
    let(:company_deleted) do
      create(:company, cnpj: Faker::CNPJ.unique.numeric, status: 'deleted')
    end
    let!(:all_companies) { [company, company_deleted] }

    subject { described_class.all_with_deleted }

    it { is_expected.to eq(all_companies) }
  end
end
