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

require 'debugger'
def rps_tournament_winner(tournament)	
		begin
			match_level = (tournament.size == 2) && tournament.first.first.is_a?(String) && tournament[-1].first.is_a?(String)
		rescue
			match_level = false
		end

		#debugger
		if match_level
			tournament = rps_game_winner(tournament)
		else 
			tournament.each_with_index do |level, i|
				while !level.first.is_a? String
					 level = rps_tournament_winner(level)
				end
				tournament[i] = level
			end
		end
end

def sort_str(str)
	str.chars.sort { |a, b| a.casecmp(b) } .join
end

def combine_anagrams(words)
	annagram_out=[]
	words.each do |compare1|
		curr_arr=[compare1]
		compare1 = sort_str(compare1)

		words.each do |compare2|
			  next if compare2.eql?(curr_arr.first)	
				if compare1.downcase.eql?(sort_str(compare2).downcase)
					
					puts compare1.downcase + " " + sort_str(compare2).downcase + "\n\n"
					curr_arr << compare2
				end
		end
		annagram_out << curr_arr unless annagram_out.flatten.include? curr_arr.first
	end
	puts annagram_out.to_s
end
