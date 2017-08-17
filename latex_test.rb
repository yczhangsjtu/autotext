require_relative 'latex'
require 'test/unit'

class TestLatexTable < Test::Unit::TestCase
	def testEmptyString
		assert_equal("",latexTable(""))
	end

	def testSingleChar
		assert_equal("\\begin{table}\n  \\begin{tabular}{c}\n    a\\\\\n  \\end{tabular}\n\\end{table}\n",latexTable("a"))
	end
end
