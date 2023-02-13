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
    board.each do |row|
      row.each do |space|
        output += ' '
        output += 'O' if space == 1
        output += 'X' if space == 2
        output += ' ' if space.nil?
        output += ' |'
      end
      output += "\n"
      output += '---------------------------'
      output += "\n"
    end
    output
  end
end
