# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_day          | date   | null: false |

### Association

- has_many :items
- has_many :orders



## items テーブル

| Column       | Type   | Options                       |
| -------------| ------ | ------------------------------|
| name         | string | null: false                   |
| price        | string | null: false                   |
| image        | text   | null: false                   |
| description  | string | null: false                   |
| status       | string | null: false                   |
| category_id  | integer| null: false, foreign_key: true|
| user_id      | integer| null: false, foreign_key: true|

### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user_id| integer    | null: false, foreign_key: true |
| item_id| string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
- has_one :buyer

## buyers テーブル

| Column      | Type    | Options                        |
| ------------| --------| ------------------------------ |
| post_code   | string  | null: false                    |
| address     | string  | null: false                    |
| phone_number| string  | null: false                    |
| user_id     | integer | null: false, foreign_key: true |

### Association

- belongs_to :order