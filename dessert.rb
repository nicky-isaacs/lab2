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
				if !defined @#{attr_name}_history
					@#{attr_name}_history = [@#{attr_name}]
				end
				@#{attr_name} = value
				@#{attr_name}_history << val
			end
		"
	end
end

class Foo
	attr_accessor_with_history :bar
end

class Fixnum
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
  def method_missing(method_id)
	  singular = singular_currency(method_id)
	  if @@currencies.has_key?(singular)
	    self * @@currencies[singular]
	  else
	    super
	  end
  end

	def in(to_curr)
		singular = singular_currency(to_curr)

	end

	private

	def singular_currency(currency)
		currency.to_s.gsub( /s$/, '' )
	end
end

class CartesianProduct

  include Enumerable

	def initialize(input_a, input_b)
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
