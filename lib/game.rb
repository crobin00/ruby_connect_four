# frozen_string_literal: true

# Handles game logic
class Game
  def run
    player_input
  end

  def player_input
    loop do
      input = gets.chomp
      return input if check_input(input)

      puts 'Input error!'
    end
  end

  def check_input(input)
    input_int = input.to_i
    return true if input_int >= 1 && input_int <= 7

    false
  end
end
