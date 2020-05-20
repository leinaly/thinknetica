# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend self
  end

  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      raise TypeError, 'Method name is not a symbol!' unless attr.is_a?(Symbol)

      define_method(attr) do
        init_if_not_define("@#{attr}_history", [])
        init_if_not_define("@#{attr}", nil)
      end

      define_method("#{attr}_history".to_sym) do
        init_if_not_define("@#{attr}_history", [])
      end

      define_method("#{attr}=".to_sym) do |v|
        init_if_not_define("@#{attr}_history", [])
        save_history("@#{attr}_history", v)
        instance_variable_set("@#{attr}", v)
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    raise TypeError, 'Method name is not a symbol!' unless attr_name.is_a?(Symbol)
    raise TypeError, 'Class is not a class type!' unless attr_class.is_a?(Class)

    define_method(attr_name) do
      init_if_not_define("@#{attr_name}", nil)
    end

    define_method("#{attr_name}=") do |v|
      raise TypeError, "Value type not correct! Must be: #{attr_class}" unless v.is_a?(attr_class)

      instance_variable_set("@#{attr_name}", v)
    end
  end

  private

  def init_if_not_define(attr_name, default_value)
    attr_name = attr_name.to_sym unless attr_name.is_a?(Symbol)
    instance_variable_get(attr_name) || instance_variable_set(attr_name, default_value)
  end

  def save_history(attr_name, value)
    attr_name = attr_name.to_sym unless attr_name.is_a?(Symbol)
    instance_variable_get(attr_name).send('<<', value)
  end
end
