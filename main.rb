COLOR_CODE = %w[R G B Y O P] # 0-R, 1-G, 2-B , 3-Y, 4-O, 5-P # rubocop:disable Style/MutableConstant
NUMBER_OF_TURNS = 12

require_relative "lib/human_player"
require_relative "lib/computer_player"
require_relative "lib/game"

require "pry-byebug"

puts "Do you want to play or let the computer play this game of Master Mind ?"
puts "Type [Y] if you want to break the secret code and [N] if you want to set it !"
def player_wants_to_play
  loop do
    player_wants_to_play = gets.chomp

    return player_wants_to_play if %w[Y N].include?(player_wants_to_play)

    puts "Please type [Y] or [N]"
  end
end

if player_wants_to_play == "Y"
  Game.new(HumanPlayer, ComputerPlayer).play
else
  Game.new(ComputerPlayer, HumanPlayer).play
end
