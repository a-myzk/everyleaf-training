# 【株式会社万葉様新入社員教育課題】


## テーブルスキーマ

### Taskモデル
| カラム名 | テーブル名 | 備考 |
| - | - | - |
| id | integer | タスクID |
| title | string | タスク名 |
| content | text | タスク詳細 |
| status | string | ステータス |
| deadline | datetime | 終了期限 |
| priority | integer | 優先順位 |

### Userモデル
| カラム名 | データ型 | 備考 |
| - | - | - |
| user_id | integer | ユーザーID |
| name | string | ユーザー名 |
| email | string | メールアドレス |
| password_digest | string | パスワード |

### Labelモデル
| カラム名 | データ型 | 備考 |
| - | - | - |
| label_id | integer | ラベルID |
| label_name | string | ラベル名 |



## Herokuへのデプロイ手順（Macの場合)

1.デプロイするアプリのディレクトリに移動
```
$ cd アプリのディレクトリ名
```

2.Herokuにログインする
```
$ heroku login
```

3.Herokuに新しいアプリケーションを作成
```
$ heroku create
```

4.heroku-18へstackを切り替える
```
$ heroku stack:set heroku-18
```

5.アセットプリコンパイルをする
```
$ rails assets:precompile RAILS_ENV=production
```

6.コミットする
```
$ git add -A
$ git commit -m "コミットメッセージ"
```

7.Herokuにデプロイをする
```
$ git push heroku master
```

- ブランチを指定する場合 `$ git push heroku ブランチ名:master`

8.マイグレーション
```
$ heroku run rails db:migrate
```
