$:.unshift File.expand_path('../lib', __FILE__)

TYPES = %w(ST RD AV AVE WY WAY CT PL)
DIRS = %w(N S E W SE SW)

class Address < Hash

  attr_accessor :number, :name, :suffix, :type, :direction, :flag
  def initialize(addr_string)
    list = addr_string.upcase.split(' ')
    if DIRS.include?(list[1])
      if list[2] =~ /\d{1,3}[a-z]{2}/i
        self[:number] = list.shift.to_i
        self[:dir] = list.shift
        self[:name] = list[0][0...(/\D/ =~ list[0])]
        self[:suffix] = list[0][(/\D/ =~ list.shift)..-1]
        self[:type] = list.shift
      elsif TYPES.include?(list[-1])
        self[:number] = list.shift.to_i
        self[:dir] = list.shift
        self[:name] = (list.slice!(0...-1)).join(' ')
        self[:type] = list.shift
      else
        self[:address] = list
        self[:flag] = true
      end
    elsif list[1] =~ /\d{1,3}[a-z]{2}/i
      self[:number] = list.shift.to_i
      self[:name] = list[0][0...(/\D/ =~ list[0])]
      self[:suffix] = list[0][(/\D/ =~ list.shift)..-1]
      self[:type] = list.shift
      self[:dir] = list.shift
    elsif DIRS.include?(list[-1])
      if TYPES.include?(list[-2])
        self[:number] = list.shift.to_i
        self[:name] = (list.slice!(0...-2)).join(' ')
        self[:type] = (list.slice!(-2))
        self[:dir] = (list.slice!(-1))
      else
        self[:address] = list[0..-1]
        self[:flag] = true
      end
    else
      self[:address] = list
      self[:flag] = true
    end

    self[:flag] = true if self.has_value?(nil)

  @number = self[:number]
  @name = self[:name]
  @suffix = self[:suffix]
  @type = self[:type]
  @direction = self[:direction]
  @flag = self[:flag]
  @direction = self[:dir]
  end

  def view
    temp = self
    temp.delete(:flag)
    temp.values.join(' ')
  end

  def layout
    self.keys
  end

  def remove!(var)
    remove_instance_variable(var)
    var2 = var.to_s.delete('@')
    var2 = var2.to_sym
    self.delete(var2)
  end

  def add_suffix
    if self[:name] =~ /^\d+$/
      if self[:name][-1] == '1'
        if self[:name][-2..-1] == '11'
          suffix = 'TH'
        else
          suffix = 'ST'

        end
      elsif self[:name][-1] == '2'
        if self[:name][-2..-1] == '12'
          suffix = 'TH'
        else
          suffix = 'ND'
        end
      elsif self[:name][-1] == '3'
        if self[:name][-2..-1] == '13'
          suffix = 'TH'
        else
          suffix = 'RD'
        end
      else
        suffix = 'TH'
      end
    end
    new_hash = {}
    map = self.each_pair do |key,value|
      new_hash[key] = value
      if (key == :name) && (suffix)
        new_hash[:suffix] = suffix
      end
    end
    new_hash
  end

end

class AddressList

  attr_reader :addresses, :address_list, :converted

  def initialize(input_file)
    @address_list = IO.read(input_file).split("\n")
    @addresses = @address_list.map do |item|
      Address.new(item)
    end
  end

  def convert!(action)
    if action == 'no suffix'
      @converted = @addresses.map do |item|
        item.remove!(:@suffix)
        item
       end
    end
    if action == 'add suffix'
      @converted = @addresses.map do |item|
        item.add_suffix
      end
    end
    @converted
  end

  def print_valid
    @addresses.map do |item|
      item unless item.has_key?(:flag)
    end
  end

  def print_flagged
    @addresses.map do |item|
      item if item.has_key?(:flag)
    end
  end

end