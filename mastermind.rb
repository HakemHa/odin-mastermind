require_relative 'grid'

class Game 
  def initialize()
    @hint = false
    @turns = 8
  end

  def menu()
    input = ""
    while !["1", "2", "3", "play", "instructions", "tutorial", "turn", "on", "off", "4", "number"].include?(input)
      print("Welcome to Mastermind! What would you like to do?", "\n")
      print("\n")
      print("1-Play", "\n")
      print("2-Instructions", "\n")
      print("3-Turn #{@hint ? "off" : "on"} hint mode", "\n")
      print("4-Number of turns: #{@turns}", "\n")
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
      puts("Rules of Mastermind:")
      print("The objective of Mastermind is to guess a secret code consisting of a series of 4
colored pegs. Each guess results in feedback narrowing down the possibilities of the
code. \n One player (you or the computer) chooses four colors in a specific oder, the other player tries to decipher that code by sequentialy guessing a possible solution. \n After each guess the player deciphering the code receives black and white pegs:\n\n  -A white pegs means the combination guessed has a correct color in it's correct position. \n\n  -A black peg means the combination guessed has a correct color placed in the incorrect position.\n\n\n")
      self.menu()
    end
    if ["3", "turn", "on", "off"].include?(input)
      if input == "on"
        @hint = true
      elsif input == "off"
        @hint = false
      else
        @hint = !@hint
      end
      self.menu()
    end
    if ["4", "number"].include?(input)
      nturns = get_input()
      while nturns == ""
        nturns = get_input()
      end
      @turns = nturns.to_i
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
    if @hint
      helper = ComputerPlayer.new()
    end
    grid = Grid.new()
    grid.create()
    player = Player.new()
    while !grid.win?
      grid.render()
      if @hint
        helper.update(grid.update(player.guess(helper.randGuess(false))))
      else
        grid.update(player.guess())
      end
    end
    grid.render()
    puts("You were able to crack the code successfuly!")
  end

  def get_input()
    print("\r".ljust(80),"\r", "Number of turns (0 is unlimited turns): ")
    c = STDIN.getch
    if (c.ord >= '0'.ord && c.ord <= '9'.ord)
      ans = c
    else
      ans = ""
    end
    while c.ord != 13
      if c.ord == 3
        exit!
      end
      print("\r".ljust(80),"\r", "Number of turns (0 is unlimited turns): #{ans}")
      c = STDIN.getch
      if (c.ord >= '0'.ord && c.ord <= '9'.ord)
        ans += c
      elsif c.ord == 127 && ans.length > 0
        ans = ans[0, ans.length-1]
      end
    end
    print("\n")
    return ans
  end
end

game = Game.new()
game.menu()