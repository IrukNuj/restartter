require 'json'

HASH_OPTION = '-h'

def is_followed?(user)
  !!user['user']['following']
end

def is_following_succeed?(res)
  res.has_key?('errors')
end

def puts_user_info(user)
  puts "---------------------------"
  puts "id: #{user['id']}"
  puts "name: #{user['user']['name']}"
  puts "screen_name: @#{user['user']['screen_name']}"
end

def puts_follow_result(follow_result)
  puts('フォロー済みです。') unless follow_result
  if follow_result
    puts is_following_succeed?(follow_result) ? 'フォローに失敗しました...' : 'フォローしました！'
  end
end

def create_friendships(user)
  is_followed?(user) ? nil :  JSON.parse(`twurl -d 'screen_name=#{user['user']['screen_name']}' /1.1/friendships/create.json`)
end


def main
  search_query = ARGV.map {|a| a.dup}

  if search_query.include?(HASH_OPTION)
    search_query.delete(HASH_OPTION)
    search_query.each {|a| a.insert(0, '#')}
  end

  search_query = search_query.join(' ')

  puts "「#{search_query}」で検索します..."

  url = URI.escape("/1.1/search/tweets.json?q=#{search_query}&count=100&lang=ja&result_type=recent&f=live&include_entities=false")
  result = JSON.parse(`twurl #{url}`)

  if result.has_key?('errors')
    puts '検索の取得に失敗しました...'
    pp result
    exit
  end

  result['statuses'].each do |user|
    puts_user_info(user)
    response = create_friendships(user)
    puts_follow_result(response)
  end
end

main()

