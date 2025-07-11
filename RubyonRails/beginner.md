# Rails入門

## コマンド
### CRUD機能を一回で作成(Create,Read,Update,Delete)
※ただし実務ではあまり使用されない
```
docker compose exec コンテナ名 bin/rails generate scaffold モデル名 [カラム名:型]
例：docker compose exec web bin/rails generate scaffold user name:string age:integer
```

### genarate

[Raisガイド](https://railsguides.jp/active_record_migrations.html)

```
# マイグレーションファイルの生成
docker compose exec コンテナ名 rails generate migration マイグレーション名

# こんな感じで作成される
docker compose exec web bin/rails generate migration CreateArticles title:string body:text
class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false, default: '記事のタイトル'
      t.text :body
      t.timestamps
    end
  end
end

# カラムを追加したい時の例
docker compose exec web bin/rails generate migration AddTelToUsers tel:string
class AddTelToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tel, :string
  end
end
```

### DB
```
# マイグレーションファイルの適用状況
docker compose exec コンテナ名 bin/rails db:migrate:status
例：docker compose exec web bin/rails db:migrate:status

# drop,create,migrateの順に実行
docker compose exec コンテナ名 rails db:migrate:reset

# 最新のマイグレーションファイルを一つロールバック
docker compose exec コンテナ名 rails db:rollback
```

## ルーティングの確認方法
```
コンソール：docker compose exec コンテナ名 bin/rails routes
ブラウザ：http://localhost:3000/rails/info/routes
```

## Rails記法

### アクション

```
＃ 実行前に何かを行いたい時
before_action :メソッド名, only: %i[ show edit ]
before_action :メソッド名, only: :index
```

```
# 実行後に何かを行いたい時
after_action :メソッド名, only: %i[ show edit ]
after_action :メソッド名, only: :index
```

### バリデーション
```
class User < ApplicationRecord
  # 再確認
  validates :password, confirmation: true

  ＃ フォーマット
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  ＃　文字列の長さ
  validates :username, length: { minimum: 3, maximum: 20 }

  ＃　数値チェック
  validates :age, numericality: { only_integer: true }

  # 空でないかチェック
  validates :username, presence: true

  # 重複していないかチェック
  validates :email, uniqueness: true
end
```

### アソシエーション
```
- belongs_to：モデルが他のモデルに従属する場合に使用。例：BookモデルがAuthorに属する。
- has_one：一方のモデルが他方のモデルを所有する場合に使用。例：SupplierがAccountを持つ。
- has_many：モデルが複数の他モデルを所有する場合に使用。例：Authorが複数のBookを持つ。
- has_many :through：中間モデルを介して多対多の関係を設定。例：Physicianがappointmentsを通じてPatientと関係する。
- has_one :through：中間モデルを介して一対一の関係を設定。例：SupplierがAccountを通じてAccountHistoryと関係する。
- has_and_belongs_to_many：中間モデルなしで多対多の関係を設定。例：AssemblyとPartが互いに多対多の関係を持つ。

belongs_toとhas_oneの選択は外部キーの位置によって決まり、has_many :throughとhas_and_belongs_to_manyの選択は中間モデルの必要性によって決まります。
```

### ルーティング

#### resources

|Helper|HTTP verb|Path|コントローラー#アクション|
|---|---|---|---|
|posts_path|GET|/posts|posts#index|
|new_post_path|GET|/posts/new|posts#new|
|posts_path|POST|/posts|posts#create|
|post_path|GET|/posts/:id|posts#show|
|edit_post_path|GET|/posts/:id/edit|posts#edit|
|post_path|PATCH or PUT|/posts/:id|posts#update|
|post_path|DELETE|/posts/:id|posts#destroy|

#### resource

|Helper|HTTP verb|Path|コントローラー#アクション|
|---|---|---|---|
|new_geocoder_path|GET|/geocoder/new|geocoders#new|
|geocoder_path|POST|/geocoder|geocoders#create|
|geocoder_path|GET|/geocoder|geocoders#show|
|edit_geocoder_path|GET|/geocoder/edit|geocoders#edit|
|geocoder_path|PATCH or PUT|/geocoder/|geocoders#update|
|geocoder_path|DELETE|/geocoder/|geocoders#destroy/|

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

## その他
```
# rails db:migrate、 rails db:rollback コマンドは基本的に開発環境・テスト環境どちらの環境にも実行されますが、
# 時折テスト環境にコマンドが実行されないことがあります。そうした際はコマンドの後ろに RAILS_ENV=test を付けて
# テスト環境にコマンドを実行することを明示してください。
docker compose exec web rails db:migrate:status RAILS_ENV=test
docker compose exec web rails db:migrate RAILS_ENV=test
docker compose exec web rails db:rollback RAILS_ENV=test
```
