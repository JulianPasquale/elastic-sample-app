desc 'Get benchmarks'

task :benchmarks => :environment do
  search_criteria = 'fixed'
  
  Benchmark.ips do |x|

    x.config(:time => 1, :warmup => 1)

    x.report("Full-text time with tsvector index and #{Post.count} records") do
      Fulltext::Posts::SearchQuery.new(search_criteria, :search_full_text).call
    end
    x.report("Full-text time withouth tsvector and #{Post.count} records") do
      Fulltext::Posts::SearchQuery.new(search_criteria, :non_cached_full_text_search).call
    end
    x.report("Full-text + trigrams time with #{Post.count} records") do
      Fulltext::Posts::SearchQuery.new(search_criteria, :combined_search).call
    end
    x.report("Trigrams time with #{Post.count} records") do
      Fulltext::Posts::SearchQuery.new(search_criteria, :trigrams_search).call
    end
  
    x.report("Elastic time with #{Post.count} records") do
      Elastic::Posts::SearchQuery.new(search_criteria).call
    end
  
    x.compare!
  end
end

