require 'rainbow'
require 'io/console'

class Player
  
  def initialize()
    @inputs = ['r', 'b', 'g', 'y', 'p', 'o', 'red', 'blue', 'green', 'yellow', "pink", 'orange']
    
  end

  def self.color(str)
    if str == 'r' || str == 'red'
      return Rainbow(str).red
    end
    if str == 'b' || str == 'blue'
      return Rainbow(str).blue
    end
    if str == 'g' || str == 'green'
      return Rainbow(str).green
    end
    if str == 'y' || str == 'yellow'
      return Rainbow(str).yellow
    end
    if str == 'p' || str == 'pink'
      return Rainbow(str).pink
    end
    if str == 'o' || str == 'orange'
      return Rainbow(str).orange
    end
    return str
  end

  def guess(example = [])
    if example.length == 0
      idxs = []
      4.times do
        idxs.append(0+(@inputs.length*rand()).to_i)
      end
      example = idxs.map {|i| @inputs[i]}
    end
    prettyExample = ""
    for exp in example
      prettyExample += Player.color(exp) + ","
    end
    prettyExample = prettyExample[0, prettyExample.length-1]
    puts("Take a guess! (i.e #{prettyExample})")
    print("Guess: ")
    pins = get_input()
    while !valid(pins)
      puts("Invalid guess :( Guess must be of form #{Player.color('r')},#{Player.color('b')},#{Player.color('g')},#{Player.color('y')} or #{Player.color('red')}, #{Player.color('blue')}, #{Player.color('green')}, #{Player.color('yellow')}")
      print("Guess: ")
      pins = get_input()
    end
    pins = pins.gsub("/\s+/", "").downcase().split(',')
    pins = pins.map {|p| p[0]}
    return pins
  end
end

def valid(pins)
  pins = pins.gsub(/\s+/, "").downcase()
  pins = pins.split(",")
  if pins.length != 4
    return false
  end
  for pin in pins
    if !(@inputs.include?(pin))
      return false
    end
  end
  return true
end

def get_input()
  c = STDIN.getch
  ans = c
  while c.ord != 13
    if c.ord == 3
      exit!
    end
    prettyAns = ""
    for word in ans.split(',')
      prettyAns += Player.color(word) +','
    end
    if ans[ans.length-1] != ','
      prettyAns = prettyAns[0, prettyAns.length-1]
    end
    print("\r".ljust(80),"\r", "Guess: #{prettyAns}")
    c = STDIN.getch
    if (c.ord >= 'a'.ord && c.ord <= 'z'.ord) || (c.ord >= 'A'.ord && c.ord <= 'Z'.ord) || (c.ord == ",".ord)
      ans += c
    elsif c.ord == 127 && ans.length > 0
      ans = ans[0, ans.length-1]
    end
  end
  print("\n")
  return ans
end