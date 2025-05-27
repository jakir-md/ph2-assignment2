-- Active: 1747647720010@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;

CREATE Table rangers(
    ranger_id INT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    region VARCHAR(100) NOT NULL
);

CREATE Table species(
    species_id INT PRIMARY KEY, 
    common_name VARCHAR(100) NOT NULL, 
    scientific_name VARCHAR(100) NOT NULL, 
    discovery_date DATE NOT NULL, 
    conservation_status VARCHAR(100) NOT NULL
);

CREATE Table sightings(
    sighting_id INT PRIMARY KEY, 
    species_id INT REFERENCES species(species_id), 
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    notes TEXT
);


-- Insert Values in the tables
INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');


INSERT INTO species(species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


INSERT INTO sightings(sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



--- PROBLEM: 01
INSERT INTO rangers VALUES(4, 'Derek Fox', 'Coastal Plains');

--- PROBLEM: 02
SELECT DISTINCT COUNT(*) as unique_species_count FROM species;


--- PROBLEM: 03
SELECT * FROM sightings WHERE location LIKE '%Pass';


--- PROBLEM: 04
SELECT name, COUNT(*) as total_sightings FROM sightings 
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id 
    GROUP BY rangers.name 
    ORDER BY rangers.name ASC;
 

--- PROBLEM: 05
SELECT sp.common_name
FROM species sp
LEFT JOIN sightings si ON sp.species_id = si.species_id
WHERE si.species_id IS NULL;


--- PROBLEM: 06
SELECT species.common_name, sightings.sighting_time, rangers.name FROM sightings
    JOIN species ON sightings.species_id = species.species_id 
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id 
    ORDER BY sightings.sighting_time DESC LIMIT 2;


--- PROBLEM: 07
UPDATE species SET conservation_status = 'Historic' WHERE extract(YEAR FROM discovery_date) < 1800;


--- PROBLEM: 08
SELECT sighting_id,
    CASE 
        WHEN sighting_time::time < '12:00:00' THEN 'Morning'
        WHEN sighting_time::time >= '12:00:00' AND sighting_time::time <= '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;


--- PROBLEM: 09
DELETE FROM rangers WHERE ranger_id IN 
    (SELECT rangers.ranger_id FROM rangers
        LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id 
        WHERE sightings.sighting_id IS NULL);
