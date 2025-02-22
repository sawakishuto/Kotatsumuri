module ValueObject
class Base
  include ActiveModel::Model

  def initialize
    fail ActiveRecord::RecordInvalid unless valid?
  end

  # @param other [::Value::Base]
  # @return [true, false]
  def ==(other)
    evaluate_attributes.all? { |variable| try(variable) == other.try(variable) }
  end

  private

  # @return [Array<String>] attributes used to equal evaluation
  def evaluate_attributes
    fail NotImplementedError
  end
end
end
