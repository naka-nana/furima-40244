# README

## データベース設計

## Usersテーブル

| Column	           | Type     | Options                      |
| ------------------ | ---------| ---------------------------- |
| last_name          | string   | null: false                  | 
| first_name         | string   | null: false                  | 
| last_name_kana     | string   | null: false                  |
| first_name_kana    | string   | null: false                  |
| nickname           | string   | null: false                  |
| email              | string   | null: false, unique: true    |
| encrypted_password | string   | null: false                  |
| birthday           |	date	  | null: false                  |
### Association
has_many :items
has_many :purchase_histories

## itemsテーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| name            | string    | null: false                    |
| description     | text	    | null: false                    |
| price	          | integer   | null: false                    |
| category_id     | integer	  | null: false                    |
| condition_id    | integer   | null: false                    |
| shipping_fee_id | integer   | null: false                    |
| prefecture_id   |	integer	  | null: false                    |
| shipping_day_id|	integer	  | null: false                    |
### Association
belongs_to :user
has_one :purchase_history

## PurchaseHistoriesテーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| user            | references | null:false, foreign_key: true  |
| item            | references | null:false, foreign_key: true  |
### Association
belongs_to :user
belongs_to :product
has_one :delivery_address

## DeliveryAddressesテーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| postal_code     | string	  | null: false                    |
| prefecture_id   | integer   |	null: false                    |
| city            |	string	  | null: false                    |
| address         |	string	  | null: false                    |
| building        |	string	  |                                |
| phone_number    |	string	  | null: false                    |
| purchase_history | references | null: false, foreign_key: true|
### Association
belongs_to :purchase_history

* This README would normally document whatever steps are necessary to get the
application up and running.

* Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
