#!/usr/bin/ruby

require_relative 'latex'

class Field
	attr_reader :actions
	def initialize(name,actions)
		@name = name
		@actions = actions
	end

	def to_s
		s = "#{@name}: "
		@actions.each do |action|
			s += action.to_s
			s += ", "
		end
	end
end

class Action
	attr_reader :func, :name
	def initialize(field,name,func)
		@field = field
		@name = name
		@func = func
	end
end

class AutoText
	def initialize(argv)
		@fieldAliases = {
			"l" => "latex",
			"la" => "latex",
			"lat" => "latex",
			"late" => "latex",
			"latex" => "latex",
			"ltx" => "latex",
		}
		@fields = {
			"latex" => Field.new("latex",{
				"table" => Action.new("latex","table",method(:latexTable))
			})
		}
		if argv.length >= 1
			field = @fields[@fieldAliases[argv[0]]]
		end
		if field == nil
			abort "No field provided"
		end
		if argv.length >= 2
			action = field.actions[argv[1]]
		end
		if action == nil
			abort "No action provided"
		end
		@func = action.func
	end

	def process(input)
		@func.call(input)
	end
end

autotext = AutoText.new ARGV

input = ""
while line = STDIN.gets
	input += line
end
puts autotext.process(input)
