require 'rails_helper'

describe Company, type: :model do
  context ':validates' do
    %w[name cnpj employees_number processes_number].each do |attribute|
      it { is_expected.to validate_presence_of(attribute)}
    end
  end

  context ':default_scope' do
    let!(:company_one) { create(:company) }
    let!(:company_two) { create(:company, status: 'deleted')}
    subject { described_class.all }
    it { is_expected.to include(company_one) }
  end
end
