require 'rails_helper'

feature 'User create a proccess' do
  scenario 'successfully' do
    Client.create(cnpj: '123.456.789-00', razao_social: 'alura ltda', n_funcionarios: 10)

    visit root_path 
    click_on '123.456.789-00'
    click_on 'Novo processo'

    fill_in 'Nome', with: 'Victor'
    fill_in 'Descrição', with: 'aqui está a descrição.'
    
    click_on 'Salvar'

    expect(page).to have_css('h3', text: 'Processo cadastrado com sucesso')
    expect(page).to have_css('li', text: 'Victor')
    expect(page).to have_css('li', text: 'aqui está a descrição')
    
  end

  scenario 'and have fill all fields' do 
    Client.create(cnpj: '123.456.789-00', razao_social: 'alura ltda', n_funcionarios: 10) 
    visit root_path

    click_on '123.456.789-00'
    click_on 'Novo processo'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''

    click_on 'Salvar'

    expect(page).to have_css('h3', text: 'Você precisa preencher todos os campos')
  end
end
