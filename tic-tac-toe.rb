
# ==================================
#             Setup
# ==================================

# Player Object
class Player
    # Each player will have a name, marker (X or O), and history of marker locations
    attr_accessor :name, :marker, :marker_history

    # At initalization, create personal array of marker history
    def initialize
        self.marker_history = []
    end


    # Make a master history to ensure that know one places marker over another player's
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
end  #End of show_board



# Example Coordinates for instruction section
def exampleCoordinates
    $board[0][0] = 'X'
    $board[1][1] = 'O'
    $board[2][2] = 'X'
end  #End of exampleCoordinates



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
end  #End of clearBoard



# Place marker
def placeMarker(location, marker)

    # Split given string into an array
    coordinate = location.split('')

    # Seperate latitude and longitude
    latitude = coordinate[0]
    longitude = coordinate[1]

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

end  #End of placeMarker



# Ensure proper coordinate format
def tested_coordinates
    # Rescue break
    # Return formatted coordinates (into place marker)
end



# Steps for each player's turn
def take_a_turn

    # Steps

    #Check for end_game
    if end_game?
        # Function for closing game
    end
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
        true
    else
        false
    end
end  #End of full_board?



# Determine if the same marker has been placed in a game winning row (horizontal, vertical, or diagonal)
def three_in_a_row?(marker_history)

    # If any of the checks are true, return true
    if check_latitudes(marker_history) || check_longitudes(marker_history) || check_lat_long(marker_history) || check_special_diag(marker_history)
        return true
    # Otherwise, false
    else
        return false
    end

end  #End of three_in_a_row?

        # ------------------------------------------------
        #     Support three_in_a_row?
        #     Due to lack of nesting method ability
        # ------------------------------------------------
         # Check for win by latitude
            def check_latitudes(marker_history)
                all_A = marker_history.select { |coordinate| coordinate[0] == 'A' }
                all_B = marker_history.select { |coordinate| coordinate[0] == 'B' }
                all_C = marker_history.select { |coordinate| coordinate[0] == 'C' }

                if all_A.length == 3 || all_B.length == 3 || all_C.length == 3
                    true
                else
                    false
                end
            end

            # Check for win by longitude
            def check_longitudes(marker_history)
                all_1 = marker_history.select { |arr| arr[1] == '1' }
                all_2 = marker_history.select { |arr| arr[1] == '2' }
                all_3 = marker_history.select { |arr| arr[1] == '3' }

                if all_1.length == 3 || all_2.length == 3 || all_3.length == 3
                    true
                else
                    false
                end
            end

            # Check for win by same latitude and longitude
            def check_lat_long(marker_history)
                if marker_history.include?('A1') && marker_history.include?('B2') && marker_history.include?('C3')
                    true
                else
                    false
                end
            end

            # Check for win by special diagonal
            def check_special_diag(marker_history)
                if marker_history.include?('A3') && marker_history.include?('B2') && marker_history.include?('C1')
                    true
                else
                    false
                end
            end
            # ------------------------------------------------
            #     End of support three_in_a_row?
            # ------------------------------------------------



# Determine if game should end
def end_game?
    # Check If the board is full or a player has won
    if full_board? || three_in_a_row?
        true
    else
        false
    end

end  #End of end_game?



# Close the game
def close_game

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

# Only two options, so when player 1 marker is chosen, player 2 is set
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
p1.marker_history << location
showBoard
puts "\n#{p1.name} placed their marker at #{location}"

puts "\nNext turn"

puts "\n#{p2.name}, please type in the coordinates for where you want to place your marker"
# TEST INPUT
location = gets.chomp
placeMarker(location, p2.marker)
p2.marker_history << location
showBoard
puts "\n#{p2.name} placed their marker at #{location}"




# ==================================
#             Game
# ==================================

# A list of each function after I refactor the above parts in setup, currently runs procedurely

puts "All done"
