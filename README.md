Readme for webserver log parser

The webserver log parser needs to parse logs

It should be able to
- read logs from a file
  - read lines one at a time to reduce memory usage
- parse the logs to record how many times each page was visit for:
  - pages
  - unique pages
- the logs should be checked for:
  - valid format
  - valid ip address (IPv4 and IPv6)
  - valid page address
- warnings should be given for invalid logs

helpful if:
- multiple log files can be added and combined either together or in sequence
