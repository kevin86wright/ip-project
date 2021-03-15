-- Create primary tables if necessary
CREATE TABLE IF NOT EXISTS ip_project.addresses LIKE ip_project.addresses_tmp;
CREATE TABLE IF NOT EXISTS ip_project.networks LIKE ip_project.networks_tmp;

--  Drop old tables
DROP TABLE IF EXISTS ip_project.addresses_old;
DROP TABLE IF EXISTS ip_project.networks_old;

-- Add table indexes
ALTER TABLE ip_project.addresses_tmp ADD INDEX `address` (`address`);
ALTER TABLE ip_project.networks_tmp ADD INDEX `nw_start` (`nw_start`);
ALTER TABLE ip_project.networks_tmp ADD INDEX `nw_end` (`nw_end`);


-- Perform atomic table swap operation
RENAME TABLE ip_project.addresses TO ip_project.addresses_old, ip_project.addresses_tmp To ip_project.addresses;
RENAME TABLE ip_project.networks TO ip_project.networks_old, ip_project.networks_tmp To ip_project.networks;

--  Drop old tables
DROP TABLE ip_project.addresses_old;
DROP TABLE ip_project.networks_old;

