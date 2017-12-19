class EplTables::Teams
  attr_accessor :name, :position, :games_played, :games_won, :games_drawn, :games_lost, :goals_for, :goals_against, :goal_differential, :points
  @@all = []

  # Return a list of all the teams ordered by position
  def self.list
    self.scrape_teams unless self.all.length > 0
    self.all
  end

  def self.all
    @@all
  end

  # Scrape premierleague.com for attributes
  def self.scrape_teams
    doc = Nokogiri::HTML(open("https://www.premierleague.com/tables"))

    teams = doc.search('tbody tr[data-compseason="79"]')
    team_array = []
    teams.each {|team| team_array << team}
    team_array.each do |team|
      new_team = self.new
      new_team.position = team.css("span.value").text
      new_team.name = team.css("td.team span.long").text
      new_team.points = team.css("td.points").text
      new_team.games_played = team.css("td")[3].text
      new_team.games_won = team.css("td")[4].text
      new_team.games_drawn = team.css("td")[5].text
      new_team.games_lost = team.css("td")[6].text
      new_team.goals_for = team.css("td")[7].text
      new_team.goals_against = team.css("td")[8].text
      new_team.goal_differential = team.css("td")[9].text.strip
      self.all << new_team
      new_team
    end
  end
end
