require 'rails_helper'

feature 'User add a client' do
  scenario 'successfully' do
    visit root_path

    click_on 'Criar cliente'

    fill_in 'CNPJ', with: '123.456.789-00'
    fill_in 'Razão Social', with: 'Google LTDA'
    fill_in 'Número de Funcionarios', with: 10
    fill_in 'Número de Processos', with: 5

    click_on 'Salvar'

    expect(page).to have_css('li', text: '123.456.789-00')
    expect(page).to have_css('li', text: 'Google LTDA')
    expect(page).to have_css('li', text: '10')
    expect(page).to have_css('li', text: '5')
  end

  scenario 'and has fill all fields' do 
    visit root_path 

    click_on 'Criar cliente'
    fill_in 'CNPJ', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Número de Funcionarios', with: ''
    fill_in 'Número de Processos', with: ''

    click_on 'Salvar'

    expect(page).to have_css('h3', text: 'Você precisa preencher todos os campos')
  end
end
