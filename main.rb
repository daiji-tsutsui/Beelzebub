require 'uri'
require 'net/http'
require 'json'

uri = URI.parse("https://versatileapi.herokuapp.com/api/text/all")
params = {}
uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)
hash = JSON.parse(res.body)

for i in 0..6
  pp hash[i]["text"]
end
