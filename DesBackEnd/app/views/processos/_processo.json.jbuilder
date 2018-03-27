json.extract! processo, :id, :nome, :descricao, :situacao, :status, :created_at, :updated_at
json.url processo_url(processo, format: :json)
