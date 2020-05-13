# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def receive(train)
    raise "Station #{name} can receive only one train at once! Please receive one Train." if train.is_a?(Array)

    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_by_type(type = '')
    case type
    when ''
      show_all_trains
    when Train::TYPE['passenger train']
      puts 'Passenger trains: '
      show_all_trains(@trains.select { |train| train.type == Train::TYPE['passenger train'] })
    when Train::TYPE['freight train']
      puts 'Freight trains: '
      show_all_trains(@trains.select { |train| train.type == Train::TYPE['freight train'] })
    else
      puts 'Sorry, have no idea what type is it.'
    end
  end

  def each_train(block)
    @trains.each_with_index { |train, index| block.call(train, index) }
  end

  private

  def validate!
    raise "Name can't be blank!" if name.empty?
  end
end
