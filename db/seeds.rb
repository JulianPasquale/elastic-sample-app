POSTS_COUNT = 1_000

posts_data = Array.new(POSTS_COUNT) do
  {
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    topic: Faker::Company.industry
  }
end

posts_data << {
  title: "Fixed title #{Time.now.to_i}",
  body: "Fixed body #{Time.now.to_i}",
  topic: Faker::Company.industry
}
puts '========== Data generated =========='

if Post.create(posts_data)
  puts '========== Posts created =========='
else
  puts '========== Error creating posts =========='
end

puts "========== Now you have #{Post.count} =========="

puts "========== Importing to Elastic =========="
Post.__elasticsearch__.create_index!
Post.import

puts "========== Done =========="