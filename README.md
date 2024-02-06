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


## Productsテーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| user            | reference | null: false, foreign_key: true |
| name            | string    | null: false                    |
| description     | text	    | null: false                    |
| price	          | integer   | null: false                    |
| image_ref       | string    | null: false                    |
| category        | string	  | null: false                    |
| condition       | string    | null: false                    |
| shipping_fee    | string    | null: false                    |
| shipping_region |	string	  | null: false                    |
| shipping_days   |	string	  | null: false                    |

## PurchaseHistoriesテーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| id              | bigint    | primary key                    |
| user            | reference | null:false, foreign_key: true  |
| product_id      | bigint    | foreign key                    |
| quantity        | integer   |                                |
| total_price     | integer   |                                |

## DeliveryAddressesテーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| id              | bigint    | primary key                    |
| recipient_name  | string    | null: false                    |
| address         | string    | null: false                    |
| postal_code     | string    | null: false                    |

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
