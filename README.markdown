# Fed ACH Parser

## Goal
The Federal Reserve maintains a list of financial institutions participating
in the ACH network.  Write code which downloads their list of institutions,
parses out the information, and stores it in a database.  The code only needs
to support downloading and storing all of the entries.  Bonus points for
using Ruby and writing tests.

## Notes
I only parsed 2 fields out of file but let me know if you would like
to see more. I can parse them all if necessary.

## Files
* lib/fedachparser.rb: the class that does all the work
* bin/load_fedach.rb: the test scrip that uses the class
* sql/create_table.sql: the db table used to store the data.
* spec/fedachparser_spec.rb: rspec tests

## Dependencies
### System
* libcurl
* mysql
Tested with ruby 1.9.2

### Gems
* curb
* dbi
* dbd-mysql


