require 'rails_helper'

feature 'User add a client' do
  scenario 'successfully' do
    visit root_path

    click_on 'Criar cliente'

    fill_in 'CNPJ', with: '123.456.789-00'
    fill_in 'Razão Social', with: 'Google LTDA'
    fill_in 'Número de Funcionarios', with: 10

    click_on 'Salvar'

    expect(page).to have_content('123.456.789-00')
    expect(page).to have_content('Google LTDA')
    expect(page).to have_content('10')
    expect(page).to have_content('0')
  end

  scenario 'and has fill all fields' do 
    visit root_path 

    click_on 'Criar cliente'
    fill_in 'CNPJ', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Número de Funcionarios', with: ''

    click_on 'Salvar'

    expect(page).to have_css('h3', text: 'Você precisa preencher todos os campos')
  end

  scenario 'delete a client' do 
    Client.create(cnpj: '123.456.789-00', razao_social: 'alura ltda', n_funcionarios: 10)
    visit root_path

    click_on 'Excluir'

    expect(page).to have_content('Cliente excluido')
  end
end
