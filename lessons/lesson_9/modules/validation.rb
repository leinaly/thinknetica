# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(attr_name, *args)
      @validates ||= []
      @validates << { attr_name => args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |to_validate|
        to_validate.each do |name, args|
          val = instance_variable_get("@#{name}")
          send("validate_#{args[0]}", val, *args[1])
        end
      end
      true
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(value)
      raise "Value: #{value} is not set!" if value.nil?
    end

    def validate_type(value, type)
      raise "Wrong class for #{value}! Must be: #{type}!" unless value.is_a?(type)
    end

    def validate_format(value, format)
      raise "Wrong data format for #{value}!" if value !~ format
    end

    def validate_speciality(value, speciality)
      raise "Not applicable type of #{value}! Need to be from: #{speciality}" unless speciality == value
    end
  end
end
