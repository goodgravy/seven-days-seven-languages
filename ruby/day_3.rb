# Modify the CSV application to support an each method to return a CsvRow object. Use method_missing on that CsvRow to return the value for the column for a given heading.

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ' )
      file.each do |row|
        @csv_contents << row.chomp.split(', ' )
      end
    end

    def each
      @csv_contents.map do |row|
        csv_row = CsvRow.new(@headers, row)
        yield csv_row if block_given?
        csv_row
      end
    end
  end
end

class CsvRow
  attr_accessor :headers, :values

  def initialize(headers, values)
    @headers = headers
    @values = values
  end

  def inspect
    [headers, values].map { |things| things.join(', ') }.join("\n")
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
puts m.each { |row| puts row.inspect }
