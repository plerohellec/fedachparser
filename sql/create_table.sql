
DROP TABLE IF EXISTS banks;
CREATE TABLE banks (
  id int(11) unsigned not null auto_increment,
  routing_number varchar(10) not null,
  name varchar(37) not null,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
