-- Creating movies table =================================================================== 

CREATE TABLE movies (
    movie_name VARCHAR(255) PRIMARY KEY,
    genre CHAR(50),
    online_aggregate_rating NUMERIC
);

INSERT INTO movies (name, genre, online_aggregate_rating)
VALUES
    ('Inside Out 2', 'Animation', 8.0),
    ('Deadpool & Wolverine', 'Superhero', 7.6),
    ('Wicked', 'Drama', 7.9),
    ('Dune Part 2', 'Action', 8.5),
    ('Quiet Place: Day 1', 'Horror', 7.4),
    ('Kingdom of the Planet of Apes', 'Thriller', 7.6);

--Creating viewers table ===================================================================
 
CREATE TABLE viewers (
    name VARCHAR(255) PRIMARY KEY,
    age INT,
    gender CHAR(6),
    favorite_genres TEXT[]
);

INSERT INTO viewers (name, age, gender, favorite_genres)
VALUES
    ('Nathasha', 30, 'Female', ARRAY['Drama', 'Horror']),
    ('Joseph', 62, 'Male', ARRAY['Comedy', 'Superhero']),
    ('Rosy', 59, 'Female', ARRAY['Comedy', 'Action']),
    ('Andrew', 20, 'Male', ARRAY['Superhero', 'Action']),
    ('Julia', 21, 'Female', ARRAY['Comedy', 'Horror']),
    ('Kazi', 26, 'Female', ARRAY['Animation', 'Comedy']),
    ('Badri', 24, 'Male', ARRAY['Action', 'Thriller']),
    ('Rafiya', 24, 'Female', ARRAY['Drama', 'Animation']),
    ('Thomas', 19, 'Male', ARRAY['Thriller', 'Horror']),
    ('Benjamin', 29, 'Male', ARRAY['Action', 'Animation']);

-- Creating viewers rating table ===================================================================

CREATE TABLE viewer_ratings (
    viewer_name VARCHAR(255),
    movie_name VARCHAR(255),
    viewer_rating NUMERIC,
    -- Foreign keys
    CONSTRAINT fk_viewer FOREIGN KEY (viewer_name) REFERENCES viewers(name),
    CONSTRAINT fk_movie FOREIGN KEY (movie_name) REFERENCES movies(name)
);



INSERT INTO viewer_ratings (viewer_name, movie_name, viewer_rating)
VALUES

    ('Nathasha', 'Inside Out 2', 3.5),
    ('Nathasha', 'Deadpool & Wolverine', 3.0),
    ('Nathasha', 'Wicked', 4.5),
    ('Nathasha', 'Dune Part 2', NULL),
    ('Nathasha', 'Quiet Place: Day 1', 4.0),
    ('Nathasha', 'Kingdom of the Planet of Apes', 3.5),
    
    ('Joseph', 'Inside Out 2', NULL),
    ('Joseph', 'Deadpool & Wolverine', 4.5),
    ('Joseph', 'Wicked', NULL),
    ('Joseph', 'Dune Part 2', 3.5),
    ('Joseph', 'Quiet Place: Day 1', 3.0),
    ('Joseph', 'Kingdom of the Planet of Apes', 3.5),
    
    ('Rosy', 'Inside Out 2', 3.5),
    ('Rosy', 'Deadpool & Wolverine', 3.5),
    ('Rosy', 'Wicked', 3.5),
    ('Rosy', 'Dune Part 2', 4.0),
    ('Rosy', 'Quiet Place: Day 1', 3.0),
    ('Rosy', 'Kingdom of the Planet of Apes', 4.0),
    
    ('Andrew', 'Inside Out 2', 3.0),
    ('Andrew', 'Deadpool & Wolverine', 4.5),
    ('Andrew', 'Wicked', NULL),
    ('Andrew', 'Dune Part 2', 4.5),
    ('Andrew', 'Quiet Place: Day 1', 3.5),
    ('Andrew', 'Kingdom of the Planet of Apes', 4.5),
    
    ('Julia', 'Inside Out 2', 3.5),
    ('Julia', 'Deadpool & Wolverine', 3.0),
    ('Julia', 'Wicked', 3.5),
    ('Julia', 'Dune Part 2', NULL),
    ('Julia', 'Quiet Place: Day 1', 4.5),
    ('Julia', 'Kingdom of the Planet of Apes', 3.0),
    
    ('Kazi', 'Inside Out 2', 4.5),
    ('Kazi', 'Deadpool & Wolverine', 3.0),
    ('Kazi', 'Wicked', 3.0),
    ('Kazi', 'Dune Part 2', 3.0),
    ('Kazi', 'Quiet Place: Day 1', 3.5),
    ('Kazi', 'Kingdom of the Planet of Apes', 3.5);

  
    ('Badri', 'Inside Out 2', 3.2),
    ('Badri', 'Deadpool & Wolverine', 4.0),
    ('Badri', 'Wicked', NULL),
    ('Badri', 'Dune Part 2', 3.8),
    ('Badri', 'Quiet Place: Day 1', 3.2),
    ('Badri', 'Kingdom of the Planet of Apes', 3.9),

	  ('Rafiya', 'Inside Out 2', 4.0),
    ('Rafiya', 'Deadpool & Wolverine',NULL),
    ('Rafiya', 'Wicked', 4.2),
    ('Rafiya', 'Dune Part 2', NULL),
    ('Rafiya', 'Quiet Place: Day 1', 3.2),
    ('Rafiya', 'Kingdom of the Planet of Apes', 3.6),

  ('Thomas', 'Inside Out 2',NULL),
    ('Thomas', 'Deadpool & Wolverine', 3.8),
    ('Thomas', 'Wicked', NULL),
    ('Thomas', 'Dune Part 2', 3.5),
    ('Thomas', 'Quiet Place: Day 1', 4.0),
    ('Thomas', 'Kingdom of the Planet of Apes', 3.6),

  ('Benjamin', 'Inside Out 2', 3.7),
    ('Benjamin', 'Deadpool & Wolverine', 3.7),
    ('Benjamin', 'Wicked', 3.5),
    ('Benjamin', 'Dune Part 2', 3.8),
    ('Benjamin', 'Quiet Place: Day 1', 3.7),
    ('Benjamin', 'Kingdom of the Planet of Apes', 3.9)

-- Getting average ratings ===================================================================

CREATE TABLE movie_ratings (
    movie_name VARCHAR(255),
    online_aggregate_rating NUMERIC,
    average_score NUMERIC,
    -- Foreign key reference to movies
    CONSTRAINT fk_movie FOREIGN KEY (movie_name) REFERENCES movies(name)
);


INSERT INTO movie_ratings (movie_name, online_aggregate_rating, average_score)
SELECT
    m.name,
    ROUND(m.online_aggregate_rating / 2.0, 1) AS online_aggregate_rating,
    COALESCE(ROUND(AVG(ur.viewer_rating), 1), 0) AS average_score
FROM
    movies m
LEFT JOIN
    viewer_ratings ur ON m.name = ur.movie_name
GROUP BY
    m.name, m.online_aggregate_rating;


-- Getting average ratings with a condition for genre matching =================================================================== 

CREATE TABLE movie_ratings_preferred (
    movie_name VARCHAR(255),
    online_aggregate_rating NUMERIC,
    average_score NUMERIC
);

INSERT INTO movie_ratings_preferred (movie_name, online_aggregate_rating, average_score)
SELECT
    m.name,
    ROUND(m.online_aggregate_rating / 2.0, 1) AS online_aggregate_rating,
    COALESCE(ROUND(AVG(ur.viewer_rating), 1), 0) AS average_score
FROM
    movies m
LEFT JOIN
    viewer_ratings ur ON m.name = ur.movie_name
LEFT JOIN
    viewers v ON ur.viewer_name = v.name
WHERE
    ur.viewer_rating IS NOT NULL
    AND EXISTS (
        -- This is where we put the condition
        SELECT 1
        FROM unnest(v.favorite_genres) AS genre
        WHERE genre = m.genre
    )
GROUP BY
    m.name, m.online_aggregate_rating;

