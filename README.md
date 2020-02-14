# Webserver Log Parser - Readme

## Installing

  `gem install weblog-parser`

## Usage

wlparser reads a webserver logfile and counts page visits and unique page views.
It uses a command-line interface.

  `wlparser -h`
  `wlparser --help`

Shows a list of options

  `wlparser -f logfile.log`
  `wlparser --file logfile.log`

Reads a log file and display results:

  `wlparser -m 'logfile1.log logfile2.log'`
  `wlparser --multiple_files 'logfile1.log logfile2.log'`

Reads a list of log files in quotes and displays results.  All files give
using -f or -m options will be read and the output combined.

If no files are specified, the default file 'webserver.log' will be read.

  `wlparser -c`
  `wlparser --color`

Displays colored text output.  Colors can be change in Constants.rb.

  `wlparser -C`
  `wlparser --no_color`

Disables colored text output.

  `wlparser -v`
  `wlparser --verbose`

Shows extra information, including all validation warnings.

  `wlparser -q`
  `wlparser --quiet`

Displays minimal information i.e. only important warnings.  Will still write
information to a file if this option is selected.  Disables verbose.

  `wlparser -o`
  `wlparser --output_file info.txt`

Writes output to file.  Default is 'log_info.txt' if no file chosen, although
this will only work if this is the last argument given.

  `wlparser -t`
  `wlparser --timestamp`

Adds a timestamp to the output file.  If an output file is given that already
exists, this is turned on automatically.

  `wlparser -x`
  `wlparser --text`

Sets file output format to text, similar to that displayed (default).

 `wlparser -j`
 `wlparser --json`

Sets file output format to json.

 `wlparser -4`
 `wlparser --ip4_validation`

Validates ip addresses using ip4 format (default).

 `wlparser -6`
 `wlparser --ip6_validation`

Validates ip addresses using ip6 format.

 `wlparser -6`
 `wlparser --ip4ip6_validation`

Validates ip addresses if it matches either ip4 or ip6 format.

 `wlparser -I`
 `wlparser --no_ip_validation`

Does not validate ip addresses, assumes they are all valid.

 `wlparser -p`
 `wlparser --path_validation`

Validates webpage path (default).

 `wlparser -P`
 `wlparser --no_path_validation`

Does not validate webpage path, assumes they are all valid.

 `wlparser -r`
 `wlparser --remove_invalid`

Ignore logs in files if either ip address or path is invalid.

 `wlparser -R`
 `wlparser --warn_invalid`

Warns about logs with invalid ip addresss or path, but still reads them
(default)

  `wlparser -g`
  `wlparser --page_visits`

Displays page visits in results and in text file output (default).

  `wlparser -g`
  `wlparser --page_visits`

Does not display page visits in results or text file output.

  `wlparser -u`
  `wlparser --unique_page_views`

Displays unique page views in results and in text file output (default).

  `wlparser -U`
  `wlparser --no_unique_page_views`

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

## Testing

Tests can be run using:

  `rake test`

Tests have been separated into
* unit tests - test methods in each class
* integration tests - test the whole app
* performance - parses a log file with 10,000 logs and a log with 100 logs
100 times.  Calculates the time taken and logs parsed/second.  The log files
are a mixture of ip4 and ip6 addresses.

## App structure

A class diagram can be found here: https://tinyurl.com/tky2f74
Note that the dependencies to Constants are not shown.

## Executables

* wlparser - Starts the app

### Classes

* Parser - Holds the log information and changes the format
* LogReader - Loads files then reads logs.  Validates logs, ip addresses and paths
* ipValidator - Validates ip addresses
* PathValidator - Validates the path for the webpage
* OptionHandler - Sets the options from the command line arguments given
* Formatter - Formats information for text or display output
* OutputProcessor - Assembles the information for output
* WarningHandler - Handles the warnings found when parsing the logs

### Modules

* LogParser - Calls the methods in order
* Constants - Contains default options and other constants used in the app
* TestData - Contains the data used in the tests
* ColorText - Adds color to text
* Version - Gives the current version number

### Logs

* test_logs contains log files used in testing
