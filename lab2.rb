class HelloWorldClass

	def initialize(name)
		@name = name.capitalize
	end

	def sayHi
		puts "Hello #{@name}!"
	end
end

HelloWorldClass.new("Nick").sayHi

def palindrome?(str)
	str.eql? str.reverse
end

def count_words(string)
	str_arr = string.gsub("\n",'').split(' ')
	count_hash = Hash[str_arr.map{ |w| [w,0] } ]
	count_hash.keys.each{ |key| count_hash[key] = str_arr.count(key) }
	count_hash
end

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(list)
	raise WrongNumberOfPlayersError unless list.size == 2
	strategies = ['R', 'P', 'S']
	list.each{ |l| raise NoSuchStrategyError unless strategies.include?(l[1]) }
	if list.first[1].eql? list[1][1]
		list.first
	else
		case list.first[1]
		when 'R'
			if list[1][1].eql? 'S'
				list.first
			else
				list[1]
			end
		when 'S'
			if list[1][1].eql? 'P'
				list.first
			else
				list[1]
			end
		else
			if list[1][1].eql? 'R'
				list.first
			else
				list[1]
			end
		end
	end
end

def rps_tournament_winner(tournament)
	tournament.each_with_index do |level,i|
		begin
			match_level = level.first.first.is_a?(String)
		rescue
			match_level = true 
		end

		if match_level # Recurse if we are just another nested array
			tournament = rps_game_winner(level)
		elsif level.size > 1 # Case for nested arrays
			tournament = rps_tournament_winner(level)
	  else
			
		end
  end
end

a = [
    [
		        [ ["Armando", "P"], ["Dave", "S"] ],
						        [ ["Richard", "R"],  ["Michael", "S"] ],
										    ],
												    [
														        [ ["Allen", "S"], ["Omer", "P"] ],
																		        [ ["David E.", "R"], ["Richard X.", "P"] ]
																						    ]
																								]

puts rps_tournament_winner(a)
