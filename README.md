# Webserver Log Parser - Readme

## Installing

  `gem install wslp`

## Usage

LogParser reads a webserver logfile and counts page visits and unique page views.
It uses a command-line interface.

  `wslp -h`
  `wslp --help`

Shows a list of options

  `wslp -f logfile.log`
  `wslp --file logfile.log`

Reads a log file and display results:

  `wslp -m 'logfile1.log logfile2.log'`
  `wslp --multiple_files 'logfile1.log logfile2.log'`

Reads a list of log files in quotes and displays results.  All files give
using -f or -m options will be read and the output combined.

If no files are specified, the default file 'webserver.log' will be read.

  `wslp -c`
  `wslp --color`

Displays colored text output.  Colors can be change in Options.rb.

  `wslp -C`
  `wslp --no_color`

Disables colored text output.

  `wslp -v`
  `wslp --verbose`

Shows extra information, including all validation warnings.

  `wslp -q`
  `wslp --quiet`

Displays minimal information i.e. only important warnings.  Will still write
information to a file if this option is selected.  Disables verbose.

  `wslp -o`
  `wslp --output_file info.txt`

Writes output to file.  Default is 'log_info.txt' if no file chosen, although
this will only work if this is the last argument given.

  `wslp -t`
  `wslp --timestamp`

Adds a timestamp to the output file.  If an output file is given that already
exists, this is turned on automatically.

  `wslp -x`
  `wslp --text`

Sets file output format to text, similar to that displayed (default).

 `wslp -j`
 `wslp --json`

Sets file output format to json.

 `wslp -4`
 `wslp --ip4_validation`

Validates ip addresses using ip4 format (default).

 `wslp -6`
 `wslp --ip6_validation`

Validates ip addresses using ip6 format.

 `wslp -6`
 `wslp --ip4ip6_validation`

Validates ip addresses if it matches either ip4 or ip6 format.

 `wslp -I`
 `wslp --no_ip_validation`

Does not validate ip addresses, assumes they are all valid.

 `wslp -p`
 `wslp --path_validation`

Validates webpage path (default).

 `wslp -P`
 `wslp --no_path_validation`

Does not validate webpage path, assumes they are all valid.

 `wslp -r`
 `wslp --remove_invalid`

Ignore logs in files if either ip address or path is invalid.

 `wslp -R`
 `wslp --warn_invalid`

Warns about logs with invalid ip addresss or path, but still reads them
(default)

  `wslp -g`
  `wslp --page_visits`

Displays page visits in results and in text file output (default).

  `wslp -g`
  `wslp --page_visits`

Does not display page visits in results or text file output.

  `wslp -u`
  `wslp --unique_page_views`

Displays unique page views in results and in text file output (default).

  `wslp -U`
  `wslp --no_unique_page_views`

Displays page visits in results and in text file output (default).

##Log Format

Logs should be on separate lines.
There should be a space separator between the webpage path and the ip address.

Example log with ip4 address:
  `\webpage\index 123.123.123.123`

Logs can use either using ip4 addresses or ip6 addresses.  

ip4 addresses should be valid i.e. between 0.0.0.0 and 255.255.255.255, although
you can skip this check.

Example log with ip6 address:
  `\webpage\index 1234:1234:1234:1234:1234:1234:1234:1234`

ip6 addresses can be compressed e.g.

  `\webpage\index 1234:1234::1234`

# Testing

Tests will run using:

  `rake test`

Tests have been separated into
* unit tests - testing methods in each class
* integration tests - testing the whole app
* performance - testing large log files
