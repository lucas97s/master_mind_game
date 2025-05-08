# Class wehre the main logic for the games goes.
class Game
  attr_reader :result, :secret_code, :turn

  def initialize(code_breaker, secret_code_setter)
    @code_breaker = code_breaker.new(self)
    @secret_code_setter = secret_code_setter.new(self)
    @result = []
    @secret_code = @secret_code_setter.secret_code
    @turn = 0
  end

  def play
    count = 1
    answer = []
    loop do
      @turn = count
      puts "Round #{count} !"
      puts "Choose 4 colors !"
      @code_breaker.guess_color
      current_guess = @code_breaker.choosen_colors.dup
      @result = feedback_on_player_input(@code_breaker.choosen_colors, @secret_code)
      current_guess.prepend("The guess of round #{count} >>>> ")
      current_guess_with_feedback = current_guess.concat([" | "],
                                                         @result).join("")
      answer = answer.push(current_guess_with_feedback)
      puts "Guesses thus far : "
      puts answer.join("\n")

      base_condition = !@result.nil? && !@result.empty? && @result.size == 4

      count += 1

      if @result.all? { |color| color == "B" } && base_condition
        puts "You have guessed the secret code ! : #{@secret_code}"
        return
      elsif count == NUMBER_OF_TURNS
        puts "You do not have any more turns to guess the secret code ! :  #{@secret_code} "
        return
      end
    end
  end

  def feedback_on_player_input(player, secret_code)
    player_selection = player
    code_setter_selection = secret_code
    number_of_exact_matches = check_exact_match(player_selection, code_setter_selection)
    number_of_any_matches = check_match(player_selection, code_setter_selection)
    difference_between_exact_and_any_matches = number_of_exact_matches - number_of_any_matches
    feedback_on_guesses = []

    return feedback_on_guesses if number_of_any_matches == 0 && number_of_exact_matches == 0

    for instances in 0...number_of_exact_matches do
      feedback_on_guesses.concat(["B"])
    end
    for instances in 0...difference_between_exact_and_any_matches.abs
      feedback_on_guesses.concat(["W"])
    end
    feedback_on_guesses
  end

  def check_exact_match(guesses, secret_code)
    count = 0
    guesses.each_with_index do |guess, index|
      count += 1 if guess == secret_code[index]
    end
    count
  end

  def check_match(guesses, secret_code)
    guess_color_collection = Hash.new(0)
    secret_code_color_collection = Hash.new(0)

    guesses.each { |color| guess_color_collection[color] += 1 }
    secret_code.each { |color| secret_code_color_collection[color] += 1 }
    total_instance = 0

    guess_color_collection.each do |color, count|
      next unless secret_code_color_collection.include?(color)

      compare = [secret_code_color_collection[color], count].min
      total_instance += compare
    end
    total_instance
    # find for minimum comparing between both colors. then that will be the total number later as output as count.
  end
end
