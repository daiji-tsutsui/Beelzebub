# Beelzebub

エンジニア・プログラマにしか使えないSNS (https://qiita.com/HawkClaws/items/599d7666f55e79ef7f56) のCUIクライアント．

WebAPIを叩く練習．
ほんとうはGUIにしたかったけどとりあえず実装まで．

現在はRuby環境（>=2.5.8）を想定．
そのうちDockerでの起動もできるようにしたい．

ざっくり用法の紹介．
```
$ cd Beelzebub
$ ruby main.rb
```
を叩けば
```
+=========================================+
|                                         |
|        B  E  E  L  Z  E  B  U  B        |
|                                         |
+=========================================+
 A simple viewer for 'SNS for Engineer'
(see https://qiita.com/HawkClaws/items/599d7666f55e79ef7f56)

Fetching posts...

Enter "help" or "\h" to display available commands
>
```
のような画面で入力待ちになるので，`help`と入力して`Enter`を押せば
```
> help

  NUM:  Show 5 posts older than the latest by $NUM
  NUM1 NUM2:    Show $NUM2 posts older than the latest by $NUM1

  NAME(<=7):    Show user including $NAME in name
  HASH(>=8):    Show user including $HASH in _user_id

  help, \h:     Show help, it's me!
  quit, \q:     Quit Beelzebub
  fetch, \f:    Fetch the latest posts
```
のようにコマンド説明が表示される．

何も入力せずに`Enter`を押すと，直近から5件分のポストが表示される．
