[![Build Status](https://travis-ci.org/henriquepjv/vagas.svg?branch=master)](https://travis-ci.org/henriquepjv/vagas)
[![Maintainability](https://api.codeclimate.com/v1/badges/52b693cb7719b667b2f3/maintainability)](https://codeclimate.com/github/henriquepjv/vagas/maintainability)

## Desafio Backend Developer

Este é um propósito de uma solução para resolver a tarefa descrita em https://github.com/yubeio/vagas/blob/master/backend/challenge.md

Irei descrever como rodar os testes e mostrar um exemplo de como a solução funciona.

## Testes

Foi utilizado o `Rspec` com o objetivo de inserir cobertura de testes e sendo
necessário apenas executar `bundle install`

```ruby
bundle install

rspec spec/requests/test_name_file.rb

```
E foram testadas as implementações mais críticas com o objetivo de manter o foco
na tarefa principal.

## Explicação

- Ok, vamos a explicação do que foi feito para a criação dessa API. Inicialmente foram criados os models
que irão persistir os dados recebidos no endpoint, sendo criado também os endpoints
para adicionar, editar, excluir e listar os processos e clientes.
- Lembrando que mesmo que o endpoint para excluir um cliente seja utilizado, seus
dados ainda estarão persistidos.
- Para o atributo `status` do ApprovalProcess foi adicionado o enumeration
  ApprovalProcesses::Status garantindo que haja apenas 3 opções (pendente,
aprovado e rejeitado)

## Setup

Para a configuração e execução da aplicação será necessário executar:

```
bundle install

rake db:migrate

rails s

```

## YubeClient

Os clientes possuem os seguintes atributos:

Atributo | Descrição
---------|------------
document_cnpj | Número de seu cnpj
social_name | Razão Social
employees_quantity | Quantidade de funcionários
deleted | Garante que se o cliente for deletado seus dados ainda estarão persistidos

Obs: a quantidade de processos vinculados será retornado através do método
`count_processes` na classe `YubeClient`

## ApprovalProcess

Os processos possuem os seguintes atributos:

Atributo | Descrição
---------|------------
name | Nome do processo
description | Descrição
status | Varia entre `pendente`, `aprovado` e `rejeitado`
yube_client_id | ID do cliente que criou o processo

## Thanks a lot

Acredito que essa documentação auxilia na explicação da minha solução para a tarefa.
Quero agradecer a aportunidade, o desafio da tarefa e espero que tenham gostado
da minha solução =D.

Caso seja necessário uma melhor explicação não hesite em entrar em contato =D.
