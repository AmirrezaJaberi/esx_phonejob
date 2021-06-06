INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_phoner', 'Phoner', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_phoner', 'Phoner', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_phoner', 'Phoner', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('phoner', 'Phone Reseller')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('phoner', 1,'boss','Shop Keeper', 30000,'{}','{}')
;

INSERT INTO `items` (name, label) VALUES
  ('mobile_glass', 'Glass Mobile'),
  ('mobile_cover', 'Cover Mobile')
;
