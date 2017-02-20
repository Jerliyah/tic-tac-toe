
# ==================================
#          Player Setup
# ==================================

# Player Object
class Player
    # Each player will have a name, marker (X or O), and history of marker locations
    attr_accessor :name, :marker, :marker_history

    # At initalization, create personal array of marker history
    def initialize
        self.marker_history = []
    end
end  #End of Player object


def createPlayerNames
    puts "\n\t\t\t============================="
    puts "\t\t\t Create Player Names"
    puts "\t\t\t============================="

    puts "\nWhat is the name for player 1?"
    player_name = gets.chomp
    # TEST INPUT
    $p1 = Player.new
    $p1.name = player_name

    puts "\nPlayer 1 is now #{$p1.name}"


    puts "\nWhat is the name for player 2?"
    player_name = gets.chomp
    # TEST INPUT
    $p2 = Player.new
    $p2.name = player_name
    puts "\nPlayer 2 is now #{$p2.name}"
end  #End of createPlayerNames


def choosePlayerMarkers
    puts "\n\t\t\t============================="
    puts "\t\tChoose Marker"
    puts "\t\t\t============================="
    puts "\nChoose the marker (Type X or O) for #{$p1.name}"
    marker = gets.chomp
    # TEST INPUT
    $p1.marker = marker.upcase

    # Only two options, so when player 1 marker is chosen, player 2 is set
    if $p1.marker == 'X'
        $p2.marker = 'O'
    else
        $p2.marker = 'X'
    end

    puts "#{$p1.name}'s marker is #{$p1.marker}, and so #{$p2.name}'s marker is #{$p2.marker} \n"
end  #End of choosePlayerMarkers




# ==================================
#            Game Board
# ==================================

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



# ==================================
#             Gameplay
# ==================================

def welcome
    puts "\n\t\t\t============================="
    puts "\t\t\t Welcome to Jerliyah's Tic Tac Toe Game"
    puts "\t\t\t============================="
end  #End of welcome


def instructions
    puts "\n\t\t\t============================="
    puts "\t\t\t Instructions"
    puts "\t\t\t============================="
    puts "\n\nHere is an empty board"
    showBoard

    puts "\nYou place your marker using coordinates"
    puts "For example, 'A1' refers to the top left spot, 'B2' refers to the centermost spot, and 'C3' refers to the bottom right spot"
    exampleCoordinates
    showBoard
end  #End of instructions


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


def beginGame
    puts "\n\t\t\t============================="
    puts "\t\t Game"
    puts "\t\t\t============================="
    puts "\nAlright, let's start!"
    clearBoard
    showBoard
end  #End of beginGame


# Steps for each player's turn
def take_a_turn(player)

    puts "\n#{player.name}, please type in the coordinates for where you want to place your marker"

    location = gets.chomp
    # TEST INPUT
    placeMarker(location, player.marker)
    player.marker_history << location
    showBoard
    puts "\n#{player.name} placed their marker at #{location}"

    between_turns(player)
end  #End of take_a_turn


# What occurs between each turn
def between_turns(player)

    # Check if the game should be ended
    if end_game?(player)
        close_game(player)
    else
        puts "\n\nNext turn"

        # Change the current player
        if player == $p1
            take_a_turn($p2)
        else
            take_a_turn($p1)
        end

    end  #End of if if end_game?
end  #End of between_players


# Close the game
def close_game(player)
    puts "\n\t\t\t============================="
    puts "\t\t\t #{player.name} has won!"
    puts "\t\t\t============================="

    puts "\n Would you like to play again? \n Y/N"
    replay = gets.chomp
    replay.upcase!

    if replay == 'Y'
        welcome
    else
        puts "\n\t\t\t============================="
        puts "\t\t\t Thanks for playing!"
        puts "\t\t\t============================="
    end

end  #End of close_game



# ==================================
#           In-Game Tests
# ==================================

# Ensure proper coordinate format
def tested_coordinates
    # Rescue break
    # Return formatted coordinates (into place marker)
end  #End of test_coordinates


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
def end_game?(player)

    # Check If the board is full or current player has won
    if full_board? || three_in_a_row?(player.marker_history)
        true
    else
        false
    end

end  #End of end_game?









# ----------------------------------
#             Procedure
# ----------------------------------
# Done
welcome

createPlayerNames
choosePlayerMarkers

instructions

beginGame

# Start with p1, the toggle is built into the functions
take_a_turn($p1)
