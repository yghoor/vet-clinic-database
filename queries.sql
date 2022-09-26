/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-31-12';
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
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT date_of_birth, SUM(escape_attempts) / COUNT(species) AS average 
  FROM animals
  GROUP BY date_of_birth 
  HAVING date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';

SELECT full_name, name FROM animals JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';

SELECT animals.name AS animal, species.name AS species 
  FROM animals 
  JOIN species ON species_id = species.id 
  WHERE species.name = 'Pokemon';

SELECT full_name, name FROM animals RIGHT JOIN owners ON owner_id = owners.id;

SELECT COUNT(animals.name) AS num_animals, species.name AS species 
  FROM species 
  JOIN animals ON species_id = species.id
  GROUP BY species.name;

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

SELECT animals.name, vets.name, visits.date_of_visit
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
  WHERE vets.name = 'William Tatcher'
  ORDER BY date_of_visit DESC LIMIT 1;

SELECT vets.name, COUNT(animals.name)
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
  WHERE vets.name = 'Stephanie Mendez' 
  GROUP BY vets.name;

SELECT vets.name, species.name
  FROM species
  JOIN specializations ON specializations.species_id = species.id
  RIGHT JOIN vets ON specializations.vet_id = vets.id;

SELECT animals.name, vets.name, date_of_visit
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
  WHERE vets.name = 'Stephanie Mendez' 
    AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
  
SELECT animals.name, COUNT(animals.name) AS num_visits
  FROM animals
  JOIN visits ON visits.animal_id = animals.id 
  GROUP BY animals.name 
  ORDER BY COUNT(animals.name) DESC LIMIT 1;

SELECT animals.name, vets.name, visits.date_of_visit
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY date_of_visit ASC LIMIT 1;

SELECT animals.*, species.name AS species, vets.*, visits.date_of_visit
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
  JOIN species ON animals.species_id = species.id
  ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.*)
  FROM visits
  LEFT JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  WHERE animals.species_id NOT IN (SELECT species_id FROM specializations WHERE vet_id = vets.id);

SELECT vets.name, species.name, COUNT(visits.*)
  FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN species ON animals.species_id = species.id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY vets.name, species.name
  ORDER BY COUNT(visits.*) DESC LIMIT 1;
