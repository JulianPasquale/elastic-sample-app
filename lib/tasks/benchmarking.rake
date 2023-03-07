desc 'Get benchmarks'

task :benchmarks => :environment do
  search_criteria = 'fixed'
  
  Benchmark.ips do |x|

    x.config(:time => 1, :warmup => 1)

    x.report("Full-text time with #{Post.count} records") do
      Fulltext::Posts::SearchQuery.new(search_criteria).call
    end
  
    x.report("Elastic time with #{Post.count} records") do
      Elastic::Posts::SearchQuery.new(search_criteria).call
    end
  
    x.compare!
  end
end

