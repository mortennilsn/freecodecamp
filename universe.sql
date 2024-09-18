CREATE DATABASE universe;

\c universe

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    distance_from_earth NUMERIC(10, 2),
    galaxy_type VARCHAR(50),
    is_spiral BOOLEAN NOT NULL,
    number_of_stars INT NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id) ON DELETE CASCADE,
    is_main_sequence BOOLEAN NOT NULL,
    mass INT NOT NULL,
    luminosity NUMERIC(10, 2)
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    star_id INT REFERENCES star(star_id) ON DELETE CASCADE,
    has_life BOOLEAN NOT NULL,
    diameter INT NOT NULL,
    distance_from_star NUMERIC(10, 2)
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    planet_id INT REFERENCES planet(planet_id) ON DELETE CASCADE,
    orbital_period NUMERIC(10, 2),
    is_habitable BOOLEAN NOT NULL,
    description TEXT
);

CREATE TABLE satellite (
    satellite_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    moon_id INT REFERENCES moon(moon_id) ON DELETE CASCADE,
    launch_year INT NOT NULL,
    operational BOOLEAN NOT NULL
);

INSERT INTO galaxy (name, distance_from_earth, galaxy_type, is_spiral, number_of_stars)
VALUES
('Milky Way', 0, 'Spiral', TRUE, 100000),
('Andromeda', 2.5, 'Spiral', TRUE, 1000000),
('Triangulum', 3.0, 'Spiral', TRUE, 40000),
('Whirlpool', 23.16, 'Spiral', TRUE, 30000),
('Sombrero', 29.3, 'Elliptical', FALSE, 20000),
('Black Eye', 17, 'Lenticular', FALSE, 5000);

INSERT INTO star (name, galaxy_id, is_main_sequence, mass, luminosity)
VALUES
('Sun', 1, TRUE, 1, 1),
('Proxima Centauri', 2, TRUE, 0.12, 0.0017),
('Vega', 1, TRUE, 2.1, 40),
('Betelgeuse', 1, FALSE, 20, 126000),
('Sirius', 1, TRUE, 2.02, 25.4),
('Rigel', 1, FALSE, 17, 50000);

INSERT INTO planet (name, star_id, has_life, diameter, distance_from_star)
VALUES
('Earth', 1, TRUE, 12742, 149.6),
('Mars', 1, FALSE, 6779, 227.9),
('Venus', 1, FALSE, 12104, 108.2),
('Jupiter', 1, FALSE, 139820, 778.3),
('Proxima b', 2, UNKNOWN, 12000, 0.05),
('Vega b', 3, FALSE, 15000, 300),
('Betelgeuse I', 4, FALSE, 20000, 400),
('Betelgeuse II', 4, FALSE, 25000, 600),
('Sirius b', 5, FALSE, 10000, 800),
('Rigel b', 6, FALSE, 22000, 550),
('Rigel c', 6, FALSE, 23000, 700),
('Juno', 1, FALSE, 3200, 750);

INSERT INTO moon (name, planet_id, orbital_period, is_habitable, description)
VALUES
('Nix', 1, 24.86, FALSE, 'A small moon of Pluto, discovered in 2005.'),
('Hydra', 1, 25.38, FALSE, 'Another small moon of Pluto, discovered in 2005.'),
('Charon', 1, 6.39, FALSE, 'The largest moon of Pluto, discovered in 1978.'),
('Triton', 2, 5.88, FALSE, 'The largest moon of Neptune, known for its retrograde orbit.'),
('Proteus', 2, 1.12, FALSE, 'A moon of Neptune, discovered in 1989 by the Voyager 2 spacecraft.'),
('Miranda', 2, 1.41, FALSE, 'A moon of Uranus, known for its extreme surface features.'),
('Ariel', 2, 2.52, FALSE, 'A moon of Uranus, discovered in 1851 by William Lassell.'),
('Umbriel', 2, 4.14, FALSE, 'A moon of Uranus, named after a character from Alexander Pope’s poem.'),
('Titania', 2, 8.71, FALSE, 'The largest moon of Uranus, discovered in 1787.'),
('Oberon', 2, 13.46, FALSE, 'A moon of Uranus, discovered in 1787.'),
('Nereid', 2, 360.14, FALSE, 'A moon of Neptune, discovered in 1949 by Gerard Kuiper.'),
('Himalia', 3, 250.56, FALSE, 'One of Jupiter’s outer moons, discovered in 1904.'),
('Elara', 3, 259.00, FALSE, 'A moon of Jupiter, discovered in 1905.'),
('Pasiphae', 3, 730.50, FALSE, 'An irregular moon of Jupiter, discovered in 1908.'),
('Sinope', 3, 738.00, FALSE, 'An irregular moon of Jupiter, discovered in 1914.'),
('Ananke', 3, 631.60, FALSE, 'An irregular moon of Jupiter, discovered in 1951.'),
('Carme', 3, 162.15, FALSE, 'An irregular moon of Jupiter, discovered in 1938.'),
('Lysithea', 3, 259.00, FALSE, 'An irregular moon of Jupiter, discovered in 1938.'),
('Eukelade', 3, 231.40, FALSE, 'An irregular moon of Jupiter, discovered in 2000.'),
('Thebe', 4, 0.68, FALSE, 'A small moon of Jupiter, discovered in 1979 by the Voyager 1 spacecraft.'),
('Amalthea', 4, 0.30, FALSE, 'A moon of Jupiter, discovered in 1892 by Edward Barnard.');

INSERT INTO satellite (name, moon_id, launch_year, operational)
VALUES
('Apollo 11', 1, 1969, TRUE),
('Mars Orbiter', 2, 2014, TRUE),
('Europa Clipper', 5, 2023, TRUE);
