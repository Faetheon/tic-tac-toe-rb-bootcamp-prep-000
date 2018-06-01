# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  return board.join.gsub(/\s+/, "").length
end

def current_player(board)
  if turn_count(board) % 2 === 0
    return "X"
  else
    return "O"
  end
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def valid_move?(board, pos)
  if board[pos] === " " && pos >= 0
    return true
  else
    return false
  end
end

def move(board, index, x)
  board[index.to_i] = x
end

def turn(board)
  user_input = gets.strip.to_i
  user_input = input_to_index(user_input)
  
  if valid_move?(board, user_input)
    move(board, user_input, current_player)
    display_board(board)
  else
    turn
  end
end

def play(board)
  turn(board) until over?(board) || draw?(board)
    if draw?(board)
      puts "Cat's Game!"
    elsif won?(board)
      puts "Congratulations #{winner}!"
    end
end

def won?(board)
  WIN_COMBINATIONS.each { |win|
    letter = ""
    win.each { |pos|
      letter += board[pos]
    }
    temp = letter[0]
    if temp != " "
      wins = true
      letter.split("").each { |l|
        if l != temp
          wins = false
        end
        if wins === false
          break
        end
      }
    end
    if wins
      return win
    end
  }
  empty = true
  board.each { |pos|
    if pos != " "
      empty = false
    end
  }
  if empty === true
    return false
  end
end

def full?(board)
  if draw?(board)
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board).is_a?(Array)
    if draw?(board)
      return true
    elsif board[won?(board)[0]] === "X" || board[won?(board)[0]] === "O"
      return true
    else
      return false
    end
  elsif draw?(board) === true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != nil
    if board[won?(board)[0]] === "X"
      return "X"
    elsif board[won?(board)[0]] === "O"
      return "O"
    else
      return nil
    end
  end
end