POSTS_COUNT = 1_000_000

puts '========== Generating data =========='

# Using 10 threads
threads = Array.new(10) do |index|
  Thread.new do
    result = Array.new(POSTS_COUNT / 10) do
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

# posts_data = Array.new() do |index|
#   {
#     title: Faker::Lorem.sentence, 
#     body: Faker::Lorem.paragraph,
#     topic: Faker::Company.industry
#   }
# end

puts '========== Data generated =========='

if Post.create(posts_data)
  puts '========== Posts created =========='
else
  puts '========== Error creating posts =========='
end

puts "========== Now you have #{Post.count} =========="
