Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:8000", "https://arantxa1942.github.io"

    
    resource "/api/v1/services*", headers: %w[Accept], methods: %i[get options]
  end
end