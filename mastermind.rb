require_relative 'grid'

class Game 
  def initialize()
    @mode = false
  end

  def menu()
    input = ""
    while !["1", "2", "3", "play", "instructions", "tutorial", "turn", "on", "off"].include?(input)
      print("Welcome to Mastermind! What would you like to do?", "\n")
      print("\n")
      print("1-Play", "\n")
      print("2-Instructions", "\n")
      print("3-Turn #{@mode ? "off" : "on"} hint mode", "\n")
      input = gets.chomp.downcase().gsub(/\s+/, "")
      print("\n")
      if input == ""
        exit!
      end
    end
    if ["1", "play"].include?(input)
      self.play()
    end
    if ["2", "instructions", "tutorial"].include?(input)
      puts("Rules of Mastermind")
      self.menu()
    end
    if ["3", "turn", "on", "off"].include?(input)
      if input == "on"
        @mode = true
      elsif input == "off"
        @mode = false
      else
        @mode = !@mode
      end
      self.menu()
    end
  end

  def play()
    input = ""
    while !["1", "guess", "2", "create"].include?(input)
      print("What do you want to do?", "\n")
      print("\n")
      print("1-Guess a combination", "\n")
      print("2-Create a combination", "\n")
      input = gets.chomp.downcase().gsub(/\s+/, "")
      print("\n")
      if input == ""
        exit!
      end
    end
    if ["1", "guess"].include?(input)
      self.humanPlayer()
    else
      self.computerPlayer()
    end
  end

  def computerPlayer()
    grid = Grid.new()
    grid.create(false)
    player = ComputerPlayer.new()
    while !grid.win?
      grid.render()
      player.update(grid.update(player.randGuess()))
      sleep(1)
    end
    grid.render()
    puts("The computer was able to crack your code!")
  end

  def humanPlayer()
    grid = Grid.new()
    grid.create()
    player = Player.new()
    while !grid.win?
      grid.render()
      grid.update(player.guess(@mode))
    end
    grid.render()
    puts("You were able to crack the code successfuly!")
  end
end

game = Game.new()
game.menu()