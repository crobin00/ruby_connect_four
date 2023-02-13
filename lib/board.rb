# frozen_string_literal: true

# Handles board logic
class Board
  attr_reader :board

  def initialize
    @board = Array.new(7) { Array.new(6) }
  end

  def place_piece(piece, col)
    board[col].each_with_index do |row, idx|
      if row.nil?
        board[col][idx] = piece
        break
      end
    end
  end

  def col_full?(col)
    return true unless board[col].last.nil?

    false
  end

  def display
    output = ''
    (0..5).reverse_each do |row|
      7.times do |col|
        output += ' '
        output += 'O' if board[col][row] == 1
        output += 'X' if board[col][row] == 2
        output += ' ' if board[col][row].nil?
        output += ' |'
      end
      output += "\n"
      output += '---------------------------'
      output += "\n"
    end
    output
  end
end
