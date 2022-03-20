class ApplicationElasticRepository
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  client Elasticsearch::Client.new(
    url: ENV.fetch('ELASTICSEARCH_URL'),
    transport_options: { ssl: { verify: false  }}
  )

  def self.default_instance
    @@instance ||= new
  end
end
