require 'test_helper'

class PerformanceTest < Minitest::Test

  def test_parses_a_large_log_file
    begin
      start_time = Time.now
      file = File.join(File.dirname(__FILE__), '../test_logs/large.log')
      parser = Parser.new(log_reader: LogReader.new( options: { file_list:[file], ip_validation: :ip4_ip6 }).load_logs)
      parser.count_views
      output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_visits: true, unique_page_views: true })
      output = output_processor.output_to_display
      assert_match (/Logs read: 10000/), output
      finish_time = Time.now
      time_taken = finish_time.to_f - start_time.to_f
      rate = 10_000 / time_taken
      puts "\nTook %<time>0.3f seconds to parse 10000 logs in 1 file.  %<rate>d logs / second\n" % {time: time_taken, rate: rate}
    rescue
      puts "Error: '/test/test_logs/large.log' not found."
    end
  end

  def test_parses_a_small_file_100_times
    start_time = Time.now
    begin
      100.times do
        file = File.join(File.dirname(__FILE__), '../test_logs/small.log')
        parser = Parser.new(log_reader: LogReader.new( options: { file_list:[file], ip_validation: :ip4_ip6 }).load_logs)
        parser.count_views
        output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_visits: true, unique_page_views: true })
        output = output_processor.output_to_display
        assert_match (/Logs read: 100/), output
      end
      finish_time = Time.now
      time_taken = finish_time.to_f - start_time.to_f
      rate = 10_000 / time_taken
      puts "Took %<time>0.3f seconds to parse 100 logs a 100 times.  %<rate>d logs / second"  % {time: time_taken, rate: rate}
    rescue
      puts "Error: '/test/test_logs/small.log' not found."
    end
  end

end
