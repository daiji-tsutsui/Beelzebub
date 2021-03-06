require "./lib/fetch.rb"
require "./lib/messages.rb"
require "./lib/show.rb"


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
    posts, users = fetch

  elsif /(\w{8,})\s+(\d+)/ === command
    match = Regexp.last_match
    user_id = match[1]
    itr = match[2].to_i
    show_user_by_id(users, user_id, posts, itr)

  elsif /([a-zA-Zぁ-んァ-ヴ]{1,7})\s+(\d+)/u === command
    match = Regexp.last_match
    user_name = match[1]
    itr = match[2].to_i
    show_user_by_name(users, user_name, posts, itr)

  elsif /(\w{8,})/ === command
    user_id = Regexp.last_match[1]
    show_user_by_id(users, user_id)

  elsif /([a-zA-Zぁ-んァ-ヴ]{1,7})/u === command
    user_name = Regexp.last_match[1]
    show_user_by_name(users, user_name)

  else
    puts "\n"

  end
end
