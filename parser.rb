#!/usr/bin/env ruby

DEFAULT_FILE = 'webserver.log'
PATTERN = '(\/\w+)(\/?\d*)\s([\d.]+)'

class Parser

    attr_accessor :page_records

    def initialize()
      @page_records = {};
      @page_records.default = 0;
    end

    def load_file(file = DEFAULT_FILE)
      File.open(file,'r').each { |line| add_log(line) }
      self
    end

    def add_log(page_log)
      lg = page_log.split(' ')
      page_records[[lg[1], lg[0]]] += 1
    end

    def validate_ip4_address(ip_address)
      number = '([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
      pattern = '^'  + ([number] * 4).join('[.]') + '$'
      !!ip_address.match(pattern)
    end

    def list_page_views
      page_records.sort_by{|k, v| [-v, k[0], k[1]] }
                  .each{|record, count| puts output_page_counts(record[0], record[1], count)}
    end

    def output_page_counts(ip_address, page, views)
      "#{ip_address} #{page} - #{views} view#{views == 1 ? '' : 's'}"
    end

    def output_unique_page_counts(ip_address, page, unique_page, views)
      "#{ip_address} #{page}#{unique_page} - #{views} view#{views == 1 ? '' : 's'}"
    end

end

parser = Parser.new
parser.load_file
parser.list_page_views
