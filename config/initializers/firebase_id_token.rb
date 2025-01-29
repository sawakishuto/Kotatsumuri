FirebaseIdToken.configure do |config|
  # Google Cloud コンソールで取得した Firebase プロジェクトIDを設定
  config.project_ids = ENV["FIREBASE_PROJECT_ID"]
end