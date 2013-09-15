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
