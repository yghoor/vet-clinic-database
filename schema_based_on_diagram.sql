CREATE TABLE paitents(
  id                INT GENERATED ALWAYS AS IDENTITY,
  name              VARCHAR,
  date_of_birth     DATE,
);

CREATE TABLE medical_histories(
  id                INT GENERATED ALWAYS AS IDENTITY,
  admitted_at       TIMESTAMP,
  paitent_id        INT REFERENCES paitents(id) ON DELETE CASCADE,
  status            VARCHAR,
  PRIMARY KEY (id)
);

CREATE TABLE invoices(
  id                   INT GENERATED ALWAYS AS IDENTITY,
  total_amount         DECIMAL,
  generated_at         TIMESTAMP,
  paid_at              TIMESTAMP,
  medical_history_id   INT,
  PRIMARY KEY (id)
);

CREATE TABLE treatments(
  id                   INT GENERATED ALWAYS AS IDENTITY,
  type                 VARCHAR,
  name                 VARCHAR,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories_treatments(
  id                INT GENERATED ALWAYS AS IDENTITY,
  medical_history_id   INT REFERENCES medical_histories(id) ON DELETE CASCADE,
  treatment_id      INT REFERENCES treatments(id) ON DELETE CASCADE,
);

CREATE TABLE invoice_items(
  id                INT GENERATED ALWAYS AS IDENTITY,
  unit_price        DECIMAL,
  quantity          INT,
  total_price       DECIMAL,
  invoice_id        INT REFERENCES invoices(id) ON DELETE CASCADE,
  treatment_id      INT REFERENCES treatments(id) ON DELETE CASCADE,
  PRIMARY KEY (id),
);

ALTER TABLE invoices
  ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
    DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE medical_histories
  ADD FOREIGN KEY (id) REFERENCES invoices (medical_history_id)
    DEFERRABLE INITIALLY DEFERRED;

CREATE INDEX ON medical_histories (id);
CREATE INDEX ON medical_histories (paitent_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON medical_histories_treatments (medical_history_id);
CREATE INDEX ON medical_histories_treatments (treatment_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);