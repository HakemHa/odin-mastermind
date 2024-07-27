require_relative 'player'

class ComputerPlayer < Player
  def initialize()
    super
    @space = []
    self.generate(0, [])
  end


  def generate(i, comb)
    if i == 4
      @space.append(comb)
      return
    end
    for col in @inputs
      self.generate(i+1, comb+[col])
    end
    return
  end

  def randGuess(out = true)
    i = 0 + (@space.length*rand()).to_i
    if out
      guess = @space[i].join(',')
      prettyGuess = ""
      for word in guess.split(',')
        prettyGuess += Player.color(word) +','
      end
      prettyGuess = prettyGuess[0, prettyGuess.length-1]
      puts("Guess: #{prettyGuess}")
    end
    ans = @space[i].map {|c| c[0]}
    return ans
  end

  def update(state)
    guess,ans = state
    newSpace = []
    for comb in @space
      if tryGuess(guess, comb) == ans
        newSpace.append(comb)
      end
    end
    @space = newSpace
    return
  end

  def tryGuess(guess, comb)
    hGuess = Hash.new(0)
    hComb = Hash.new(0)
    white = 0
    black = 0
    for i in 0...4
      hGuess[guess[i]] += 1
      hComb[comb[i]] += 1
      if guess[i] == comb[i]
        white += 1
      end
    end
    black -= white
    for col in @inputs
      black += [hGuess[col], hComb[col]].min
    end
    return [white, black]
  end
end
