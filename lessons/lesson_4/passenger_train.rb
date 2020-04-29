class PassengerTrain < Train

  def initialize(number, type = TYPE["passenger train"])
    super(number, type)
  end

  def add_wagon(wagon)
    return puts "Not passenger wagon. Please add only passenger wagon to passenger train!" unless wagon.is_a?(PassengerWagon)
    super(wagon)
  end

  def remove_wagon(wagon)
    return puts "Not passenger wagon. Please remove only passenger wagon to passenger train!" unless wagon.is_a?(PassengerWagon)
    super(wagon)
  end

end
