require_relative 'computer_player'

class Grid 
  def initialize()
    @sol = []
    @board = []
    @helper = ComputerPlayer.new()
  end

  def create(auto = true)
    if auto
      @sol = @helper.randGuess(false)
    else
      @sol = @helper.guess()
    end
  end

  def render()
    translate = {
      "r" => Rainbow("•").red,
      "g" => Rainbow("•").green,
      "b" => Rainbow("•").blue,
      "y" => Rainbow("•").yellow,
      "o" => Rainbow("•").orange,
      "p" => Rainbow("•").pink
    }

    dots = ['⚪', '⚫']

    for guess, pins in @board
      prettyGuess = ""
      for g in guess
        prettyGuess += translate[g] + " "
      end
      prettyScore = dots[0]*pins[0] + dots[1]*pins[1]
      print("Guess: #{prettyGuess}; Got: #{prettyScore}")
      print("\n")
    end
    print("\n")
  end

  def update(guess)
    ans = @helper.tryGuess(guess, @sol)
    @board.append([guess, ans])
    return [guess, ans]
  end

  def win?()
    if @board.length > 0 && @board[@board.length-1][1] == [4, 0]
      return true
    end
    return false
  end
end
