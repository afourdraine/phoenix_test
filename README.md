# phoenix_test

Based on : https://phoenix.apache.org/Phoenix-in-15-minutes-or-less.html

The script is just an automated version of the webpage.

What the script do :

* Create a table with phoenix
* Insert data into the table
* Query the the table (count, sum, desc)
* Delete the created table in HBase

## Getting Started

Download the repository or clone it :

```
git clone https://github.com/afourdraine/phoenix_test.git
```

Make the python script executable :

```
chmod +x test_phoenix.sh
```

Desired output :
```
Time: 1.294 sec(s)

csv columns from database.
CSV Upsert complete. 10 rows upserted
Time: 0.102 sec(s)

St                               City Count                           Population Sum
-- ---------------------------------------- ----------------------------------------
NY                                        1                                  8143197
CA                                        3                                  6012701
TX                                        3                                  4486916
IL                                        1                                  2842518
PA                                        1                                  1463281
AZ                                        1                                  1461575
Time: 0.069 sec(s)

0 row(s) in 2.5640 seconds

0 row(s) in 0.8230 seconds
```

