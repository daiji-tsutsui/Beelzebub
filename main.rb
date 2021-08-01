require 'uri'
require 'net/http'
require 'json'

def fetch
  uri = URI.parse("https://versatileapi.herokuapp.com/api/text/all")
  params = {}
  uri.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(uri)
  return JSON.parse(res.body)
end

def help
text = <<EOT
  NUMBER: \tshow 5 tweets older than the latest by $NUMBER
EOT
puts text
end



hash = fetch

while true
  print "\n"
  print 'Enter "help" or "\h" to display available commands...'
  print "\n> "

  command = gets.chomp

  if /(\d+)/ === command
    num = Regexp.last_match[0].to_i
    for i in 0..4
      pp hash[num + i]["text"]
    end
  elsif command == 'help' || command == '\h'
    help
  end
end
