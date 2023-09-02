/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT after_delete;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO after_delete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


-- 
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts 
FROM animals 
GROUP BY neutered 
ORDER BY avg_escape_attempts DESC 
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight 
FROM animals 
GROUP BY species;


SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight 
FROM animals 
GROUP BY species;


SELECT species, AVG(escape_attempts) AS avg_escape_attempts 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;



SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';


SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;


SELECT species.name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.id;


SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';


SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;


SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY animal_count DESC
LIMIT 1;


SELECT animal_id FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY date_of_visit DESC
LIMIT 1;


SELECT COUNT(DISTINCT animal_id) FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');



SELECT v.name, s.name AS specialty
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;


SELECT animal_id FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT animal_id, COUNT(*) AS visit_count
FROM visits
GROUP BY animal_id
ORDER BY visit_count DESC
LIMIT 1;


SELECT animal_id FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY date_of_visit ASC
LIMIT 1;


SELECT a.*, v.*, vis.date_of_visit
FROM visits vis
JOIN animals a ON vis.animal_id = a.id
JOIN vets v ON vis.vet_id = v.id
ORDER BY vis.date_of_visit DESC
LIMIT 1;



SELECT COUNT(*) FROM visits v
LEFT JOIN specializations s ON v.vet_id = s.vet_id
WHERE s.species_id IS NULL OR s.species_id != v.animal_id;


SELECT a.species_id, COUNT(*) AS visit_count
FROM visits vis
JOIN animals a ON vis.animal_id = a.id
WHERE vis.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY a.species_id
ORDER BY visit_count DESC
LIMIT 1;
