create extension jdbc_fdw;

CREATE SERVER apache_drill_server FOREIGN DATA WRAPPER jdbc_fdw 
OPTIONS( drivername 'org.apache.drill.jdbc.Driver', url 'jdbc:drill:drillbit=drill',
jarfile '/opt/drill-jdbc-all-1.12.0.jar',
maxheapsize '600'
);

CREATE FOREIGN TABLE students(account text,address text)
server apache_drill_server OPTIONS (query 'SELECT * FROM hbase.students');

CREATE USER MAPPING for postgres SERVER apache_drill_server
OPTIONS(username 'root', password 'root');