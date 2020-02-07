#!/usr/bin/env ruby
DEFAULT_FILE = './LogParser/webserver.log'
#require '../lib/LogParser/log_reader'

class Parser

    attr_accessor :page_views, :unique_page_views, :warnings

    def initialize(file: DEFAULT_FILE)
      @page_views = {}
      @unique_page_views = {}
      self.count_views(LogReader.new(file: file).page_views)
      #@warnings = log_record[:warnings]
      self
    end

    def count_views(logs)
      logs.each{ |page, ip_addresses|
        @page_views[page] = ip_addresses.length
        @unique_page_views[page] = ip_addresses.uniq.length
      }
    end

    def list_page_views
      page_views.sort_by{|page, views| [-views, page] }
                .map{|page, views| output_page_views(page, views)}
    end

    def list_unique_page_views
      unique_page_views.sort_by{|page, views| [-views, page] }
                       .map{|page, views| output_page_views(page, views)}
    end

    def output_page_views(page, views)
      "#{page} - #{views} visit#{views == 1 ? '' : 's'}"
    end

    def output_unique_page_views(page, views)
      "#{page} - #{views} unique view#{views == 1 ? '' : 's'}"
    end

end
