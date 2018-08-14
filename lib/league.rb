require 'byebug'
class League
  attr_accessor :games, :result, :teams
  def initialize(options = {})
    @teams = []
    @games = []
    @games = options[:games] if options[:games]
    process_games
  end
  def add_team(name)
    @teams << {name: name, pts: 0}
  end
  def process_games
    @result = ''

    #setup scoreboard
    @games.each do |g|
      team1_data = g[0].split(' ')
      team2_data = g[1].split(' ')
      if team1_data.count > 2
        team1_data = team1_data.reverse.drop(1).reverse
        team1_name = team1_data.join(' ')
      else
        team1_name = team1_data.first
      end
      if team2_data.count > 2
        team2_data = team2_data.reverse.drop(1).reverse
        team2_name = team2_data.join(' ')
      else
        team2_name = team2_data.first
      end

      add_team team1_name
      add_team team2_name
    end
    @teams.uniq!
    #score games
    @games.each do |g|
      team1_data = g[0].split(' ')
      team2_data = g[1].split(' ')
      score1 = team1_data.last.to_i
      score2 = team2_data.last.to_i
      if team1_data.count > 2
        team1_data = team1_data.reverse.drop(1).reverse
        team1_name = team1_data.join(' ')
      else
        team1_name = team1_data.first
      end
      if team2_data.count > 2
        team2_data = team2_data.reverse.drop(1).reverse
        team2_name = team2_data.join(' ')
      else
        team2_name = team2_data.first
      end
      #process draw
      if score1 == score2
        t1 = @teams.find { |t| t[:name] == team1_name }
        t1[:pts] += 1
        t2 = @teams.find { |t| t[:name] == team2_name }
        t2[:pts] += 1
      elsif score1 > score2
        t1 = @teams.find { |t| t[:name] == team1_name }
        t1[:pts] += 3
      elsif score2 > score1
        t2 = @teams.find { |t| t[:name] == team2_name }
        t2[:pts] += 3

      end
    end
    @teams = @teams.sort_by { |k| k[:pts] }.reverse
  end
  def result
    fresh_result = []
    @grouped_teams = @teams.group_by {|x| x[:pts]}
    @grouped_teams.each_with_index do |teams,index|
      sorted_teams = teams[1].sort_by{|t| t[:name]}
      row_num = (index + 1).to_s + '. '
      sorted_teams.each do |t|
        pt_or_pts = t[:pts] == 1 ? 'pt' : 'pts'
        fresh_result << row_num + t[:name] + ', ' + t[:pts].to_s + ' ' + pt_or_pts + '
'
      end
    end
    @result = fresh_result.join('')
    @result
  end
end
