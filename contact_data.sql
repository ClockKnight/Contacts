CREATE TABLE contacts (
  id serial NOT NULL PRIMARY KEY,
  name varchar(40) NOT NULL,
  email varchar(40) NOT NULL
);

INSERT INTO contacts ("id","name","email")
VALUES (1,'Scott McPhee','scottymcphee@gmail.com'),
       (2,'Khurram Virani','kvirani@lighthouselabs.ca'),
       (3,'Don Burks','don@lighthouselabs.ca'),
       (4,'Adam Abdelrhafour','adam.devbootcamp@gmail.com'),
       (5,'Ebonku Abaku','idaku6@yahoo.com'),
       (6,'Bruno Amaral','brunonalon2@gmail.com'),
       (7,'Hatim Hakimjee','hatim@ualberta.ca'),
       (8,'Nick Yee','njsyee@gmail.com'),
       (9,'Christopher Jackson','chris.r.jackson78@gmail.com'),
       (10,'Jonathon Morrissey','jona.morrissey@gmail.com');
