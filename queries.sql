/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save_1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO save_1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts == 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT date_of_birth, SUM(escape_attempts) / COUNT(species) as average 
  FROM animals
  GROUP BY date_of_birth 
  HAVING date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';

SELECT full_name, name FROM animals JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';

SELECT animals.name as animal, species.name as species 
  FROM animals 
  JOIN species ON species_id = species.id 
  WHERE species.name = 'Pokemon';

SELECT full_name, name FROM animals RIGHT JOIN owners ON owner_id = owners.id;

SELECT animals.name, owners.full_name
  FROM animals 
  JOIN species ON species_id = species.id 
  JOIN owners ON owner_id = owners.id 
  WHERE species.name = 'Digimon' 
  AND owners.full_name = 'Jennifer Orwell';

SELECT owners.full_name, animals.name 
  FROM animals 
  JOIN owners ON owner_id = owners.id
  WHERE owners.full_name = 'Dean Winchester'
  AND escape_attempts = 0;

SELECT owners.full_name, COUNT(owners.id) 
  FROM animals
  LEFT JOIN owners ON owner_id = owners.id
  GROUP BY owners.full_name
  ORDER BY COUNT(owners.id) DESC;

SELECT COUNT(animals.name) as num_animals, species.name as species 
  FROM species 
  JOIN animals ON species_id = species.id
  GROUP BY species.name;
