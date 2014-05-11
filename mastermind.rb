# Mastermind
require 'debugger'
class Game

  def initialize(turn_limit = 10)
    @turn_limit = turn_limit
    @computer_choice = ([:r,:g,:b,:y,:o,:p]*4).shuffle[0...4]
  end

  def print_intro
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
    p @computer_choice
    while prompt_for_user_choice != @computer_choice && @turn_limit > 0
      provide_game_hints
      @turn_limit -= 1
    end
    if @turn_limit > -1
      puts "Congratulations."
    else
      puts "Sorry, the answer was #{@computer_choice}"
    end
  end

  def provide_game_hints
    #debugger
    exact_matches_count = near_matches_count = 0
    taken = Array.new(4,false)

    non_matched = []

    4.times do |i|
      if @user_choice[i] == @computer_choice[i]
        exact_matches_count += 1
        taken[i] = true
      end
    end

    @user_choice.each_with_index do |user_letter,i|
      if !taken[i]
        @computer_choice.each_with_index do |computer_letter,j|
          if user_letter == computer_letter && !taken[j]
            near_matches_count += 1
            taken[j] = true
          end
        end
      end
    end

    puts "Exact Matches: #{exact_matches_count}, Near Matches: #{near_matches_count}"
  end

end

game = Game.new(10)
game.play

