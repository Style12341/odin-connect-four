# spec/connect-four_spec.rb
require './lib/connect_four'

describe ConnectFour do
  describe '#initialize' do
    it 'creates a new ConnectFour object' do
      game = ConnectFour.new
      expect(game).to be_an_instance_of(ConnectFour)
    end
    it 'initializes the board with a 6x7 grid' do
      game = ConnectFour.new
      expect(game.board).to be_an_instance_of(ConnectFourBoard)
    end
    it 'starts with player X' do
      game = ConnectFour.new
      expect(game.current_player).to eql('X')
    end
  end
  describe '#switch_player' do
    it 'switches the player X to O' do
      game = ConnectFour.new
      game.switch_player
      expect(game.current_player).to eql('O')
    end
    it 'switches the player O to X' do
      game = ConnectFour.new
      game.switch_player
      game.switch_player
      expect(game.current_player).to eql('X')
    end
  end
end
describe ConnectFourBoard do
  describe '#initialize' do
    it 'creates a new ConnectFourBoard object' do
      board = ConnectFourBoard.new
      expect(board).to be_an_instance_of(ConnectFourBoard)
    end
  end
  describe '#place_piece' do
    board = ConnectFourBoard.new
    it 'places a piece on the board' do
      board.place_piece(0, 'X')
      expect(board.board[0][0]).to eql('X')
    end
    it 'places a piece on top of the other piece' do
      board.place_piece(0, 'O')
      expect(board.board[0][1]).to eql('O') and expect(board.board[0][0]).to eql('X')
    end
    it 'warns player if column is full' do
      board.place_piece(0, 'X')
      board.place_piece(0, 'O')
      board.place_piece(0, 'X')
      board.place_piece(0, 'O')
      board.place_piece(0, 'X')
      board.place_piece(0, 'O')
      expect(board.place_piece(0, 'X')).to eql(false)
    end
    it 'returns true if piece is placed' do
      expect(board.place_piece(1, 'X')).to eql(true)
    end
    it 'returns false if piece is placed in invalid position' do
      expect(board.place_piece(7, 'X')).to eql(false)
    end
  end
  describe '#check_winner' do
    it 'returns true if there are four in a row' do
      board = ConnectFourBoard.new
      board.board[0][0] = 'X'
      board.board[1][0] = 'X'
      board.board[2][0] = 'X'
      board.board[3][0] = 'X'
      expect(board.check_winner('X')).to eql(true)
    end
    it 'returns false if there are not four in a row' do
      board = ConnectFourBoard.new
      board.board[0][0] = 'X'
      board.board[1][0] = 'X'
      board.board[2][0] = 'X'
      board.board[3][0] = 'O'
      expect(board.check_winner('X')).to eql(false)
    end
    it 'returns true if there are four in a column' do
      board = ConnectFourBoard.new
      board.board[0][0] = 'X'
      board.board[0][1] = 'X'
      board.board[0][2] = 'X'
      board.board[0][3] = 'X'
      expect(board.check_winner('X')).to eql(true)
    end
    it 'returns true if there are four in a diagonal' do
      board = ConnectFourBoard.new
      board.board[0][0] = 'X'
      board.board[1][1] = 'X'
      board.board[2][2] = 'X'
      board.board[3][3] = 'X'
      expect(board.check_winner('X')).to eql(true)
    end
    it 'returns true if there are four in another diagonal' do
      board = ConnectFourBoard.new
      board.board[0][3] = 'X'
      board.board[1][2] = 'X'
      board.board[2][1] = 'X'
      board.board[3][0] = 'X'
      expect(board.check_winner('X')).to eql(true)
    end
    it 'returns false if there are not four in a diagonal' do
      board = ConnectFourBoard.new
      board.board[0][0] = 'X'
      board.board[1][1] = 'X'
      board.board[2][2] = 'X'
      board.board[3][3] = 'O'
      expect(board.check_winner('X')).to eql(false)
    end
  end
end
