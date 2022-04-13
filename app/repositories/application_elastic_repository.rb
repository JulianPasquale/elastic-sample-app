class ApplicationElasticRepository
  include Singleton
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  client Elasticsearch::Client.new(
    url: ENV.fetch('ELASTICSEARCH_URL'),
    transport_options: { ssl: { verify: false  }}
  )
end
