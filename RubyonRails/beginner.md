# Rails入門

## コマンド
### CRUD機能を一回で作成(Create,Read,Update,Delete)
※ただし実務ではあまり使用されない
```
docker compose exec コンテナ名 bin/rails generate scaffold モデル名 [カラム名:型] 
例：docker compose exec web bin/rails generate scaffold user name:string age:integer
```

### DBマイグレーションの状況を確認
```
docker compose exec コンテナ名 bin/rails db:migrate:status
例：docker compose exec web bin/rails db:migrate:status
```

## ルーティングの確認方法
```
コンソール：docker compose exec コンテナ名 bin/rails routes
ブラウザ：http://localhost:3000/rails/info/routes
```

## Rails記法
アクション実行前に何かを行いたい時
```
before_action :メソッド名, only: %i[ show edit ]
before_action :メソッド名, only: :index
```

アクション実行後に何かを行いたい時
```
after_action :メソッド名, only: %i[ show edit ]
after_action :メソッド名, only: :index
```

## ActiveRecord
[createメソッドとnew + saveメソッドの違い](https://qiita.com/yamato1491038/items/d4045812a65d9eb98348)
### new,create
```
# saveの際にtrue,falseを返すことができる
user = User.new(name: "test", email: "test@xxx.com")
user.save
```

### create
```
# new+saveに近い
user = User.create(name: "test", email: "test@xxx.com")
```

### find,find_by,where
[find、find_by、whereの違い](https://qiita.com/tsuchinoko_run/items/f3926caaec461cfa1ca3)

[【Rails】find・find_by・whereについてまとめてみた](https://qiita.com/nakayuu07/items/3d5e2f8784b6f18186f2)
```
# ID(主キー)を使ってレコードを取得
user = User.find(1)

# 条件を指定し、一致する最初のレコードを取得 
user = User.find_by(name: "test", email: "test@xxx.com")

# 条件を指定し、一致する全てのレコードを取得
users = User.where(name: "test")
```

### コールバック
```
1.before_validation: バリデーションが実行される前に呼び出される
2.after_validation: バリデーションが実行された後に呼び出される
3.before_save: レコードが保存される前に呼び出される
4.after_save: レコードが保存された後に呼び出される
5.before_destroy: レコードが削除される前に呼び出される
6.after_destroy: レコードが削除された後に呼び出される
```
