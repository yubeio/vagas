require 'rails_helper'

RSpec.describe Client, type: :model do
  # Validação de campos not nil
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:razao_social) }
  it { should validate_presence_of(:total_employee) }
  it { should validate_presence_of(:total_process) }
end
