# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
  client = Client.create([
    {
      cnpj: '60.998.878/0001-90',
      razao_social: 'Cliente teste',
      total_employee: 20,
      total_process: 1
    }
  ])

  clientProcess = ClientProcess.create([
    {
      name: 'Processo 1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      process_status: 1,
    }
  ])
