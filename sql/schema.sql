CREATE TABLE IF NOT EXISTS tasks (
    name CHAR(5) NOT NULL,
    val  SMALLINT(2)
);

CREATE TABLE IF NOT EXISTS groups (
  id        VARCHAR(80) NOT NULL,
  parent_id VARCHAR(80),
  name      VARCHAR(3000),
  KEY record(id, parent_id)
);

CREATE TABLE IF NOT EXISTS properties (
  id   VARCHAR(80) NOT NULL,
  name VARCHAR(3000),
  type VARCHAR(3000),
  KEY record(id)
);

CREATE TABLE IF NOT EXISTS products (
  id          VARCHAR(80) NOT NULL,
  name        VARCHAR(3000),
  description TEXT,
  barcode     VARCHAR(250),
  article     VARCHAR(250),
  full_name   VARCHAR(3000),
  country     VARCHAR(250),
  brand       VARCHAR(250),
  KEY record(id)
);

CREATE TABLE IF NOT EXISTS products_properties (
  parent_id VARCHAR(80) NOT NULL,
  id        VARCHAR(80) NOT NULL,
  value     VARCHAR(250),
  KEY record(parent_id, id)
);

CREATE TABLE IF NOT EXISTS products_taxes (
  parent_id VARCHAR(80) NOT NULL,
  name      VARCHAR(80),
  rate      VARCHAR(20),
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS products_requisites (
  parent_id VARCHAR(80) NOT NULL,
  name      VARCHAR(250),
  value     VARCHAR(250),
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS products_excises (
  parent_id VARCHAR(80) NOT NULL,
  name      VARCHAR(250),
  sum       FLOAT,
  currency  CHAR(3),
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS products_images (
  parent_id VARCHAR(80) NOT NULL,
  url       VARCHAR(250),
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS products_groups (
  product_id VARCHAR(80) NOT NULL,
  group_id   VARCHAR(80) NOT NULL,
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS products_contractor (
  parent_id VARCHAR(80) NOT NULL,
  id        VARCHAR(80) NOT NULL,
  name      VARCHAR(250),
  title     VARCHAR(3000),
  full_name VARCHAR(3000),
  KEY record(parent_id, id)
);

CREATE TABLE IF NOT EXISTS products_component (
  parent_id     VARCHAR(80) NOT NULL,
  catalog_id    VARCHAR(80) NOT NULL,
  classifier_id VARCHAR(80) NOT NULL,
  quantity      SMALLINT,
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS bundling (
  id            VARCHAR(80) NOT NULL,
  name          VARCHAR(3000),
  catalog_id    VARCHAR(80),
  classifier_id VARCHAR(80),
  KEY record(id)
);

CREATE TABLE IF NOT EXISTS bundling_offers (
  parent_id        VARCHAR(80) NOT NULL,
  id               VARCHAR(80) NOT NULL,
  name             VARCHAR(3000),
  base_unit        VARCHAR(200),
  base_unit_name   VARCHAR(200),
  base_unit_code   VARCHAR(200),
  base_unit_global VARCHAR(200),
  quantity         FLOAT,
  KEY record(parent_id, id)
);

CREATE TABLE IF NOT EXISTS bundling_prices_types (
  parent_id VARCHAR(80) NOT NULL,
  KEY record(parent_id)
);

CREATE TABLE IF NOT EXISTS bundling_offers_prices (
  parent_id     VARCHAR(80) NOT NULL,
  display       VARCHAR(200),
  price_type_id VARCHAR(80) NOT NULL,
  unit_price    VARCHAR(50),
  currency      CHAR(3),
  unit          VARCHAR(50),
  coefficient   SMALLINT,
  KEY record(parent_id)
);
