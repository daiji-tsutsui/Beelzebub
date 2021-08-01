require 'uri'
require 'net/http'
require 'json'

uri = URI.parse("https://versatileapi.herokuapp.com/api/text/all")
params = {}
uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)
hash = JSON.parse(res.body)

while true
  puts 'Input the index of post desired... (Press Ctrl+C to quit)'
  num = gets.chomp.to_i
  for i in 0..4
    pp hash[num + i]["text"]
  end
  puts "\n"
end
