require 'rails_helper'

RSpec.describe ClientProcess, type: :model do
  it { should belong_to(:client) }

  # Validação de Enum
  it { should define_enum_for(:process_status) }
end
