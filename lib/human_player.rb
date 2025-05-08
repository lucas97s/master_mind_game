#
class HumanPlayer
  attr_reader :choosen_colors

  def initialize(game)
    @choosen_colors = Array.new(4)
    @game = game
  end

  def secret_code
    puts "Your turn to give the secret code !"
    color_selection
  end

  def guess_color
    color_selection
  end

  def color_selection
    loop do
      colors_available = COLOR_CODE.join(" | ")
      puts "Please choose 4 from the available colors #{colors_available} !"
      choosen_colors = gets.chomp
      choosen_colors = choosen_colors.chars
      return @choosen_colors = choosen_colors if choosen_colors.all? do |color|
        COLOR_CODE.include?(color)
      end && choosen_colors.size == 4

      puts "Please choose again, some of the colors are not part of the game ! :()"
    end
  end
end
