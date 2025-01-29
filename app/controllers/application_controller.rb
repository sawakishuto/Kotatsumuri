class ApplicationController < ActionController::API
  before_action :authenticate_firebase_user

  attr_reader :current_user

  private

  def authenticate_firebase_user
    header = request.headers["Authorization"]
    return unauthorized unless header.present?

    token = header.split(" ").last
    begin
      peyload = FirebaseIdToken::Signature.verify(token)

      firebase_uid = payload['sub']

      @current_user = User.find_or_create_by!(firebase_uid: firebase_uid) do |u|
        u.email = user_email
        # 他にも必要な情報があればここでセット
      end
    rescue => e
      # 検証エラー時は 401 を返す
      Rails.logger.warn "Firebase auth error: #{e.message}"
      return unauthorized
    end
  end
  
  def unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
