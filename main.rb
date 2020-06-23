require 'json'

search_query = ''
puts "「絵描きさんと繋がりたい #{search_query}」で検索します..."
url = "/1.1/search/tweets.json?q=%23絵描きさんと繋がりたい\&count=100\&lang=ja\&result_type=recent\&f=live"

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
