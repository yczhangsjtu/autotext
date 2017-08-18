require_relative 'latex'
require 'test/unit'

class TestLatexTable < Test::Unit::TestCase
	private
	def testFile(inputFile,outputFile)
		input = ""
		output = ""
		f = File.open("test_data/latex/#{inputFile}.txt")
		f.each do |line|
			input += line
		end
		f.close
		f = File.open("test_data/latex/#{outputFile}.txt")
		f.each do |line|
			output += line
		end
		f.close
		assert_equal(output,latexTable(input))
	end

	public
	def testFiles
		testFile("table_input_1","table_output_1")
		testFile("table_input_2","table_output_2")
		testFile("table_input_3","table_output_3")
		testFile("table_input_4","table_output_4")
	end
end
