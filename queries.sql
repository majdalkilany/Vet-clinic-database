
SELECT * from animals WHERE name = 'Luna';

SELECT name FROM animals WHERE name LIKE '%mon';

SELECT name from animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = 'true';

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;


ROLLBACK;
SELECT * FROM animals;


BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
COMMIT;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
COMMIT;
SELECT * FROM animals;


BEGIN;
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET weight_kg = weight_kg * -1 
WHERE weight_kg < 0;
SELECT * FROM animals;


SELECT name
FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals 
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
ORDER BY o.full_name, a.name;

SELECT animals.species_id, COUNT(*) as animal_count
FROM animals
GROUP BY species_id;

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
JOIN species AS s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell'
AND s.name = 'Digimon';

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester'
AND a.escape_attempts < 10;

SELECT o.full_name, COUNT(*) AS animal_count
FROM owners AS o
JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

SELECT a.name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(v.animal_id) AS animal_count
FROM visits AS v
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez';

SELECT v.name, s.name AS specialty_name
FROM vets AS v
LEFT JOIN specializations AS sp ON v.id = sp.vet_id
LEFT JOIN species AS s ON sp.species_id = s.id;

SELECT a.name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(*) AS visit_count
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT a.name, v.visit_date
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

SELECT a.name AS animal_name, a.date_of_birth, vet.name AS vet_name, vet.age AS vet_age, v.visit_date 
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS mismatched_visits
FROM visits AS v
JOIN vets AS vet ON v.vet_id = vet.id
LEFT JOIN specializations AS s ON v.animal_id = s.species_id AND v.vet_id = s.vet_id
WHERE s.species_id IS NULL;

SELECT s.name, COUNT(*) AS animal_count
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN species AS s ON a.species_id = s.id
WHERE vet.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY animal_count DESC
LIMIT 1;

SELECT vet_id FROM visits where vet_id = 4 LIMIT 10000;

