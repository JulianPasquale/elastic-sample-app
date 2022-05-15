Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV.fetch('ELASTICSEARCH_URL'),
  log: true,
  transport_options: { ssl: { verify: false  }}
)
