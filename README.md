# README

## バージョン  
Ruby 2.6.5  
Ruby on Rails 5.2.4  
  
## 機能一覧　　
  
  ### 消費者ユーザー、事業者ユーザー共通
 * 新規登録機能
 * ログイン機能  
 * ユーザー情報の編集、削除機能   
 * お気に入り機能
    
  ### 消費者ユーザー向け
 * ユーザー詳細表示機能
    * お気に入り登録したお店の広告一覧が表示される
 * コメント投稿機能
    
  ### 事業者ユーザー向け
 * ユーザー詳細表示機能
    * お店に対して投稿されたコメント一覧が表示される
    * お気に入り登録したお店の広告は別のページで表示される
 * 広告投稿機能 
 　　
   　　
## カタログ設計
    
　https://docs.google.com/spreadsheets/d/1RiMBjgKxm8aeBtD8f08ma_zYpvrsid1E/edit#gid=1925441201   
 
 ## テーブル定義
    
　https://docs.google.com/spreadsheets/d/1RiMBjgKxm8aeBtD8f08ma_zYpvrsid1E/edit#gid=1247845635
    
 ## ER図
    
　https://docs.google.com/spreadsheets/d/1RiMBjgKxm8aeBtD8f08ma_zYpvrsid1E/edit#gid=1816160013
　　
  ## 画面遷移図
    
　https://docs.google.com/spreadsheets/d/1bGTSrQKmGEWH7Ybl3to32qo1ybYpm8BmUQ_fkTi7dCw/edit#gid=0
    
 ## 画面ワイヤーフレーム
    
　https://docs.google.com/spreadsheets/d/10qFinOCj9aJTE8e27kO68EaIlOwEZZODZNZXI8j_FIc/edit#gid=0
    
 ## 使用予定Gem
 
   * carrierwave
   * mini_magick
   * dotenv-rails
   * unicorn
   * mini_racer
   * capistrano
   
 ## 就職タームから使用する技術
   
   * コメント機能（編集や削除もできること。投稿失敗時にエラーメッセージをAjaxで出力する）
     * お店に対するコメントで使用します  
   * フォロー機能  
     * お店同士のお気に入り機能（同モデル同士でフォロー、フォロワーの関係を生成）で使用します
     
 ## カリキュラム内から使用する技術
   
   * 次のWebAPI, jQueryプラグインを使って、お店の住所の天気を表示、郵便番号から住所の自動入力を実装します。  
     * https://openweathermap.org  
     * https://github.com/ninton/jquery.jpostal.js

