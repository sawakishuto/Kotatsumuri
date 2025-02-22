  module Entity
    class User
      attr_reader :firebase_uid, :email, :name

      def initialize(firebase_uid:, email:, name:)
        @firebase_uid = firebase_uid
        @email = email
        @name = name
      end

      private

      def validate!
        raise ArgumentError, "firebase_uid is required" if @firebase_uid.nil?
        raise ArgumentError, "email is required" if @email.nil?
        raise ArgumentError, "name is required" if @name.nil?
    end
    end
  end
