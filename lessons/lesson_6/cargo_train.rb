class CargoTrain < Train

  def initialize(number, type = TYPE["freight train"])
    super(number, type)
  end

  def add_wagon(wagon)
    raise "Not cargo wagon. Please add only cargo wagon to cargo train!" unless wagon.is_a?(CargoWagon)
    super(wagon)
  end

  def remove_wagon(wagon)
    raise "Not cargo wagon. Please remove only cargo wagon to cargo train!" unless wagon.is_a?(CargoWagon)
    super(wagon)
  end

end
