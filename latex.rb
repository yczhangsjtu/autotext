#!/usr/bin/ruby

require 'csv'

def latexTable(input)
	output = ""
	lines = input.split "\n"
	tokens = []
	i = 0
	max = 0
	CSV.parse(input) do |row|
		tokens << row
		if row.length > max
			max = row.length
		end
		i += 1
	end
	if max == 0
		return ""
	end
	columnWidths = []
	tokens.each do |row|
		0.upto(max-1) do |i|
			if row[i] != nil
				row[i] = row[i].strip
				if columnWidths[i] == nil or columnWidths[i] < row[i].length
					columnWidths[i] = row[i].length
				end
			end
		end
	end
	output += "\\begin{table}\n"
	output += "  \\begin{tabular}{#{"c"*max}}\n"
	tokens.each do |row|
		output += "    "
		0.upto(max-1) do |i|
			if row[i] != nil
				output += row[i]
				output += " "*(columnWidths[i]-row[i].length)
			else
				output += " "*columnWidths[i]
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
