
CREATE TABLE IF NOT EXISTS animals (
    id INT PRIMARY KEY,
    name VARCHAR(200),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(200);


ALTER TABLE animals DROP COLUMN species;

CREATE TABLE IF NOT EXISTS owners (
    id serial PRIMARY KEY,
    full_name VARCHAR(200),
    age INT
);

CREATE TABLE IF NOT EXISTS species (
    id serial PRIMARY KEY,
    name VARCHAR(200)
);

ALTER TABLE animals ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
    FOREIGN KEY (owner_id) REFERENCES owners(id);

ALTER TABLE animals ADD COLUMN species_id INT, 
ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id) REFERENCES species(id);

CREATE TABLE vets (
    id serial PRIMARY KEY,
    name VARCHAR(200),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    id serial PRIMARY KEY,
    vet_id INT,
    species_id INT,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    id serial PRIMARY KEY,
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animal_index ON visits (animal_id);


CREATE INDEX vets_index ON visits (vet_id);

CREATE INDEX owner_index ON owners (email);

CREATE INDEX idx_vet_id_and_other_column ON visits (vet_id, animal_id);