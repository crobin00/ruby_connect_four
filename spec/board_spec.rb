# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  describe '#place_piece' do
    context 'when column has six empty spaces' do
      subject(:empty_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      it 'places piece at bottom of col' do
        col = 1
        empty_board.place_piece(player_piece.piece, col)
        board = empty_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [1, nil, nil, nil, nil, nil]
        expect(board_col).to eq(expected_row)
      end
    end

    context 'when column has 3 empty spaces' do
      subject(:half_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, nil, nil, nil]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'places piece in middle of col' do
        col = 1
        half_board.place_piece(player_piece.piece, col)
        board = half_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [1, 2, 1, 1, nil, nil]
        expect(board_col).to eq(expected_row)
      end
    end

    context 'when column has no empty spaces' do
      subject(:half_board) { described_class.new }

      let(:player_piece) { instance_double(Player, piece: 1) }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, 1, 2, 1]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'does not place piece' do
        col = 1
        half_board.place_piece(player_piece.piece, col)
        board = half_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [1, 2, 1, 1, 2, 1]
        expect(board_col).to eq(expected_row)
      end
    end
  end

  describe '#col_full?' do
    context 'when col is full' do
      subject(:full_board) { described_class.new }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, 1, 2, 1]
        full_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        col = 1
        return_value = full_board.col_full?(col)
        expect(return_value).to be(true)
      end
    end

    context 'when col is not full' do
      subject(:half_board) { described_class.new }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [1, 2, 1, 1, nil, nil]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'returns true' do
        col = 1
        return_value = half_board.col_full?(col)
        expect(return_value).to be(false)
      end
    end
  end
end
