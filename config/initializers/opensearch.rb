require "opensearch-ruby"

OpenSearchClient = OpenSearch::Client.new(
  host: Rails.application.credentials.opensearch[:host],
  log: true
)
