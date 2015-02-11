require_relative './player'
require 'pry'



class Pig

  attr_reader :players, :losers
  
  def initialize
    @players   = []
    @max_score = 25
  end

  
  def get_players
    puts "Getting player names. Type q when done."
    loop do
      print "Player #{@players.count + 1}, what is your name? > "
      input = gets.chomp.downcase.capitalize
      if input == "q" || input == ""
        return
      else
        @players.push Player.new(input)
      end
    end
  end

  def play_round
    @players.each do |p|
      puts "\n\nIt is #{p.name}'s turn! You have #{p.score} points. (Press ENTER)"
      gets
      take_turn p
    end
    remove_losing_players!
  end

  def remove_losing_players!
    @losers = []
    if @players.any? { |p| p.score > @max_score }
      max_score = @players.map { |p| p.score }.max
        @players.each do |p|
          if p.score < @max_score
             @losers << p
        end
      end
      @players = @players.select { |p| p.score == max_score }
    end
  end

  def winner
    if @players.length == 1
      @players.first.name
    end
  end

  def losers
    if winner
      @losers
    end
  end

  def take_turn player
    turn_total = 0
    loop do
      roll = rand 1..6
      if roll == 1
        puts "You rolled a 1. No points for you!"
        return
      else
        turn_total += roll
        puts "You rolled a #{roll}. Turn total is #{turn_total}. Again?"
        if gets.chomp.downcase == "n"
          puts "Stopping with #{turn_total} for the turn."
          player.score += turn_total
          return
        end
      end
    end
  end
end