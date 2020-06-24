require 'json'

HASH_OPTION = '-h'

search_query = ARGV.map {|a| a.dup}

# p search_query

if search_query.include?(HASH_OPTION)
  search_query.delete(HASH_OPTION)
  search_query.each {|a|
    a.insert(0, '#')
  }
end

# p search_query

search_query = search_query.join(' ')


puts "「#{search_query}」で検索します..."
url = URI.escape("/1.1/search/tweets.json?q=#{search_query}&count=100&lang=ja&result_type=recent&f=live&include_entities=false")

# p url

result = JSON.parse(`twurl #{url}`)

# p result['statuses'].first

# p users.count

result['statuses'].each do |users|
  # pp res
  puts "---------------------------"
  puts "id: #{users['id']}"
  puts "name: #{users['user']['name']}"
  puts "screen_name: @#{users['user']['screen_name']}"

  status = JSON.parse(`twurl -d 'screen_name=#{users['user']['screen_name']}' /1.1/friendships/create.json`)

  # pp status
end


# p result
