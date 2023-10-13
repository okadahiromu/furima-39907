# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | -----------               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_day          | date   | null: false               |

### Association

- has_many :items
- has_many :orders



## items テーブル

| Column       | Type      | Options                       |
| -------------| ----------| ------------------------------|
| name         | string    | null: false                   |
| price        | integer   | null: false                   |
| description  | text      | null: false                   |
| category     | references| null: false, foreign_key: true|
| user         | references| null: false, foreign_key: true|
| shopping_cost| references| null: false, foreign_key: true|
| item_status  | references| null: false, foreign_key: true|
| prefecture   | references| null: false, foreign_key: true|
| shopping_date| references| null: false, foreign_key: true|


### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
- has_one :buyer

## buyers テーブル

| Column      | Type      | Options                        |
| ------------| --------  | ------------------------------ |
| post_code   | string    | null: false                    |
| city        | string    | null: false                    |
| block       | string    | null: false                    |
| building    | string    | null: false                    |
| phone_number| integer   | null: false                    |
| prefecture  |references | null: false, foreign_key: true |
| order       |references | null: false, foreign_key: true |

### Association

- belongs_to :order