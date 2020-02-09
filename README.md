# Webserver Log Parser - Readme

## Installing

  `gem install wslp`

## Usage

Reads a log file and display results:

  `wslp -f logfile.log`

Colored text output.  Colors can be change in Options.rb

  `wslp -c`

LogParser reads a webserver logfile and counts page visits and unique page views.
It uses a command-line interface.

##Log Format
Logs should be in a format using ip4 addresses:
`\webpage\index 123.123.123.123`

ip4 addresses should be valid i.e. between 0.0.0.0 and 255.255.255.255 although
you can skip this check.

or ip6 addresses:
`\webpage\index 1234:1234:1234:1234`

# Testing

All the tests will run using:

  `rake test`

Individual tests can be run using (for example):

  `rake test test/log_parser_test.rb`

# Performance

The webserver log parser needs to parse logs

It should be able to
+ read logs from a file
  + read lines one at a time to reduce memory usage
+ parse the logs to record how many times each page was visit for:
  + pages
  + unique pages
- the logs should be checked for:
  + valid format
  +- valid ip address (IPv4 and IPv6)
  - valid page address
+ warnings should be given for invalid logs

helpful if:
- multiple log files can be added and combined either together or in sequence
- save to file (default based on timestamp)
