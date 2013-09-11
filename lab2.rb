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
	puts tournament	+ "\n\n\n\n\n\n\n\n\n\n\n"	
	tournament.each do |level|
		if level.first.first.is_a? Array # Base case for a match
	  	level = rps_tournament_winner(level)
	  elsif level.first.size == 1
			level = [level.first]
		else
			level = rps_game_winner(level)
		end
	end
	
	if tournament.size < 2
		tournament.first
	else
		rps_tournament_winner(tournament).first
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
