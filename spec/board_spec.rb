# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#place_piece' do
    context 'when column has six empty spaces' do
      subject(:empty_board) { described_class.new }

      let(:player_piece) { double('player_piece') }

      it 'places piece at bottom of col' do
        allow(player_piece).to receive(:piece).and_return(0)
        col = 1
        empty_board.place_piece(player_piece.piece, col)
        board = empty_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [0, nil, nil, nil, nil, nil]
        expect(board_col).to eq(expected_row)
      end
    end

    context 'when column has 3 empty spaces' do
      subject(:half_board) { described_class.new }

      let(:player_piece) { double('player_piece') }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [0, 1, 0, nil, nil, nil]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'places piece in middle of col' do
        allow(player_piece).to receive(:piece).and_return(0)
        col = 1
        half_board.place_piece(player_piece.piece, col)
        board = half_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [0, 1, 0, 0, nil, nil]
        expect(board_col).to eq(expected_row)
      end
    end

    context 'when column has no empty spaces' do
      subject(:half_board) { described_class.new }

      let(:player_piece) { double('player_piece') }

      before do
        current_board = Array.new(7) { Array.new(6) }
        current_board[1] = [0, 1, 0, 0, 1, 0]
        half_board.instance_variable_set(:@board, current_board)
      end

      it 'does not place piece' do
        allow(player_piece).to receive(:piece).and_return(0)
        col = 1
        half_board.place_piece(player_piece.piece, col)
        board = half_board.instance_variable_get(:@board)
        board_col = board[1]
        expected_row = [0, 1, 0, 0, 1, 0]
        expect(board_col).to eq(expected_row)
      end
    end
  end
end
