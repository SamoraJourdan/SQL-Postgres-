CREATE TABLE my_contacts (
	contact_id bigserial CONSTRAINT my_contacts__key PRIMARY KEY,
	last_name varchar(20) NOT NULL,
	first_name varchar(20) NOT NULL,
	phone_num varchar(12) NOT NULL,
	email varchar(40) NOT NULL,
	gender char(1) NOT NULL,
	birthday date NOT NULL,
	prof_id integer REFERENCES profession (prof_id),
	postal_code varchar(4) REFERENCES postal_code (postal_code),
	status_id integer REFERENCES status (status_id)
);

CREATE TABLE profession (
	prof_id bigserial CONSTRAINT prof_key PRIMARY KEY,
	profession varchar(50) NOT NULL,
	CONSTRAINT prof_con UNIQUE (profession)
);

CREATE TABLE postal_code (
	postal_code varchar(4) CONSTRAINT postal_code_key PRIMARY KEY,
	city varchar(30) NOT NULL,
	province varchar(20) NOT NULL,
	CONSTRAINT post_cit_prov_con UNIQUE (postal_code, city, province),
	CONSTRAINT check_postal_length CHECK (length(postal_code) = 4)
);

CREATE TABLE status (
	status_id bigserial CONSTRAINT staus_key PRIMARY KEY,
	status varchar(50) NOT NULL
	
);

CREATE TABLE interests (
	interest_id bigserial CONSTRAINT interests_key PRIMARY KEY,
	interest varchar(50)NOT NULL
	
);

CREATE TABLE contact_interest (
	contact_id integer REFERENCES my_contacts (contact_id),
	interest_id integer REFERENCES interests (interest_id)	
);

CREATE TABLE seeking (
	seeking_id bigserial CONSTRAINT seeking_key PRIMARY KEY,
	seeking varchar(20) NOT NULL
	
);

CREATE TABLE contact_seeking (
	contact_id integer REFERENCES my_contacts (contact_id),
	seeking_id integer REFERENCES seeking (seeking_id) 	
);

INSERT INTO profession (profession)
VALUES
	('Youtuber'),
	('Programmer'),
	('Database Manager'),
	('Cashier'),
	('CTO'),
	('CEO'),
	('Uber Driver'),
	('Playtester'),
	('Professional Gamer')
	
INSERT INTO postal_code (postal_code, city, province)
VALUES
	('2195', 'Johannesburg', 'Gauteng'),
	('2155', 'Johannesburg', 'Gauteng'),
	('2268', 'Cape Town', 'Western Cape'),
	('4232', 'Cape Town', 'Western Cape'),
	('2132', 'Durban', 'KwaZulu-Natal'),
	('1356', 'Durban', 'KwaZulu-Natal'),
	('7889', 'Bloemfontein', 'Free State'),
	('2466', 'Bloemfontein', 'Free State')
	
INSERT INTO status (status)
VALUES
	('Single'),
	('Married'),
	('It"s complicated'),
	('In a relationship')
	
INSERT INTO interests (interest)
VALUES
	('Reading'),
	('Hiking'),
	('Board Games'),
	('Video Games'),
	('Trading Card Games'),
	('Charity Work'),
	('Music'),
	('Social Media'),
	('Parting'),
	('Dancing'),
	('Singing')
	
INSERT INTO seeking (seeking)
VALUES 
	('Men'),
	('Women'),
	('Other')
	
INSERT INTO my_contacts (last_name, first_name, phone_num, email, gender, birthday, prof_id, postal_code, status_id)
VALUES
	('Spongebob', 'Squarepants', '0832351233', 'sbob@gamail.com', 'M', '1996-03-31', 1, '2195', 1),
	('Sandy', 'Cheeks', '0812567896', 'scheeks@gamail.com', 'F', '1997-04-21', 3, '2155', 2),
	('Eugene', 'Krabs', '0194506834', 'ekrabs@gamail.com', 'M', '1986-12-11', 5, '4232', 3),
	('Squidward', 'Tentacles', '0720492185', 'octoboss@gamail.com', 'M', '1967-05-22', 7, '2132', 4),
	('Patrick', 'Star', '0610392955', 'rockin@gamail.com', 'M', '1999-09-13', 6, '7889', 3),
	('Sheldon', 'Plankton', '0428482848', 'gimmeformula@gamail.com', 'M', '1997-07-11', 9, '2466', 2)
	
INSERT INTO contact_interest (contact_id, interest_id)
VALUES 
	(1, 1),
	(1, 5),
	(1, 7),
	(1, 9),
	(2, 2),
	(2, 4),
	(2, 6),	
	(3, 5),
	(3, 9),
	(4, 1),
	(4, 2),
	(4, 6),
	(5, 9),
	(5, 2),
	(5, 8),
	(6, 3),
	(6, 11),
	(6, 4),
	(6, 7)
	
INSERT INTO contact_seeking (contact_id, seeking_id)
VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 2),
	(6, 1)

SELECT 
last_name, first_name, phone_num, email, gender, birthday, profession, pc.postal_code, city, province, status, string_agg(interest,',') AS interests, seeking
FROM my_contacts AS mc 
LEFT JOIN profession AS prof
ON mc.prof_id = prof.prof_id
LEFT JOIN postal_code AS pc
ON mc.postal_code = pc.postal_code
LEFT JOIN status AS st
ON mc.status_id = st.status_id
LEFT JOIN contact_interest AS ci
ON mc.contact_id = ci.contact_id
LEFT JOIN interests AS int
ON ci.interest_id = int.interest_id
LEFT JOIN contact_seeking AS cs
ON mc.contact_id = cs.contact_id
LEFT JOIN seeking AS se
ON cs.seeking_id = se.seeking_id
GROUP BY mc.contact_id, profession, pc.postal_code, city, province, status, seeking




