# Log Parser

## Smart Pension Coding Challenge 

### About

Log parser is a simple tool for extracting statistics from logs which are formatted in this way:

    /help_page/1 126.318.035.038
    /contact 184.123.665.067
    /home 184.123.665.067
    /about/2 444.701.448.104
    /help_page/1 929.398.951.889
    ...
    
    
### Running

Make sure you have execute permissions for `bin/parse_logs`:

```Bash
chmod 0755 bin/parse_logs
```

install dependencies by running:

```Bash
bundle install
```

and finally run:

```Bash
bin/parse_logs logs/webserver.log
```

### Examples

```Bash
bin/parse_logs logs/webserver.log
```

### Testing

Log Parser is tested under RSpec:

```Bash
bundle exec rspec
```

Coverage report is generated into `coverage` folder.

    
