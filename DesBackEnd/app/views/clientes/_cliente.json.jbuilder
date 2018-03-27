json.extract! cliente, :id, :cnpj, :razao_social, :num_funcionarios, :processo_id, :status, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
