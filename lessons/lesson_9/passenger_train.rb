# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMB_FORMAT
  validate :type, :speciality, TYPE['passenger train']

  def initialize(number, type = TYPE['passenger train'])
    super(number, type)
  end

  def add_wagon(wagon)
    raise 'Not passenger wagon. Please add only passenger wagon to passenger train!' unless wagon.is_a?(PassengerWagon)

    super(wagon)
  end

  def remove_wagon(wagon)
    raise 'Not passenger wagon. Please remove only passenger wagon to passenger train!' unless wagon.is_a?(PassengerWagon)

    super(wagon)
  end
end
