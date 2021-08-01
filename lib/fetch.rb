require 'uri'
require 'net/http'
require 'json'

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
