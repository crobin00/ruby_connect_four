# frozen_string_literal: true

require_relative 'display'
require_relative 'board'

# Handles game logic
class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def run
    player_input
  end

  def place_piece
    puts 'Enter a column number'
    loop do
      input = player_input.to_i

      unless board.col_full?
        board.place_piece('X', input)
        return
      end

      puts 'Column full. Please input another'
    end
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
