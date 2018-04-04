describe CompaniesController do
  let!(:company_one) { create(:company, cnpj: Faker::CNPJ.unique.numeric) }
  let!(:company_two) { create(:company, cnpj: Faker::CNPJ.unique.numeric) }
  let!(:company_three) { create(:company, cnpj: Faker::CNPJ.unique.numeric, status: 'deleted') }

  context 'GET #index' do
    let(:json_result) { Company.all.to_json }

    it 'return all active companies' do
      get :index
      expect(response.body).to include json_result
      expect(response.status).to be 200
    end
  end

  context 'GET #index_with_deleted' do
    let(:json_result) { Company.unscoped.to_json }

    it 'return all companies' do
      get :index_with_deleted
      expect(response.body).to include json_result
      expect(response.status).to be 200
    end
  end

  context 'GET #show' do
    let(:json_result) { company_one.to_json }

    it 'return one active companie' do
      get :show, params: { id: 1 }
      expect(response.body).to include json_result
      expect(response.status).to be 200
    end
  end

  context 'POST #create' do
    let(:company_attr) { attributes_for(:company, cnpj: Faker::CNPJ.unique.numeric) }
    let(:success_message) { 'Register created with success!' }

    it 'with success' do
      post :create, params: { company: company_attr }
      expect(response.body).to include success_message
      expect(response.status).to be 200
    end

    let(:failure_message) { 'param is missing or the value is empty: company' }

    it 'with failure' do
      post :create, params: company_attr
      expect(response.body).to include failure_message
    end
  end

  context 'POST #update' do
    let(:company_attr) { attributes_for(:company) }
    let(:success_message) { '"Register updated with success!' }

    it 'with success' do
      post :update, params: { id: 1, company: company_attr }
      expect(response.body).to include success_message
      expect(response.status).to be 200
    end

    let(:invalid_company_attr) do
      {:name=>"Lockman Group", :cpj=>"36369340448515", :employees_quantity=>112}
    end
    let(:failure_message) { 'found unpermitted parameter: :cpj' }

    it 'with failure' do
      patch :update, params: { id: 1, company: invalid_company_attr }
      expect(response.body).to include failure_message
    end
  end

  context 'POST #destroy' do
    let(:success_message) { 'Register deleted with success!' }
    subject { Company.unscoped.first }

    it 'with success' do
      delete :destroy, params: { id: 1 }
      expect(response.body).to include success_message
      expect(response.status).to be 200
      expect(subject.reload.status).to eq 'deleted'
    end
  end
end
