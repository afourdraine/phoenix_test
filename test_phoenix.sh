#!/bin/bash

# define usage function
usage(){
	echo "Usage: $0 JAVA_HOME"
	echo "./test_phoenix.sh /user/jdk64/jdk1.8.0_112/"
	echo "do not include the /bin/java in the path as Phoenix alreadu populate it"
	exit 1
}

# invoke  usage
# call usage() function if JAVA_HOME not supplied
[[ $# -eq 0 ]] && usage

#export the JAVA_HOME
JAVA_PATH=$1
export JAVA_HOME=$JAVA_PATH

# file used to create the phoenix table with the psql.py script
cat <<EOF >us_population.sql
CREATE TABLE IF NOT EXISTS us_population (
      state CHAR(2) NOT NULL,
      city VARCHAR NOT NULL,
      population BIGINT
      CONSTRAINT my_pk PRIMARY KEY (state, city));
EOF

# file used to populate the phoenix table with the psql.py script
cat <<EOF >us_population.csv
NY,New York,8143197
CA,Los Angeles,3844829
IL,Chicago,2842518
TX,Houston,2016582
PA,Philadelphia,1463281
AZ,Phoenix,1461575
TX,San Antonio,1256509
CA,San Diego,1255540
TX,Dallas,1213825
CA,San Jose,912332
EOF

# file used to query the phoenix table with the psql.py script
cat <<EOF >us_population_queries.sql
SELECT state as "State",count(city) as "City Count",sum(population) as "Population Sum"
FROM us_population
GROUP BY state
ORDER BY sum(population) DESC;
EOF

# file use to delete hbase table with the hbase shell
cat <<EOF >us_population_drop_table.txt
disable 'US_POPULATION'
drop 'US_POPULATION'
exit
EOF

# use the previously created file to run phoenix with the psql.py script
/usr/hdp/current/phoenix-client/bin/psql.py us_population.sql us_population.csv us_population_queries.sql

# use hbase shell with the previously created file
hbase shell ./us_population_drop_table.txt

# remove all created file
rm us_population.sql
rm us_population.csv
rm us_population_queries.sql
rm us_population_drop_table.txt