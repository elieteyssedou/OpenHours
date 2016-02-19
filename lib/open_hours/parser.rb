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
      if /24\/7/.match(data_string)
        return :full
      end
    end

    def full(string)
      output = ["00:00", "23:59", 7, 7, 7, 7, 7, 7, 7]
      format_output(output)
    end

    def format_output(input)
      {periods: {rules: [input], dates: "01/01:31/12"}}
    end
  end
end
