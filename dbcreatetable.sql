CREATE TABLE  IF NOT EXISTS `Person` (
    person_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    length INTEGER(3) NOT NULL,
    gender VARCHAR(1) NOT NULL, /* 'm' for male, 'f' for female*/
    birthdate DATE NOT NULL,
    excercise_level INTEGER(2) NOT NULL, /* 1 low, 2 average, 3 high */
    email VARCHAR(50) NOT NULL, /* Possibly more emails in the future */
    CONSTRAINT uniquePerson UNIQUE (email) /* No 2 users with the same email */
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `looses_weight` (
    person_id INTEGER UNSIGNED,
    period INTEGER,
    start_date DATE,
    weight_to_lose INTEGER NOT NULL,
    CONSTRAINT looses_pk PRIMARY KEY (`person_id`, `start_date`, `period`),
    FOREIGN KEY (person_id) REFERENCES `Person`(person_id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `person_weighs` (
    person_id INTEGER UNSIGNED,
    on_date DATE,
    weight INTEGER NOT NULL,
    CONSTRAINT weighs_pk PRIMARY KEY (`person_id`, `on_date`),
    FOREIGN KEY (person_id) REFERENCES `Person`(person_id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `Recipe` (
    recipe_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    calories INTEGER NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `Ingredient` (
    ingredient_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    calories INTEGER NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `Tag` (
    tag_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    CONSTRAINT uniqueTagName UNIQUE (name)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `recipe_tag` (
    recipe_id INTEGER UNSIGNED,
    tag_id INTEGER UNSIGNED,
    CONSTRAINT recipe_tag_pk PRIMARY KEY (`recipe_id`, `tag_id`),
    FOREIGN KEY (recipe_id) REFERENCES `Recipe` (recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES `Tag`(tag_id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `recipe_ingredient` (
    recipe_id INTEGER UNSIGNED,
    ingredient_id INTEGER UNSIGNED,
    amount INTEGER NOT NULL,
    CONSTRAINT recipe_ingredient_pk PRIMARY KEY (`recipe_id`, `ingredient_id`),
    FOREIGN KEY (recipe_id) REFERENCES `Recipe`(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES `Ingredient`(ingredient_id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `recipe_recipe` (
    recipe_part_id INTEGER UNSIGNED,
    recipe_having_id INTEGER UNSIGNED,
    amount INTEGER NOT NULL,
    CONSTRAINT recipe_recipe_pk PRIMARY KEY (`recipe_part_id`, `recipe_having_id`),
    FOREIGN KEY (recipe_part_id) REFERENCES `Recipe`(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_having_id) REFERENCES `Recipe`(recipe_id) ON DELETE CASCADE
) ENGINE=INNODB;
