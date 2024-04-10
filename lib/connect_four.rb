class ConnectFourBoard
  attr_accessor :board

  def initialize
    @board = Array.new(7) { Array.new(6) }
  end

  def place_piece(column, piece)
    return false unless column.between?(0, 6)

    @board[column].each_with_index do |cell, index|
      if cell.nil?
        @board[column][index] = piece
        return true
      end
    end
    false
  end

  def check_winner(piece)
    check_horizontal(piece) || check_vertical(piece) || check_diagonal(piece)
  end

  def check_horizontal(piece)
    @board.each do |column|
      column.each_cons(4) do |four|
        return true if four.all? { |cell| cell == piece }
      end
    end
    false
  end

  def check_vertical(piece)
    @board.transpose.each do |column|
      column.each_cons(4) do |four|
        return true if four.all? { |cell| cell == piece }
      end
    end
    false
  end

  def check_diagonal(piece)
    check_diagonal_right(piece) || check_diagonal_left(piece)
  end

  def check_diagonal_right(piece)
    (0..3).each do |x|
      (0..2).each do |y|
        return true if (0..3).all? { |i| @board[x + i][y + i] == piece }
      end
    end
    false
  end

  def check_diagonal_left(piece)
    (0..3).each do |x|
      (3..5).reverse_each do |y|
        return true if (0..3).all? { |i| @board[x + i][y - i] == piece }
      end
    end
    false
  end

  def display_board
    print ' '
    (0..6).each { |i| print "#{i} " }
    puts
    @board.transpose.reverse.each do |row|
      puts '|' + row.map { |cell| cell.nil? ? ' ' : cell }.join('|') + '|'
    end
  end
end

# Path: lib/connect-four.rb

class ConnectFour
  attr_accessor :board, :current_player

  def initialize
    @board = ConnectFourBoard.new
    @current_player = 'X'
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def play_turn(column)
    if @board.place_piece(column, @current_player)
      switch_player unless @board.check_winner(@current_player)
    else
      puts 'Invalid column, try again.'
    end
  end

  def play
    until @board.check_winner(@current_player)
      @board.display_board
      puts "Player #{@current_player}, select a column (0-6):"
      column = gets.chomp.to_i
      play_turn(column)
    end
    @board.display_board
    puts "Player #{@current_player} wins!"
  end
end

game = ConnectFour.new
game.play
