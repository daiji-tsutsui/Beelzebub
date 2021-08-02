
# =============================
#    Dummy user
# =============================
def no_user(id)
  no_user = {
    "id"          =>  "-1",
    "_created_at" =>  "1970-01-01T00:00:00.000+00:00",
    "_updated_at" =>  "1970-01-01T00:00:00.000+00:00",
    "_user_id"    =>  "#{id}",
    "description" =>  "There is no such user registered...",
    "name"        =>  "#{id}"
  }
  return no_user
end

def registered?(user)
  return user["id"] != "-1"
end


# =============================
#    Show posts
# =============================
def show_post(num, post, user)
post = <<EOT
  #{num}: #{user["name"]}(#{user["_user_id"][0, 8]})
      #{post["text"]}
          Posted at #{post["_created_at"]}

EOT
  puts post
end

def show_posts(posts, users, num = 0, itr = 5)
  for i in 0..itr - 1
    post = posts[num + i]
    begin
      user = users.find { |elm| elm["_user_id"].include?(post["_user_id"]) }
    rescue => error
      # puts "show_posts: #{error.message}"
      user = no_user(post["_user_id"])
    end
    user = no_user(post["_user_id"]) if user.nil?
    show_post(num + i, post, user)
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

def show_user_by_id(users, user_id, posts = [], itr = 0)
  begin
    user = users.find { |elm| !elm["_user_id"].index(user_id).nil? }
  rescue => error
    # puts "by_id: #{error.message}"
  end
  user = no_user(user_id) if user.nil?
  puts user_info(user)

  if registered?(user)
    puts itr
    posts_hit = posts.select { |elm| !elm["_user_id"].index(user_id).nil? }
    show_posts(posts_hit, [user], 0, itr)
  end
end

def show_user_by_name(users, user_name, itr = 0)
  users_hit = users.select { |elm| !elm["name"].index(user_name).nil? }
  users_hit = [ no_user(user_name) ] if users_hit.nil? || users_hit.empty?

  users_hit.each do |user|
    puts user_info(user)
  end

end
