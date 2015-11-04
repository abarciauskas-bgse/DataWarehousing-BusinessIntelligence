create table dairy (
  PoS int(11),
  Sku int(11),
  Family varchar(25),
  Date datetime,
  Month int(11),
  Year int(11),
  Flavour varchar(25),
  SellOut int(11)
);

load data infile '~/Downloads/HW\ W4\ FDP_Sales.csv' into table dairy
  fields terminated by ";"
  enclosed by '"'
  lines terminated by "\n"
  ignore 1 lines;
