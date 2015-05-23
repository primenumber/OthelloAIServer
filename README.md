OthelloAIServer
====

[SimpleChat](https://github.com/primenumber/SimpleChatServer)を使った簡易オセロAI自動対戦サーバー

- SimpleChatでAIと通信(別途SimpleChatServerを立てる必要がある)
- tagにothelloが入ったメッセージだけ受け取る
- 先手後手両方のAIの準備ができたら試合開始の合図を送信する
- その後は着手を垂れ流す
- 今のところ合法着手かは判定していない

## 初期化

```
$ git submodule iniy
$ git submodule update
```

## 対戦方法

最初にhoge:黒 poyo:白、次にfuga:黒 nyaa:白で対戦を行う場合

```
$ ruby main.rb
hoge poyo
fuga nyaa
```
