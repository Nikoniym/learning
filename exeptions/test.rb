class Test
  def initialize(ar)
    @ar=ar
    validate!
    two
  end

  def two
    puts @ar
  end

  def validate!
    raise 'asddfasdf' if @ar == 1

  end
end

class Test2
  def initialize

  @a = []
  end

  def train
    begin
      puts 'puts nuber'
      g=gets.chomp.to_i
      Test.new(g)
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end
end

Test2.new.train

