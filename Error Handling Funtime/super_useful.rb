# PHASE 2
def convert_to_int(str)
  Integer(str) 

rescue ArgumentError
  nil
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else 
    raise StandardError.new "yuck..."
  end 
end

def is_coffee?(maybe_coffee)
    if maybe_coffee == "coffee"
    puts "Thanks for the #{maybe_coffee}!"
  else
    raise StandardError.new "Thats not coffee!!!"
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue StandardError => e1
    puts e1
    begin
      puts "Feed me coffee! (Enter coffee:)"
      is_coffee?(gets.chomp)
    rescue StandardError => e2
      puts e2
      retry
    end
    retry
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    begin
      @name = name
      if name.length <= 0
        raise StandardError.new "You surely have a name?"
      end
    rescue StandardError => mustHaveName
      puts mustHaveName
      puts "I can't remember it, please tell me?"
      name = (gets.chomp)
      retry
    end

    begin
      @fav_pastime = fav_pastime
      if fav_pastime.length <= 0
        raise StandardError.new "We have a favorite pastime?"
      end
    rescue StandardError => mustHavePastTime
      puts mustHavePastTime
      puts "I can't remember, what is it again?"
      fav_pastime = (gets.chomp)
      retry
    end


    begin
      @yrs_known = yrs_known
      if yrs_known < 5
        raise StandardError.new "I think your mistaken, we've know each other for a least 5 years"
      end 
    rescue StandardError => atLeast5
      puts atLeast5
      puts "How many years has it been?"
      yrs_known = (gets.chomp).to_i
      retry
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


