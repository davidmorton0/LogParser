DEFAULT_FILE = 'webserver.log'

class Parser
    def parse
      pages = {};
      pages.default = 0;
      lines = File.readlines(DEFAULT_FILE, encoding: "utf-8")
      pattern = '(\/\w+)(\/?\d*)\s([\d.]+)'
      lines.each do |line|
        if match = line.match(pattern)
          pages[[match[1], match[2], match[3]]] += 1 ;
        else

        end
      end
      sorted = pages.sort_by{|k, v| v}.reverse
      sorted.each{|k, v| puts "#{k[2]} #{k[0]}#{k[1]} - #{v} view#{v == 1 ? '' : 's'}"}
    end

end

Parser.new.parse
