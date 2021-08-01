
# =============================
#    Dummy user
# =============================
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


# =============================
#    Show posts
# =============================
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


# =============================
#    Show users
# =============================
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
