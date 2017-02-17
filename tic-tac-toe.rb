
# ==================================
#             Setup
# ==================================

# Player Object
class Player
    # Each player will be prompted to give a name
    def initialize(name)
        @name = name
    end

    # Each player will have a marker (X or O)
    attr_accessor :marker
end


# Universal Board (starts empty)
$board = [
            [' ', ' ', ' '],
            [' ', ' ', ' '],
            [' ', ' ', ' ']
        ]


# Show Stylized Board
def showBoard
    row_1 = [' ', 'A', 'B', 'C']
    row_2 = [1] + $board[0]
    row_3 = [2] + $board[1]
    row_4 = [3] + $board[2]

    puts " | #{row_1.join(' | ')} | \n | #{row_2.join(' | ')} | \n | #{row_3.join(' | ')} | \n | #{row_4.join(' | ')} |"
end


# Example Coordinates for instruction section
def exampleCoordinates
    $board[0][0] = 'X'
    $board[1][1] = 'X'
    $board[2][2] = 'X'
end


# Clear Board
def clearBoard
    # For each row in board....
    $board.each do |arr|
        # For each item in the current row...
        for i in 0...arr.length
            # set it equal to an empty string
            arr[i] = ' '
        end
    end
end


# Place marker
def placeMarker(location)

    # Split given string into an array
    coordinates = location.split('')

    # Seperate latitude and longitude
    latitude = coordinates[0]
    longitude = coordinates[1]

    # Convert latitude letter to number
    case latitude
        when 'A' then latitude = 0
        when 'B' then latitude = 1
        when 'C' then latitude = 2
    end

    # Convert longitude number to index number
    case longitude
        when '1' then longitude = 0
        when '2' then longitude = 1
        when '3' then longitude = 2
    end

    # Place marker
    $board[latitude][longitude] = 'X'

end





# ----------------------------------
#             Welcome
# ----------------------------------


# ----------------------------------
#      Establish Player Names
# ----------------------------------
puts "What is the name for player 1?"
p1_name = gets.chomp
# TEST INPUT
p1 = Player.new(p1_name)
puts "\nPlayer 1 is now #{p1_name}"


puts "\nWhat is the name for player 2?"
p2_name = gets.chomp
# TEST INPUT
p2 = Player.new(p2_name)
puts "\nPlayer 2 is now #{p2_name}"


# ----------------------------------
#        Choose Game Piece
# ----------------------------------
puts "\nChoose the game piece (Type X or O) for #{p1_name}"
marker = gets.chomp
# TEST INPUT
p1.marker = marker.upcase

# Only two options, so when the first one is chosen, that sets the second one
if p1.marker == 'X'
    other_marker = 'O'
else
    other_marker = 'X'
end

puts "#{p1_name}'s game piece is #{p1.marker}, and so #{p2_name}'s game piece is #{other_marker} \n"


# -------------------------------
#          Instructions
# ------------------------------
puts "\n\nHere is an empty board"
showBoard

puts "\nYou place your game piece using coordinates"
puts "For example, 'A1' refers to the top left spot, 'B2' refers to the centermost spot, and 'C3' refers to the bottom right spot"
exampleCoordinates
showBoard




# --------------------------
#       Begin Game
# --------------------------
puts "\n\nAlright, let's start!"
clearBoard
showBoard

puts "\n#{p1_name}, please type in the coordinates for where you want to place your game piece"
location = gets.chomp
# TEST INPUT
placeGamePiece(location)
showBoard
puts "\n#{p1_name} placed their game piece at #{location}"

puts "\nNext turn"

puts "\n#{p2_name}, please type in the coordinates for where you want to place your game piece"
# TEST INPUT
location = gets.chomp
placeGamePiece(location)
showBoard
puts "\n#{p2_name} placed their game piece at #{location}"




# ==================================
#             Game
# ==================================

# A list of each function after I refactor the above parts in setup, currently runs procedurely

puts "All done"
