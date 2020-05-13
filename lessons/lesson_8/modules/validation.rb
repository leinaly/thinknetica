# frozen_string_literal: true

module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise 'Need to implement in class!'
  end
end
