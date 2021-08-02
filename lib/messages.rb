
def start
logo = <<EOT

                                      |E /E
                                      \\ Z/
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

  NUM: \tShow 5 posts older than the latest by $NUM
  NUM1 NUM2: \tShow $NUM2 posts older than the latest by $NUM1

  NAME(<=7): \tShow user including $NAME in name
  HASH(>=8): \tShow user including $HASH in _user_id

  help, \\h: \tShow help, it's me!
  quit, \\q: \tQuit Beelzebub
  fetch, \\f: \tFetch the latest posts

EOT
  puts text
end
