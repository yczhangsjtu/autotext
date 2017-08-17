#!/usr/bin/ruby

class Field
	def initialize(name,actions)
		@name = name
		@actions = actions
	end

	def actions
		@actions
	end

	def toString
		s = "#{@name}: "
		@actions.each do |action|
			s += action.toString
			s += ", "
		end
	end
end

class Action
	def initialize(field,name,func)
		@field = field
		@name = name
		@func = func
	end

	def func
		@func
	end

	def toString
		@name
	end
end

class AutoText
	@@fieldAliases = {
		"l" => "latex",
		"la" => "latex",
		"lat" => "latex",
		"late" => "latex",
		"latex" => "latex",
		"ltx" => "latex",
	}
	def initialize()
	end

	def self.latexTable(input)
		output = ""
		lines = input.split "\n"
		tokens = []
		i = 0
		max = 0
		lines.each do |line|
			tokens[i] = line.split ","
			if tokens[i].length > max
				max = tokens[i].length
			end
			i += 1
		end
		if max == 0
			return ""
		end
		output += "\\begin{table}\n"
		output += "  \\begin{tabular}{#{"c"*max}}\n"
		tokens.each do |row|
			output += "    "
			0.upto(max-1) do |i|
				if i < row.length
					output += row[i]
				end
				if i < max-1
					output += " & "
				end
			end
			output += "\\\\\n"
		end
		output += "  \\end{tabular}\n"
		output += "\\end{table}\n"
	end

	@@fields = {
		"latex" => Field.new("latex",{
			"table" => Action.new("latex","table",method(:latexTable))
		})
	}

	def self.getFunc(argv)
		if argv.length >= 1
			field = @@fields[@@fieldAliases[argv[0]]]
			if field == nil
				return nil
			end
		end
		if argv.length >= 2
			action = field.actions[argv[1]]
			if action == nil
				return nil
			end
			return action.func
		end
	end
end

f = AutoText::getFunc(ARGV)
input = ""
while line = STDIN.gets
	input += line
end
puts f.call(input)
