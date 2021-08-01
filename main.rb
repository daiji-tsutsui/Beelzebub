require 'uri'
require 'net/http'
require 'json'


def start
logo = <<EOT

+=========================================+
|                                         |
|        B  E  E  L  Z  E  B  U  B        |
|                                         |
+=========================================+
 A simple viewer for 'SNS for Engineer'
(see https://qiita.com/HawkClaws/items/599d7666f55e79ef7f56)

EOT
  puts logo
end


def fetch_posts
  uri = URI.parse("https://versatileapi.herokuapp.com/api/text/all")
  params = {}
  uri.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(uri)
  return JSON.parse(res.body).reverse
end

def fetch_users
  uri = URI.parse("https://versatileapi.herokuapp.com/api/user/all")
  res = Net::HTTP.get_response(uri)
  return JSON.parse(res.body)
end

def fetch
  puts "Fetching posts...\n\n"
  return fetch_posts, fetch_users
end


def help
text = <<EOT

  NUM: \tShow 5 posts older than the latest by $NUM
  NUM1 NUM2: \tShow $NUM2 posts older than the latest by $NUM1

  NAME(<=7): \tShow user including $NAME in name
  HASH(>=8): \tShow user including $HASH in _user_id

  help, \\h: \tShow help, it's me!
  quit, \\q: \tQuit Beelzebub
  fetch, \\f: \tFetch the latest posts

EOT
  puts text
end


def no_user(id)
  no_user = {
    "id"=>"#{id}",
    "_created_at"=>"1970-01-01T00:00:00.000+00:00",
    "_updated_at"=>"1970-01-01T00:00:00.000+00:00",
    "_user_id"=>"#{id}",
    "description"=>"There is no such user registered...",
    "name"=>"UnknownUser"
  }
  return no_user
end

def show_post(num, post, user)
post = <<EOT
  #{num}: #{post["text"]}
      By #{user["name"]}(#{user["_user_id"][0, 8]})
      Posted at #{post["_created_at"]}

EOT
  puts post
end

def show_posts(posts, users, num = 0, itr = 5)
  for i in 0..itr - 1
    post = posts[num + i]
    begin
      user = users.find { |elm| elm["_user_id"].include?(post["_user_id"]) }
      show_post(num + i, post, user)
    rescue => error
      show_post(num + i, post, no_user(post["_user_id"]))
    end
  end
end


def user_info(user)
user_info = <<EOT
#{user["name"]} ---
| #{user["description"]}
|
| Signed up at #{user["_created_at"]}
| UserId: #{user["_user_id"]}

EOT
return user_info
end

def show_user_by_id(users, user_id)
  begin
    user = users.find { |elm| !elm["_user_id"].index(user_id).nil? }
  rescue => error
    # puts "by_id: #{error.message}"
  end
  user = no_user(user_id) if user.nil?
  puts user_info(user)
end

def show_user_by_name(users, user_name)
  begin
    user = users.find { |elm| !elm["name"].index(user_name).nil? }
  rescue => error
    # puts "by_name: #{error.message}"
  end
  user = no_user(user_name) if user.nil?
  puts user_info(user)
end




# =============================
#    Main routine
# =============================

start
posts, users = fetch

while true
  print 'Enter "help" or "\h" to display available commands'
  print "\n> "

  command = gets.chomp

  if /\A(\d+)\s+(\d+)\z/ === command
    match = Regexp.last_match
    num = match[1].to_i
    itr = match[2].to_i
    show_posts(posts, users, num, itr)
  elsif /\A(\d+)\z/ === command
    num = Regexp.last_match[1].to_i
    show_posts(posts, users, num)
  elsif command == ''
    show_posts(posts, users)
  elsif command == 'help' || command == '\h'
    help
  elsif command == 'quit' || command == '\q' || command == 'exit' || command == '\e'
    puts "\nGoodBye...\n\n"
    break
  elsif command == 'fetch' || command == '\f'
    puts "\n"
    fetch
  elsif /(\w{8,})/ === command
    user_id = Regexp.last_match[1]
    show_user_by_id(users, user_id)
  elsif /([a-zA-Zぁ-んァ-ヴ]{,7})/u === command
    user_name = Regexp.last_match[1]
    show_user_by_name(users, user_name)
  else
    puts "\n"
  end
end
