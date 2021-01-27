require_relative "../modules/result_format"
require "test/unit"

class TestResultFormatModule < Test::Unit::TestCase
  # Should return a result with a format	
  def test_can_print_result_format
  	query_result_mock = [['Nirvana', 'In Utero', 1993, 'vinyl', 2, '96ac63e21f83562a178ef83202fc8ed', '01b5864bfe29e95f95bbdfda3932b8e']]
  	result = ResultFormat.result_format(data: query_result_mock)
  	format_result = ["Artist: Nirvana", "Album: In Utero", "Released: 1993", "vinyl(2): 96ac63e21f83562a178ef83202fc8ed", "\n"]

  	assert_equal(result, format_result)
  end	
end
