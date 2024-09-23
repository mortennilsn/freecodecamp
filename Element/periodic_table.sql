ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE(symbol);
ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE(name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;

ALTER TABLE properties ADD CONSTRAINT fk_atomic_number FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);

CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR NOT NULL
);

INSERT INTO types(type) VALUES ('metal'), ('metalloid'), ('nonmetal');

ALTER TABLE properties ADD COLUMN type_id INT;

UPDATE properties
SET type_id = (SELECT type_id FROM types WHERE types.type = properties.type);

ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;

ALTER TABLE properties DROP COLUMN type;

ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM atomic_mass::TEXT)::DECIMAL;

UPDATE elements SET symbol = INITCAP(symbol);

DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;

INSERT INTO elements (atomic_number, name, symbol) VALUES (9, 'Fluorine', 'F'), (10, 'Neon', 'Ne');

INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (9, 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type = 'nonmetal')),
       (10, 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));
