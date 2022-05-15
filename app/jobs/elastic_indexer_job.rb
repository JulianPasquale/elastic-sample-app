class ElasticIndexerJob < ApplicationJob
  queue_as :elasticsearch

  def perform(operation, record)
    Rails.logger.debug [operation, "ID: #{record.id}"]
    
    case operation.to_sym
      when :create
        record.__elasticsearch__.index_document
      when :update
        record.__elasticsearch__.update_document
      when :delete
        begin
          record.__elasticsearch__.delete_document
        rescue Elasticsearch::Transport::Transport::Errors::NotFound
          Rails.logger.debug "#{record.class} not found, ID: #{record.id}"
        end
      else raise ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
