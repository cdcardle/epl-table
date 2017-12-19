# Our CLI Controller
class EplTables::CLI

  def call
    show_table
    table
    goodbye
  end

  def show_table
    puts "English Premier League Table:".blue
    # puts "1. Man City - points"
    # puts "2. Man U - points"
    @teams = EplTables::Teams.list
    @teams.each do |team|
      puts "#{team.position}. ".yellow + "#{team.name}".blue + " - " + "#{team.points} points".red
    end
  end

  def table
    input = nil
    while input != "exit"
      puts "-------------------------------------------------".white
      puts "Enter the position number(1-20) of the team you'd
like to see in depth, type table to show the
table again, or type exit to exit:".cyan
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i < 21
        team = @teams[input.to_i - 1]
        puts "-------------------------------------------------".white
        puts "Team Name:          ".blue + "#{team.name}".light_red
        if team.position[-1] == "1"
          puts "Position:           ".blue + "#{team.position}st place".light_red
        elsif team.position[-1] == "2"
          puts "Position:           ".blue + "#{team.position}nd place".light_red
        elsif team.position[-1] == "3"
          puts "Position:           ".blue + "#{team.position}rd place".light_red
        else
          puts "Position:           ".blue + "#{team.position}th place".light_red
        end
        puts "Games Played:       ".blue + "#{team.games_played}".light_red
        puts "Games Won:          ".blue + "#{team.games_won}".light_red
        puts "Games Drawn:        ".blue + "#{team.games_drawn}".light_red
        puts "Games Lost:         ".blue + "#{team.games_lost}".light_red
        puts "Goals For:          ".blue + "#{team.goals_for}".light_red
        puts "Goals Against:      ".blue + "#{team.goals_against}".light_red
        puts "Goal Differential:  ".blue + "#{team.goal_differential}".light_red
        puts "Points:             ".blue + "#{team.points}".light_red
      elsif input == "table"
        puts "-------------------------------------------------".white
        show_table
      elsif input == "exit"
      else
        puts "-------------------------------------------------".white
        puts "Invalid entry, enter a valid position number, table, or exit.".red
      end
    end
  end

  def goodbye
    puts "Thanks for checking out the standings!".cyan
  end
end
