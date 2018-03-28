class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  throttle('req/ip', limit: 2, period: 3) do |req|
    req.ip
  end

  throttle('authenticate/username', limit: 5, period: 60.seconds) do |req|
    if req.path == '/authenticate' && req.post?
      req.params['username'].presence
    end
  end
end
