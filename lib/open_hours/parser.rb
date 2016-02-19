module OpenHours
  class Parser
    attr_reader :period, :initial_data

    def initialize(data)
      @initial_data = data
      format = recognize_syntax(@initial_data)
      @period = parse(@initial_data, format)
    end

    def parse(string_to_parse, format = :undefined)
      self.send(format, string_to_parse) unless format == :undefined
    end

    protected

    def recognize_syntax(data_string)
      case
      when data_string.match(/24\/7/)
        :full
      when data_string.match(/(\A|;)(Mo|Tu|We|Th|Fr|Sa|Su)-(Mo|Tu|We|Th|Fr|Sa|Su)( |)\d{1,2}:\d{1,2}-\d{1,2}:\d{1,2}(\A|;)/)
        :single_rule
      end
    end

    def full(string)
      output = ["00:00", "23:59", 7, 7, 7, 7, 7, 7, 7]
      format_output(output)
    end

    def format_output(input, dates = "01/01:31/12")
      {periods: {rules: [input], dates: dates}
    end

    def day_str_to_num(str)
      case str
      when "Su"
        0
      when "Mo"
        1
      when "Tu"
        2
      when "We"
        3
      when "Th"
        4
      when "Fr"
        5
      when "Sa"
        6
      end
    end
  end
end
