##BEWD Midterm assignment by Mike Salvaris

require_relative 'library/lookup'


## Greets the user
def greet
puts "Hello, and welcome to the World Bank's population database.  Please enter a country that you would like to know the population of"
end

## Runs the Lookup, which brings returns the population number
def run(input)
	country = Population.new(input)
	country.sanitize(input)
	country.get
	puts "The Population of #{input} is #{country.population}"  
	
end

## Gets the input of the country, splits the country name into sentance case so it can be read by the hash in Lookup.rb
greet
input = gets.strip
input = input.split(/(\W)/).map(&:capitalize).join
run(input)