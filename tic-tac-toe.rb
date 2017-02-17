
# ==================================
#             Setup
# ==================================

# Player Object
class Player
    # Each player will have a name and marker (X or O)
    attr_accessor :name, :marker
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
    $board[1][1] = 'O'
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
def placeMarker(location, marker)

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
    $board[longitude][latitude] = marker

end


# Determine if game should end
def end_game?
    # if full_board? || something
    #     return true

end

# Determine if board is full
def full_board?
    full_row = []

    # Check each row
    $board.each do |arr|
        # Check if all items in row are full
        full_row << arr.all? { |spot| spot != ' '}
    end

    # If each row is full, the function returns true
    if full_row.all?
        return true
    else
        return false
    end
end


# Determine if the same marker has been placed in a game winning row (horizontal, vertical, or diagonal)
def three_in_a_row?

end





# ----------------------------------
#             Welcome
# ----------------------------------


# ----------------------------------
#      Establish Player Names
# ----------------------------------
puts "What is the name for player 1?"
player_name = gets.chomp
# TEST INPUT
p1 = Player.new
p1.name = player_name

puts "\nPlayer 1 is now #{p1.name}"


puts "\nWhat is the name for player 2?"
player_name = gets.chomp
# TEST INPUT
p2 = Player.new
p2.name = player_name
puts "\nPlayer 2 is now #{p2.name}"


# ----------------------------------
#        Choose Marker
# ----------------------------------
puts "\nChoose the marker (Type X or O) for #{p1.name}"
marker = gets.chomp
# TEST INPUT
p1.marker = marker.upcase

# Only two options, so when the first one is chosen, that sets the second one
if p1.marker == 'X'
    p2.marker = 'O'
else
    p2.marker = 'X'
end

puts "#{p1.name}'s marker is #{p1.marker}, and so #{p2.name}'s marker is #{p2.marker} \n"


# -------------------------------
#          Instructions
# ------------------------------
puts "\n\nHere is an empty board"
showBoard

puts "\nYou place your marker using coordinates"
puts "For example, 'A1' refers to the top left spot, 'B2' refers to the centermost spot, and 'C3' refers to the bottom right spot"
exampleCoordinates
showBoard




# --------------------------
#       Begin Game
# --------------------------
puts "\n\nAlright, let's start!"
clearBoard
showBoard

# --------------------------
#        Gameplay
# --------------------------

# unless end_game



puts "\n#{p1.name}, please type in the coordinates for where you want to place your marker"
location = gets.chomp
# TEST INPUT
placeMarker(location, p1.marker)
showBoard
puts "\n#{p1.name} placed their marker at #{location}"

puts "\nNext turn"

puts "\n#{p2.name}, please type in the coordinates for where you want to place your marker"
# TEST INPUT
location = gets.chomp
placeMarker(location, p2.marker)
showBoard
puts "\n#{p2.name} placed their marker at #{location}"




# ==================================
#             Game
# ==================================

# A list of each function after I refactor the above parts in setup, currently runs procedurely

puts "All done"
