require './test/test_helper'

class OsmHoursTest < Minitest::Test
	def setup
  end

  def test_24_7
    parser = OpenHours::Parser.new("24/7")
    assert_equal parser.period, {periods: {rules: [["00:00", "23:59", 7, 7, 7, 7, 7, 7, 7]], dates: "01/01:31/12"}}
  end

  def teardown
  end
end
