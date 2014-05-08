# Mastermind
class Game

  def initialize(turn_limit = 10)
    @turn_limit = turn_limit
    @computer_choice = ([:r,:g,:b,:y,:o,:p]*4).shuffle[0...4]
  end

  def print_intro
    #p @computer_choice
    puts "+------------------------------------+"
    puts "|            Mastermind              |"
    puts "+------------------------------------+"
    puts "Mastermind"
    puts "\nYou have #{@turn_limit} guesses to choose the same peg sequence as the master."
    puts "Please choose four pegs from the follow (duplicates allowed)"
    puts "[ r g b y o p ] (e.g. 'rrgy')"
  end

  def prompt_for_user_choice
    puts "\nRemaining turns: #{@turn_limit}"
    print ":> "
    @user_choice = gets.chomp.downcase.squeeze(' ').split('').map(&:to_sym)[0...4]
    puts "Your choice: #{@user_choice}"
    @user_choice
  end

  def play
    print_intro
    while prompt_for_user_choice != @computer_choice && @turn_limit > 0
      provide_game_hints
      @turn_limit -= 1
    end
    if @turn_limit > 0
      puts "Congratulations."
    else
      puts "Sorry, the answer was #{@computer_choice}"
    end
  end

  def provide_game_hints
    exact_matches_count = near_matches_count = 0

    4.times do |index|
      if @user_choice[index] == @computer_choice[index]
        exact_matches_count += 1
      else
        near_matches_count = find_near_matches(index)
      end
    end
    puts "Exact Matches: #{exact_matches_count}, Near Matches: #{near_matches_count}"
  end

  def find_near_matches(index)
    taken = Array.new(4,false)
    count = 0
    @computer_choice.each_with_index do |value,i|
      if value == @user_choice[index] && !taken[i]
        count += 1
        taken[i] = true
      end
    end
    count
  end

end

game = Game.new(10)
game.play

