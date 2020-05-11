module Validation
  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise "Need to implement in class!"
  end
end
