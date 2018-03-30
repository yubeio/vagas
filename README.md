# YUBE VAGA BACK END
Olá, tudo bem com todos? Segue o passo a passo para executar o projeto

## VERSÕES | PRÉ-REQUISITOS
Versões utilizadas:
* Ruby 2.3.1
* Rails 5.1.5
* Mysql

## COMO RODAR
Primeiramente deve-se executar um bundle install caso não tenha as gems instaladas. (Também)

### INSTALAÇÃO
Após instalar todas as gems o projeto ja deverá estar pronto para rodar, foram criados diversos endpoints para serem consumidos pela API e também os testes unitários dos mesmos.

O Banco de dados de testes é automaticamente populado e também apagado em cada execução dos testes.

Primeiramente precisamos criar os bancos de dados, para isso rode:
```
rails db:create
```
Após a criação do banco de dados de desenvolvimento e de testes iremos criar um conteúdo para o de desenvolvimento apenas para ter alguma informação
```
rails db:seed
```
Com os bancos de dados criados e funcionais ja podemos rodar os testes
```
bundle exec rspec
```

Após a verificação dos testes podemos ver que a API está funcional e ja pode ser consumida, para simular um ambiente de desenvolvimento você pode iniciar o servidor
```
rails s
```
e após isso utilizar algum cliente http para testar as requisições (recomendo usar o postman).

Eu inicie também o desenvolvimento do deploy utilizando o capistrano mas ainda está para finalizar, então vou adicionar como um TODO :)
