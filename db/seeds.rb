POSTS_COUNT = 1_000_000
THREADS_COUNT = 10

puts '========== Generating data =========='

# Using 10 threads
threads = Array.new(THREADS_COUNT) do |index|
  Thread.new do
    result = Array.new(POSTS_COUNT / THREADS_COUNT) do
      {
        title: Faker::Lorem.sentence, 
        body: Faker::Lorem.paragraph,
        topic: Faker::Company.industry
      }
    end

    puts "Finished thread #{index}"

    result
  end
end

posts_data = threads.flat_map(&:value)

puts '========== Data generated =========='

if Post.create(posts_data)
  puts '========== Posts created =========='
else
  puts '========== Error creating posts =========='
end

puts "========== Now you have #{Post.count} =========="
