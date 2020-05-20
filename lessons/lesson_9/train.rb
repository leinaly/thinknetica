# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/company'
require_relative 'modules/validation'
require_relative 'modules/accessors'

class Train
  include InstanceCounter
  include Company
  include Validation
  include Acсessors

  @@trains = {}

  TYPE = { 'freight train' => 0, 'passenger train' => 1 }
  NUMB_FORMAT = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/i

  attr_reader :number, :type, :wagons, :current_station
  attr_accessor_with_history :speed
  strong_attr_accessor :route, Route

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMB_FORMAT
  validate :type, :speciality, TYPE['passenger train']

  def initialize(number, type = TYPE['passenger train'])
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def type_name
    TYPE.key(type)
  end

  def accelerate(step)
    raise 'Can accelerate only by numeric value!' unless step.is_a?(Integer)
    raise 'Please accelerate with positive value!' if step.negative?

    self.speed += step
  end

  def slow_down(step = -@speed)
    raise 'Can slow down only by numeric value!' unless step.is_a?(Integer)
    raise 'Please slow down with negative value!' if step.positive?

    raise 'Already stopped!' if @speed.zero?

    self.speed += step
  end

  def add_route(route)
    self.route = route
    @route.start_station.receive(self)
    @current_station = route.start_station
  end

  def go_to_next_station
    raise 'Train already finished route!' if @current_station == @route.end_station

    @current_station.send_train(self)
    raise 'No next station! Train already on the last station of the route.' if next_station.nil?

    @current_station = next_station
    @current_station.receive(self)
  end

  def go_to_prev_station
    raise 'Train already at the start of route!' if @current_station == @route.start_station

    @current_station.send_train(self)
    raise 'No previous station! Train already on the first station of the route.' if prev_station.nil?

    @current_station = prev_station
    @current_station.receive(self)
  end

  def next_station
    raise 'Route not set!' if @route.nil?

    n_st = @route.next_station_for(@current_station)
    n_st = nil if current_station?(n_st)

    n_st
  end

  def prev_station
    raise 'Route not set!' unless @route

    p_st = @route.prev_station_for(@current_station)
    p_st = nil if current_station?(p_st)

    p_st
  end

  def each_wagon(block)
    @wagons.each_with_index { |wagon, index| block.call(wagon, index) }
  end

  protected # cause need to be reimplemented in child classes

  def current_station?(station)
    station == @current_station
  end

  def add_wagon(wagon)
    raise 'Need to slow down train first!' if speed != 0

    @wagons << wagon
  end

  def remove_wagon(wagon)
    raise 'Need to slow down train first!' if speed != 0
    raise 'Nothing to remove!' if @wagons.count.zero?

    @wagons.delete(wagon)
  end
end
