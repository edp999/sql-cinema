/*1*/

select nome from sale where citta = 'Pisa'

/*2*/

select titolo from film where annoproduzione>1960

/*3*/

select titolo, regista from film where (genere = 'fantascienza' and (nazionalita = 
                                        'giapponese' or nazionalita = 'francese' )
                                        and annoproduzione > 1990)

/*4*/

select titolo from film where genere = ('fantascienza'and nazionalita = 'giapponese'
and annoproduzione>1990) or nazionalita = 'francese'

/*5*/

select titolo from film where regista =
    (select regista from film where titolo = 'Tenet')

/*6*/

select f.titolo, f.genere from film f join proiezioni p on f.codfilm = p.codfilm
where p.dataproiezione = '25 Dec 2004'

/*7*/

select f.titolo, f.genere from film f join proiezioni p on f.codfilm = p.codfilm
    join sale s on p.codsala = s.codsala
where p.dataproiezione = '25 Dec 2004' and s.citta='Napoli'

/*8*/

select s.nome from film f join proiezioni p on f.codfilm = p.codfilm
    join sale s on p.codsala = s.codsala join recita r on f.codfilm = r.codfilm
        join attori a on r.codattore = a.codattore
where s.citta='Napoli' and p.dataproiezione = '25 Dec 2004' and a.nome = 'R.Williams'

/*9*/

select f.titolo
from film f join recita r on f.codfilm = r.codfilm
    join attori a on r.codattore = a.codattore
where a.nome = 'M. Mastroianni' or a.nome = 'S. Loren'

/*10*/

select f.titolo
from film f join recita r on f.codfilm = r.codfilm
    join attori a on r.codattore = a.codattore
where a.nome = 'M. Mastroianni' and f.titolo = any (select f.titolo
from film f join recita r on f.codfilm = r.codfilm
    join attori a on r.codattore = a.codattore
where a.nome = 'S. Loren')

/*11*/

                                        
