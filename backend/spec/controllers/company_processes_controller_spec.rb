describe CompanyProcessesController do
  let(:company_one) { create(:company, cnpj: Faker::CNPJ.unique.numeric) }
  let(:company_two) { create(:company, cnpj: Faker::CNPJ.unique.numeric) }
  let!(:process_one) { create(:company_process, company: company_one) }
  let!(:process_two) { create(:company_process, company: company_one)}
  let!(:process_three) { create(:company_process, company: company_two)}
  let!(:process_four) { create(:company_process, company: company_one)}

  context 'GET #index' do
    let(:json_response) { Company.first.company_processes.to_json }

    it 'return all company processes' do
      get :index, params: { company_id: 1 }
      expect(response.body).to include json_response
      expect(response.status).to be 200
    end
  end

  context 'GET #show' do

    it 'return one process' do
      get :show, params: { id: 3 }
      expect(response.body).to include process_three.to_json
    end
  end

  context 'POST #create' do
    let(:valid_process_attr) do
      attributes_for(:company_process).tap{ |cp| cp.delete(:status) }
    end
    let(:success_message) { 'Process created with success!' }
    let(:processes) { Company.second.company_processes }

    it 'with success' do
      post :create, params: { company_id: 2, company_process: valid_process_attr }
      expect(response.body).to include success_message
      expect(response.status).to be 200
      expect(processes.count).to be 2
    end

    let(:invalid_process_attr) { attributes_for(:company_process) }
    let(:failure_message) { 'found unpermitted parameter: :status' }

    it 'with failure' do
      post :create, params: { company_id: 2, company_process: invalid_process_attr }
      expect(response.body).to include failure_message
    end
  end

  context 'PUT #update' do
    let(:valid_process_attr) do
      attributes_for(:company_process).tap { |cp| cp.delete(:status) }
    end
    let(:success_message) { 'Process updated with success!' }

    it 'with success' do
      put :update, params: { id: 1, company_process: valid_process_attr }
      expect(response.body).to include success_message
      expect(response.status).to be 200
    end

    let(:invalid_process_attr) { attributes_for(:company_process) }
    let(:failure_message) { 'found unpermitted parameter: :status' }

    it 'with failure' do
      put :update, params: { id: 1, company_process: invalid_process_attr }
      expect(response.body).to include failure_message
    end
  end

  context 'PUT #update_status' do
    let(:valid_status) { { status: 'accepted' } }
    let(:success_message) { 'Status was updated with success!' }

    it 'with success' do
      put :update_status, params: { id: 1, company_process: valid_status }
      expect(response.body).to include success_message
      expect(response.status).to be 200
      expect(CompanyProcess.first.accepted?).to be true
    end

    let(:invalid_status) { { status: 'invalid' } }
    let(:failure_message) { "Status can't be updated!" }
    let!(:old_status) { CompanyProcess.first.status }

    it 'with failure' do
      put :update_status, params: { id: 1, company_process: invalid_status }
      expect(response.body).to include failure_message
      expect(CompanyProcess.first.status).to be old_status
    end
  end

  context 'POST #destroy' do
    let(:success_message) { 'Process deleted with success!' }

    it 'with success' do
    delete :destroy, params: { id: 1 }
    expect(response.body).to include success_message
    expect(response.status).to be 200
    end

    let(:failure_message) { 'Register not found in our database' }

    it 'with failure' do
      delete :destroy, params: { id: 10 }
      expect(response.body).to include failure_message
    end
  end
end
