# README

## データベース設計

## Usersテーブル

| Column	        | Type     | Options                   |
| --------------- | ---------| ------------------------- |
| id              | bigint   | primary key               |
| username        | string   |                           | 
| nickname        | string   |
| email           | string   | null: false, unique: true |
| password_digest | string   | null: false               |
| created_at      |	datetime | null: false               |
| updated_at	    | datetime | null: false               |

## Productsテーブル

| Column         | Type      | Options                   |
| -------------- | --------- | ------------------------- |
| id             | bigint    | primary key               |
| user_id        | bigint    | foreign key               |
| name           | string    |                           |	
| description    | text	     |                           |
| price	         | integer   |                           |	
| created_at     | datetime  | null: false               |
| updated_at     | datetime  | null: false               |

## Ordersテーブル

| Column         | Type      | Options                   |
| -------------- | --------- | ------------------------- |
| id             | bigint    | primary key               |
| user_id        | bigint    | foreign key               |
| product_id     | bigint	   | foreign key               |
| quantity       | integer   |                           |	
| total_price    | integer   |                           |	
| created_at     | datetime  | null: false               |
| updated_at	   | datetime  | null: false

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
