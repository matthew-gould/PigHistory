require './db/setup'
require './lib/leaderboard'
require_relative './pig'
require_relative './hog'


def select_from hash
  loop do
    hash.each do |k,v|
      puts "#{k}) #{v}"
    end
    print "? "
    input = gets.chomp
    found = hash.find { |k,v| k.to_s == input || v.to_s == input }
    if found
      return found.last
    else
      puts "Invalid selection: #{input}. Please try again."
    end
  end
end

game_classes = {
  1 => Pig,
  2 => Hog
}
game_class = select_from game_classes

puts "Playing a game of #{game_class}"
game = game_class.new
game.get_players


game.players.each do |x|
  past = Leaderboard.where(name: x.name).first
    if past 
    else
      past = Leaderboard.create(name: x.name, wins: 0, losses: 0)
    end
  end

game.play_round until game.winner
past = Leaderboard.where(name: game.winner).first
if game.winner
 past.wins += 1
 past.save!
 puts "#{game.winner} wins!"
 puts "#{game.winner} your lifetime record is #{past.wins} wins and #{past.losses} losses!"
end
game.losers.each do |x|
  past = Leaderboard.where(name: x.name).first
  past.losses += 1
  past.save!
 end

