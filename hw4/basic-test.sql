DELIMITER $$
CREATE PROCEDURE define_increment (INOUT base INT(4), IN increment INT(4))
  BEGIN
    SET base = base + increment;
END$$
DELIMITER ;