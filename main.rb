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


def fetch
  puts "Fetching posts...\n\n"
  uri = URI.parse("https://versatileapi.herokuapp.com/api/text/all")
  params = {}
  uri.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(uri)
  return JSON.parse(res.body)
end


def help
text = <<EOT

  NUMBER: \tShow 5 posts older than the latest by $NUMBER

  help, \\h: \tShow help, it's me!
  quit, \\q: \tQuit Beelzebub
  fetch, \\f: \tFetch the latest posts

EOT
puts text
end


def show_post(num, data)
post = <<EOT
  #{num}: #{data["text"]}
      By #{data["_user_id"]}
      Posted at #{data["_created_at"]}

EOT
puts post
end

def show_posts(hash, num, itr)
  for i in 0..itr - 1
    show_post(num + i, hash[num + i])
  end
end



# =============================
#    Main routine
# =============================

start
hash = fetch

while true
  print 'Enter "help" or "\h" to display available commands'
  print "\n> "

  command = gets.chomp

  if /(\d+)/ === command
    num = Regexp.last_match[0].to_i
    show_posts(hash, num, 5)
  elsif command == ''
    show_posts(hash, 0, 5)
  elsif command == 'help' || command == '\h'
    help
  elsif command == 'quit' || command == '\q' || command == 'exit' || command == '\e'
    puts "\nGoodBye...\n\n"
    break
  elsif command == 'fetch' || command == '\f'
    puts "\n"
    fetch
  else
    puts "\n"
  end
end
