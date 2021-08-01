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
  puts "Fetching posts...\n"
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



start
hash = fetch

while true
  print "\n"
  print 'Enter "help" or "\h" to display available commands'
  print "\n> "

  command = gets.chomp

  if /(\d+)/ === command
    num = Regexp.last_match[0].to_i
    for i in 0..4
      puts "  #{num + i}: #{hash[num + i]["text"]}"
    end
  elsif command == 'help' || command == '\h'
    help
  elsif command == 'quit' || command == '\q' || command == 'exit' || command == '\e'
    puts "\nGoodBye...\n\n"
    break
  elsif command == 'fetch' || command == '\f'
    fetch
  end
end
