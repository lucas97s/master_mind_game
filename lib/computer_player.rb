# This creates the logic and attributes related to Computer.
# Lets use R-Red , G-Green, B-Blue, Y-Yellow, O-Orange, P-Pink
# COLOR_CODE = [R, G, B, Y, O, P] # 0-R, 1-G, 2-B , 3-Y, 4-O, 5-P
class ComputerPlayer
  attr_reader :choosen_colors

  def initialize(game)
    @game = game
    @combinations = set_of_all_possibilities
    @choosen_colors = %w[R R P P]
  end

  def secret_code
    secret_code = Array.new(4)
    secret_code.each_index { |index| secret_code[index] = rand(0..5) }
    secret_code.map { |number| COLOR_CODE[number] }
  end

  def guess_color
    return @choosen_colors if @game.turn == 1

    @combinations = remove_not_exact_match(@combinations, @choosen_colors, @game.result)
    random_index = rand(0...@combinations.length)
    @choosen_colors = change_number_to_color(@combinations[random_index])
    # the alogrithm goes here !
  end

  def remove_not_exact_match(combinations, guess, result)
    count = 0
    combinations.select do |combination|
      output = @game.feedback_on_player_input(guess, change_number_to_color(combination))
      next unless output == result

      count += 1
      puts "prints the count #{count} and result #{output} vs #{result} "
      combination
    end
  end

  def change_number_to_color(array)
    array.map { |number| COLOR_CODE[number] }
  end

  def set_of_all_possibilities
    collection = []
    for first_number in 0..5 do
      for second_number in 0..5 do
        for third_number in 0..5 do
          for fourth_number in 0..5 do
            collection.push([first_number, second_number, third_number, fourth_number])
          end
        end
      end
    end
    collection.uniq!
    collection
  end
end
