
def start
logo = <<EOT

                                      |E /E
                                      \\ Z
+=================================== # ###\\
|                                   # # +##|
|       B  E  E  L  Z  E  B  U  B    H|###/
|                                    L /  |
+=========================================+
 A simple viewer for 'SNS for Engineer'
(see https://qiita.com/HawkClaws/items/599d7666f55e79ef7f56)

EOT
  puts logo
end



def help
text = <<EOT

  NUM: \tShow 5 posts $NUM older than the latest by
  NUM1 NUM2: \tShow $NUM2 posts $NUM1 older than the latest

  NAME(<=7): \tShow users including $NAME in name
  NAME NUM: \tShow users including $NAME and $NUM latest posts by the users

  HASH(>=8): \tShow a user including $HASH in _user_id
  HASH NUM: \tShow a user including $HASH and $NUM latest posts by the user

  help, \\h: \tShow help, it's me!
  quit, \\q: \tQuit Beelzebub
  fetch, \\f: \tFetch the latest posts

EOT
  puts text
end
