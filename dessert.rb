class Dessert

	attr_accessor :calories, :name

	def initialize(name, calories)
		@calories = calories
		@name = name
	end

	def healthy?
		calories < 200
	end

	def delicious?
		true
	end

end

class JelleyBean < Dessert
	
	attr_accessor :flavor
	
	def initalize(name, calories, flavor)
		@name = name
		@calories = calories
		@flavor = flavor
	end

	def delicious?
		!flavor.downcalse.eql? "black licorice"
	end

end

class Class
	def attr_accessor_with_history(attr_name)
		attr_name = attr_name.to_s
		attr_reader attr_name
		attr_reader attr_name + "_history"
		class_eval %Q"
	 	  def #{attr_name}=(val)
				if !defined? @#{attr_name}_history
					@#{attr_name}_history = [@#{attr_name}]
				end
				@#{attr_name} = val
				@#{attr_name}_history << val
			end
		"
	end
end

class Foo
	attr_accessor_with_history :bar
	
	def initialize

	end
end

f = Foo.new
f.bar = 1
f.bar = 2
puts f.bar_history

class String
	def palindrome?; self == self.reverse; end
end

module Enumerable
	def palindrome?;self.reverse == self;end
end

a = [2,3,4,5]
b = [1,1,1,1]

unless a.palindrome?
	puts "#{a} is not a palindrome"
end

if b.palindrome?
	puts "#{b} is a palindrome"
end

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.0}
  def method_missing(method_id)
	  singular = singular_currency(method_id)
	  if @@currencies.has_key?(singular)
	    self * @@currencies[singular]
	  else
	    super
	  end
  end

	def in(to_curr)i
		singular = singular_currency(to_curr)
		self * @@currencies[to_curr.to_s]
	end

	private

	def singular_currency(currency)
		currency.to_s.gsub( /s$/, '' )
	end
end

puts "500 yen in euros is #{500.yen.in(:euro)}"

class CartesianProduct

  include Enumerable

	def initialize(input_a, input_b)
		return if input_b.empty? || input_a.empty?
		@elements=[]
		input_a.each do |a|
		  input_b.each do |b|
				@elements << [a,b]
			end
		end
	end
	
	def each(&block)
		@elements.each{ |a| block.call(a) }
	end
end
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
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

def bracket_winner(array)
	local = array.dup
	local.each_with_index do |arr, i|
	  begin
		  local[i] = rps_game_winner(arr)
    rescue
	    local[i] = bracket_winner(arr)
	  end
	end
	rps_game_winner local
end

require 'debugger'
def rps_tournament_winner(tournament)
	winners=[]
	tournament.each_with_index do |bracket, i|
		winners << bracket_winner(bracket)
	end
	rps_game_winner winners
end

#[
#  [
#   [ [one, thing],[two, stuff] ],
#		[
#     [ [three, four], [five, six] ],
#     [ [seve, eight], [nice, ten] ]
#		]
#  ],
#  [
#   [guy, thing],[other, stuff]
#  ],
#]

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
