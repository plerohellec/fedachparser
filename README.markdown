# Fed ACH Parser

## Goal
The Federal Reserve maintains a list of financial institutions participating
in the ACH network.  Write code which downloads their list of institutions,
parses out the information, and stores it in a database.  The code only needs
to support downloading and storing all of the entries.  Bonus points for
using Ruby and writing tests.

## Files
* lib/fedachparser.rb: the class that does all the work
* bin/load_fedach.rb: the test scrip that uses the class
* sql/create_table.sql: the db table used to store the data.

## Dependencies
### System
* libcurl
* mysql
Tested with ruby 1.9.2

### Gems
* curb
* dbi
* dbd-mysql


