/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id                INT GENERATED ALWAYS AS IDENTITY,
  name              VARCHAR,
  date_of_birth     DATE,
  escape_attempts   INT,
  neutered          BOOLEAN,
  weight_kg         DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR;

CREATE TABLE owners(
  id                INT GENERATED ALWAYS AS IDENTITY,
  full_name         VARCHAR,
  age               INT,
  PRIMARY KEY (id)
);

CREATE TABLE species(
  id                INT GENERATED ALWAYS AS IDENTITY,
  name              VARCHAR,
  PRIMARY KEY (id)
);

ALTER TABLE animals ADD PRIMARY KEY (id);
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals ADD CONSTRAINT species FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;
ALTER TABLE animals ADD CONSTRAINT owner FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE vets(
  id                     INT GENERATED ALWAYS AS IDENTITY,
  name                   VARCHAR,
  age                    INT,
  date_of_graduation     DATE,
  PRIMARY KEY (id)
);

CREATE TABLE specializations(
  species_id             INT REFERENCES species(id) ON DELETE CASCADE,
  vet_id                 INT REFERENCES vets(id) ON DELETE CASCADE,
  PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits(
  animal_id              INT REFERENCES animals(id) ON DELETE CASCADE,
  vet_id                 INT REFERENCES vets(id) ON DELETE CASCADE,
  date_of_visit          DATE,
  PRIMARY KEY (animal_id, vet_id, date_of_visit)
);