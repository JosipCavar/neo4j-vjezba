Zadatak 1:
7474 se koristi za Neo4j Browser preko koje radimo upite i pregledavamo bazu.
7687 koristi se za Bolt konekciju kojom se aplikacije povezuju na Neo4j bazu.

Zadatak 2:
CREATE uvijek napravi novi čvor ili vezu čak i ako imamo iste te podatke
MERGE prvo provjerava postoji li takav čvor ili veza pa onda tek stvara ako ne postoji i koristi se da nebi imali duplikate

Zadatak 4:
MATCH prikazuje samo podatke koji imaju traženu vezu u grafu
OPTIONAL MATCH može prikazati i podatke koji nemaju tu vezu
Npr osoba može biti prikazana čak i ako nije režirala nijedan film

Zadatak 5

Ako shortestPath ne pronađe put između dva čvora, Neo4j ne vraća nijedan rezultat jer nisu povezni u grafu.


Zavrsno:
Neo4j bi bio dobar izbor za glazbenu bazu podataka kada su veze između podataka jako važne.
Na primjer, lako se mogu prikazivati slični izvođači, suradnje između izvođača i preporuke albuma.
Graf baza omogućava brzo pronalaženje putova i povezanosti između čvorova.
U PostgreSQL-u bi za takve upite trebalo koristiti više JOIN operacija što bi bilo složenije i sporije.
Neo4j je posebno koristan za recommendation sustave i analizu mreža povezanosti.
