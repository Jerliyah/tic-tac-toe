
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


def create_player_names
    puts "\n"
    puts "\t\t\t============================="
    puts "\t\t\t     Create Player Names"
    puts "\t\t\t============================="

    puts "\nWhat is the name for player 1?"
    player_name = gets.chomp
    player_name = tested_input(player_name, 'create_player_names')
    $p1 = Player.new
    $p1.name = player_name
    puts "\nPlayer 1 is now #{$p1.name}"

    puts "\nWhat is the name for player 2?"
    player_name = gets.chomp
    player_name = tested_input(player_name, 'create_player_names')
    $p2 = Player.new
    $p2.name = player_name
    puts "\nPlayer 2 is now #{$p2.name}"
end  #End of create_player_names


def choose_player_markers
    puts "\n"
    puts "\t\t\t============================="
    puts "\t\t\t        Choose Marker"
    puts "\t\t\t============================="
    puts "\nChoose the marker (Type X or O) for #{$p1.name}"

    marker = gets.chomp
    marker = tested_input(marker, 'choose_player_marks')
    $p1.marker = marker.upcase

    # Only two options, so when player 1 marker is chosen, player 2 is set
    if $p1.marker == 'X'
        $p2.marker = 'O'
    else
        $p2.marker = 'X'
    end

    puts "#{$p1.name}'s marker is #{$p1.marker}, and so #{$p2.name}'s marker is #{$p2.marker} \n"
end  #End of choose_player_markers




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
def show_board
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
def clear_board
    # For each row in board....
    $board.each do |arr|
        # For each item in the current row...
        for i in 0...arr.length
            # set it equal to an empty string
            arr[i] = ' '
        end
    end
end  #End of clear_board



# ==================================
#             Gameplay
# ==================================

def welcome
    puts "\n"
    puts "\t\t\t============================="
    puts "\t\t    Welcome to Jerliyah's Tic Tac Toe Game"
    puts "\t\t\t============================="
end  #End of welcome


def instructions
    puts "\n"
    puts "\t\t\t============================="
    puts "\t\t\t        Instructions"
    puts "\t\t\t============================="
    puts "\n\nHere is an empty board"
    show_board

    puts "\nYou place your marker using coordinates"
    puts "For example, 'A1' refers to the top left spot, 'B2' refers to the centermost spot, and 'C3' refers to the bottom right spot"
    exampleCoordinates
    show_board
end  #End of instructions


def place_marker(location, marker)

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

end  #End of place_marker


def beginGame
    puts "\n"
    puts "\t\t\t============================="
    puts "\t\t\t             Game"
    puts "\t\t\t============================="
    puts "\nAlright, let's start!"
    clear_board
    show_board
end  #End of beginGame


# Steps for each player's turn
def take_a_turn(player)

    puts "\n#{player.name}, please type in the coordinates for where you want to place your marker"

    location = gets.chomp
    location = tested_input(location, 'take_a_turn')
    place_marker(location, player.marker)

    player.marker_history << location

    show_board
    puts "\n#{player.name} placed their marker at #{location}"

    between_turns(player)
end  #End of take_a_turn


# What occurs between each turn
def between_turns(player)

    # Check if the game should be ended
    if end_game?(player) == "full_board"
        close_game(player, "full_board")

    elsif end_game?(player) == "three_in_a_row"
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
def close_game(player, circumstance=nil)

    if circumstance
        puts "\n"
        puts "\t\t\t============================="
        puts "\t\t\t         It's a tie!"
        puts "\t\t\t============================="
    else
        puts "\n"
        puts "\t\t\t============================="
        puts "\t\t\t      #{player.name} has won!"
        puts "\t\t\t============================="
    end

    puts "\n Would you like to play again? \n Y/N"
    replay = gets.chomp
    replay = tested_input(replay, 'close_game')

    if replay == 'Y'
        welcome
    else
        puts "\n"
        puts "\t\t\t============================="
        puts "\t\t\t     Thanks for playing!"
        puts "\t\t\t============================="
    end

end  #End of close_game



# ==================================
#           In-Game Tests
# ==================================

# Ensure proper coordinate format
def tested_input(input, section)

    case section
    when 'create_player_names'

        if input.length > 20
            puts "Sorry, your name can't be more than 20 characters"
            redo_input(input)
        else
            input
        end


    when 'choose_player_marks'
        input.upcase!

        if input == 'X' || input == 'O'
            input
        else
            puts "\nThat's not a valid marker. Please type the letter X or O"
            redo_input(input,section)
        end


    when 'take_a_turn'
        arr = input.split("")

        arr[0].upcase!

        if arr.length == 2  &&  'ABC'.include?(arr[0])  &&  '123'.include?(arr[1])
            input
        else
            puts "\nThat's not a valid coordinate. Please type the letter corresponding to column, followed by the number corresponding to row. For example, A3"
            redo_input(input,section)
        end


    when 'close_game'
        input.upcase

        if input == 'Y' || input == 'N'
            input
        else
            puts "\nThat's not a valid answer. Please type the letter y or n"
            redo_input(input,section)
        end

    end  #End of case

end  #End of test_coordinates
        # ------------------------------------------------
        #     test_coordinates support
        #     Due to lack of nesting method ability
        # ------------------------------------------------
            def redo_input(input,section)
                input = gets.chomp
                tested_input(input,section)
            end
        # ------------------------------------------------
        #     End of test_coordinates support
        # ------------------------------------------------


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
        #     three_in_a_row? support
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
            #     End of three_in_a_row? support
            # ------------------------------------------------



# Determine if game should end
def end_game?(player)

    # Check If the board is full or current player has won
    if three_in_a_row?(player.marker_history)
        "three_in_a_row"
    elsif full_board?
        "full_board"
    else
        false
    end

end  #End of end_game?



# ==================================
#             Procedure
# ==================================
def tic_tac_toe
    welcome

    create_player_names
    choose_player_markers

    instructions

    beginGame

    # Start with p1, the toggle is built into the functions
    take_a_turn($p1)

    # End game is determined within functions
end

tic_tac_toe
