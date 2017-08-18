#!/usr/bin/ruby

require 'csv'

class LatexTable
	def initialize(input)
		lines = input.split "\n"
		@tokens = []
		@columnWidths = []
		CSV.parse(input) do |row|
			@tokens << row
			row.each_with_index do |token,i|
				if token != nil
					token = token.strip
					row[i] = token
					if @columnWidths[i] == nil or @columnWidths[i] < token.length
						@columnWidths[i] = token.length
					end
				end
			end
		end
	end

	def empty?
		return @tokens.empty?
	end

	def width
		return 0 if empty?
		@tokens.last.length
	end

	def height
		@tokens.length
	end

	def columnWidth(i)
		return 0 if i >= @columnWidths.length or i < 0
		@columnWidths[i]
	end

	def get(i,j)
		return "" if i < 0 or i >= height or j < 0 or j >= width
		return "" if @tokens[i][j] == nil
		@tokens[i][j]
	end

	def to_s
		return "" if empty?
		output = "\\begin{table}\n"
		output += "  \\begin{tabular}{#{"c"*width}}\n"
		0.upto(height-1) do |i|
			output += "    "
			0.upto(width-1) do |j|
				token = get(i,j)
				output += token
				output += " "*(columnWidth(j)-token.length)
				if j < width-1
					output += " & "
				end
			end
			output += "\\\\\n"
		end
		output += "  \\end{tabular}\n"
		output += "\\end{table}\n"
	end
end

def latexTable(input)
	LatexTable.new(input).to_s
end
