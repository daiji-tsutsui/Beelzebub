# Beelzebub

エンジニア・プログラマにしか使えないSNS (https://qiita.com/HawkClaws/items/599d7666f55e79ef7f56) のCUIクライアント．

WebAPIを叩く練習．
ほんとうはGUIにしたかったけどとりあえず実装まで．

現在はRuby環境（>=2.5.8）を想定．
一応Dockerでの起動もできる．

## 用法

```
$ cd Beelzebub
$ ruby main.rb
```
を叩けば
```
                                      |E /E
                                      \ Z
+=================================== # ###\
|                                   # # +##|
|       B  E  E  L  Z  E  B  U  B    H|###/
|                                    L /  |
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

## Dockerでの起動

```
$ cd Beelzebub
$ docker-compose up -d
$ docker attach beelzebub
```
を叩けば，一応ホスト側のRuby環境と関係なく使用可能．

しかし，現状では難点が三つ．
- `docker logs beelzebub`などを叩かないと，起動時のロゴが見えない．
- `docker attach beelzebub`を叩くと何のメッセージも出ず，唐突に入力受付が開始される．
- `Ctrl+C`でプロセスを離脱するとコンテナ自身も同時に終了する．

三つ目は捉えようによっては良い仕様．
だが，一つ目の難点は由々しき問題．

一応，
```
$ docker-compose up -d
$ docker exec -it beelzebub sh
/home/app # ruby main.rb
```
でも起動はでき，この場合には表示されるべきロゴが完全な状態で表示されるが，手順が無骨で好ましくない．
