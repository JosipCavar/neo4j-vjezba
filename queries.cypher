Zadatak 1:

RETURN 'Neo4j radi!' AS poruka

Zadatak 2:

CREATE (f1:Film {naslov: 'Inception', godina: 2010, ocjena: 8.8, zanr: 'sci-fi'})
CREATE (f2:Film {naslov: 'The Dark Knight', godina: 2008, ocjena: 9.0, zanr: 'akcija'})
CREATE (f3:Film {naslov: 'Interstellar', godina: 2014, ocjena: 8.6, zanr: 'sci-fi'})

CREATE (o1:Osoba {ime: 'Christopher Nolan', dob: 54})
CREATE (o2:Osoba {ime: 'Leonardo DiCaprio', dob: 50})

CREATE (g1:Grad {naziv: 'London'})
CREATE (g2:Grad {naziv: 'Siroki Brijeg'})

MATCH (n)
RETURN count(n)


Zadatak 3:


MATCH (o:Osoba {ime: 'Christopher Nolan'}),
      (f:Film {naslov: 'Inception'})
CREATE (o)-[:REZIRAO]->(f)

MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}),
      (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f)

MATCH (o:Osoba {ime: 'Christopher Nolan'}),
      (g:Grad {naziv: 'London'})
CREATE (o)-[:ZIVI_U]->(g)

MATCH (a:Osoba {ime: 'Christopher Nolan'}),
      (b:Osoba {ime: 'Leonardo DiCaprio'})
CREATE (a)-[:PRIJATELJ {od: 2010}]->(b)

MATCH (n)-[r]->(m)
RETURN n, r, m

Zadatak 4:

MATCH (f:Film)
WHERE f.zanr = 'triler'
RETURN f.naslov, f.godina
ORDER BY f.godina ASC

MATCH (o:Osoba)-[:REZIRAO]->(:Film),
      (o)-[:ZIVI_U]->(g:Grad)
RETURN DISTINCT o.ime AS redatelj, g.naziv AS grad

MATCH (f:Film)
WHERE f.godina >= 2008 AND f.godina <= 2015
RETURN f.naslov, f.godina

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o.ime AS redatelj, count(f) AS broj_filmova
WHERE broj_filmova > 1
RETURN redatelj, broj_filmova

Zadatak 5:

MATCH p = shortestPath(
  (a:Osoba {ime: 'Leonardo DiCaprio'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p)

MATCH (g:Grad {naziv: 'London'})-[*1..2]-(n)
RETURN DISTINCT n

MATCH (a:Osoba {ime: 'Francis Ford Coppola'})
MATCH (b:Osoba {ime: 'Leonardo DiCaprio'})
RETURN EXISTS {
  MATCH (a)-[*1..4]-(b)
} AS povezani

Zadatak 6:
MATCH (f:Film)
RETURN count(f) AS broj_filmova,
avg(f.ocjena) AS prosjecna_ocjena

MATCH (f:Film)
WITH f.zanr AS zanr,
count(f) AS broj_filmova,
max(f.ocjena) AS max_ocjena
RETURN zanr, broj_filmova, max_ocjena

MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
RETURN f.naslov,
collect(o.ime) AS glumci

Zadatak 7:
CREATE INDEX film_ocjena FOR (f:Film) ON (f.ocjena)

CREATE CONSTRAINT film_naslov_unique
FOR (f:Film)
REQUIRE f.naslov IS UNIQUE

SHOW INDEXES

SHOW CONSTRAINTS

Zavrsni zadatak:

MATCH (i:Izvodac {ime: 'Eminem'})-[:OBJAVIO]->(a:Album)
RETURN a.naziv, a.godina
ORDER BY a.godina

MATCH (a:Album)
WHERE a.ocjena > 8.0
RETURN a.naziv, a.ocjena
ORDER BY a.ocjena DESC

MATCH (i:Izvodac)
OPTIONAL MATCH (i)-[:OBJAVIO]->(a:Album)
RETURN i.ime, count(a) AS broj_albuma

MATCH p = shortestPath(
  (a:Izvodac {ime: 'Eminem'})
  -[:SLICAN|SURADIVAO_S*]-
  (b:Izvodac {ime: 'The Weeknd'})
)
RETURN p, length(p)

MATCH (a:Album)-[:PRIPADA_ZANRU]->(z:Zanr)
WITH z.naziv AS zanr,
count(a) AS broj_albuma,
avg(a.ocjena) AS prosjecna_ocjena
WHERE prosjecna_ocjena > 7.5
RETURN zanr, broj_albuma, prosjecna_ocjena

CREATE CONSTRAINT izvodac_ime_unique
FOR (i:Izvodac)
REQUIRE i.ime IS UNIQUE

CREATE INDEX album_ocjena
FOR (a:Album)
ON (a.ocjena)

MATCH (n)-[r]->(m)
WHERE n:Izvodac OR n:Album OR n:Zanr
RETURN n, r, m