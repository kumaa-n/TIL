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
