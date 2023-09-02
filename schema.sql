/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);
ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
   id int NOT NULL IDENTITY(1,1),
   full_name varchar(255),
   age int,
   PRIMARY KEY (id)
   );



   CREATE TABLE species (
   id int NOT NULL IDENTITY(1,1),
   name varchar(255),
   PRIMARY KEY (id)
   );


 

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INTEGER,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INTEGER,
ADD CONSTRAINT fk_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id);


CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);



CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(id),
    vet_id INTEGER REFERENCES vets(id),
    UNIQUE(species_id, vet_id)
);


CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    visit_date DATE,
    UNIQUE(animal_id, vet_id, visit_date)
);
