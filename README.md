# 【株式会社万葉様新入社員教育課題】

## テーブルスキーマ

### Taskモデル
| カラム名 | テーブル名 | 備考 |
| - | - | - |
| id | integer | タスクID |
| title | string | タスク名 |
| content | text | 内容 |
| status | string | ステータス |
| limit | datetime | 終了期限 |
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