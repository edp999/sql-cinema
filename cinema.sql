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

select f.titolo, a.nome
from film f join recita r on f.codfilm=r.codfilm join attori a on a.codAttore=r.codAttore
group by a.nome, f.titolo, a.nazionalita
having a.nazionalita='Italiana'

/*12*/

select f.titolo, s.nome
from film f join proiezioni p on f.codfilm=p.codfilm join sale s on p.codsala=s.codsala
where extract(YEAR FROM p.dataProiezione)='2004' and s.citta= 'Napoli'

/*13*/

select count(s.codsala)
from sale s 
where s.posti>60 and s.citta='Napoli'
group by s.codsala

/*14*/

select sum(s.posti)
from sale s 

/*15*/

select count(s.codsala), s.citta
from sale s
group by s.citta

/*16*/

select count(j.codsala)
from sale s left join (select codsala from sale where posti>150) j on s.codsala=j.codsala
group by s.citta

/*17*/

select f.regista, count(j.titolo)
from film f left join (select titolo, codfilm from film where annoproduzione>1990) j on f.codfilm=j.codfilm
group by f.regista

/*18*/

select f.regista, sum(p.incasso)
from film f join proiezioni p on f.codfilm=p.codfilm
group by f.regista

/*19*/

select f.titolo, j.conto as proiezioni_pisa, sum(p.incasso)
from film f join proiezioni p on f.codfilm=p.codfilm left join(select codFilm, count(codProiezione) as conto from proiezioni p 
                                                                join sale s on p.codsala=s.codsala
                                                                where citta = 'Roma'
                                                                group by codfilm) as j
                                                    on j.codfilm = f.codfilm
where f.regista = 'George Lucas'
group by f.titolo, j.conto

/*20*/

select f.regista, a.nome, count(a.nome) as n_film_insieme
from film f join recita r on f.codfilm=r.codfilm join attori a on a.codattore=r.codattore
group by f.regista, a.nome
order by f.regista

/*21*/

select f.regista, f.titolo, count(a.nome)
from film f join recita r on f.codfilm=r.codfilm join attori a on a.codattore=r.codattore
group by f.titolo, f.regista
having count(a.nome)>2

