CREATE DATABASE "imt";
use imt;
create table tipveiculo(
codtipoveiculo int,
descricao varchar(45),
primary key (codtipoveiculo)
);

create table combustivel(
codcombustivel int,
descricao varchar(45),
primary key (codcombustivel)
);

create table marca(
codmarca int,
descricao varchar(45),
primary key (codmarca)
);

create table modelo(
codmodelo int,
descricao varchar(45),
codmarca int,
primary key (codmodelo),
foreign key (codmarca) references marca(codmarca)
);

create table veiculo (
matricula varchar(45),
codmodelo int,
mesregisto int,
anoregisto int,
cilindrada int,
emissoesco2 int,
codcombustivel int,
codtipoveiculo int,
primary key (matricula),
foreign key (codmodelo) references modelo(codmodelo),
foreign key (codcombustivel) references combustivel(codcombustivel),
foreign key (codtipoveiculo) references tipveiculo(codtipoveiculo)
);

create table apreensao(
idautomatico int,
matricula varchar(45),
numerodias int,
primary key (idautomatico),
foreign key (matricula) references veiculo(matricula)
);



insert into marca 
(codmarca, descricao) 
values ('1', 'Audi');
insert into dbo.marca(codmarca, descricao) values (2, 'BMW'), (3, 'Citroen'), (4, 'peugeot');
--audi model
insert into modelo(codmodelo, descricao, codmarca) values (1, 'A1', 1), (2, 'A3', 1);
--Bmw model
insert into modelo(codmodelo, descricao, codmarca) values (3, '320d', 2);
--citroen model
insert into modelo(codmodelo, descricao, codmarca) values (4, 'C1',3), (5, 'C2', 3), (6, 'C3', 3), (7, 'C4', 3);
--peugeot model
insert into modelo(codmodelo, descricao, codmarca) values (8, '307', 4), (9, '407', 4);

--tipoveiculo
insert into tipveiculo(codtipoveiculo, descricao) values (1, 'ligeiro de passageiros'), (2, 'comercial'), (3, 'outro');
--combustivel
insert into combustivel(codcombustivel, descricao) values (1, 'gasoleo'), (2, 'gasolina'), (3, 'eletrico'), (4, 'outro');

--veiculos
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('10-AU-20', 1, 7, 2022, 1300, 125, 1, 1);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('10-AU-30', 2, 7, 2020, 1999, 190, 1, 1);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('20-BM-10', 3, 12, 2021, 1499, 130, 2, 1);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('30-CI-50', 6, 8, 2015, 1399, 90, 1, 2);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('30-CI-60', 7, 8, 2015, 1999, 200, 1, 1);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('30-CI-70', 4, 2, 2016, 1999, 200, 1, 1);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('40-PE-70', 8, 8, 2015, 1399, 90, 1, 2);
insert into veiculo(matricula, codmodelo, mesregisto, anoregisto, cilindrada, emissoesco2, codcombustivel, codtipoveiculo) values ('40-PE-80', 9, 8, 2015, 1399, 200, 1, 1);
--apreensoes registadas a determinados veiculos
insert into apreensao(idautomatico, matricula, numerodias) values (1, '40-PE-70', 50), (2, '30-CI-70', 30), (3, '10-AU-30', 120), (4, '10-AU-20', 10);

-- Adcionar a possibilidade de registar data de apreensao e atualizar todos os registos com a data de hoje
alter table apreensao
add data_de_apreensao date;
update apreensao data_de_apreensao = currenttimestamp();

-- sistema que registe as inspeções periódicas que cada veiculo tem associadas. 
-- Assim para cada inspeção é necessário registar a data e hora em que foi efetuada, qual o veiculo inspecionado, quem (entidade com um código, nome e localidade) e qual o resultado (0 -reprovado, 1-aprovado).
create table entidades(
codEntidade int,
nome varchar(45),
localidade varchar(45),
primary key (codEntidade)
);

create table inspecoes(
idinspecao int,
matricula varchar(45),
resultado int not null check (resultado between 0 and 1),
data_inspecao datetime,
codEntidade int,
primary key (idinspecao, data_inspecao),
foreign key (matricula) references veiculo(matricula),
foreign key (codEntidade) references entidades(codEntidade)
);


-- adicionar entidades e inspeçoes
insert into entidades(codEntidade, nome, localidade) values (512, "EboraeTest", "Evora"), (631, "EvoraCheckServicos", "Evora"), (511, "LisbonTest", "Lisboa");
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (1, "10-AU-20", 0, '2022-11-25 09:30:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (2, "10-AU-20", 1, '2022-11-30 18:00:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (3, "10-AU-30", 1, '2022-11-20 19:00:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (4, "20-BM-10", 0, '2022-08-12 19:00:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (5, "30-CI-50", 1, '2022-03-03 15:00:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (6, "30-CI-60", 0, '2022-01-01 9:30:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (7, "30-CI-60", 1, '2022-01-15 13:00:00', 512);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (8, "30-CI-70", 1, '2022-05-15 15:00:00', 511);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (9, "40-PE-70", 0, '2022-08-17 10:00:00', 511);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (10, "40-PE-80", 0, '2022-10-18 11:00:00', 631);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (10, "40-PE-80", 0, '2022-11-15 11:00:00', 631);
insert into inspecoes (idinspecao, matricula, resultado, data_inspecao, codEntidade) values (10, "40-PE-80", 0, '2022-11-30 17:00:00', 631);


-- Quantos Veiculos estao registados para cada tipo de combustilve?

SELECT combustivel.descricao , count(*) as num_veiculos FROM combustivel 
INNER JOIN veiculo ON combustivel.codcombustivel=veiculo.codcombustivel 
GROUP BY combustivel.codcombustivel;

-- Que carros foram a inspeçao e passaram entre os dias "xx-xx-xxxx e yy-yy-yyyy"?
SELECT veiculo.matricula FROM veiculo INNER JOIN
 inspecao ON inspecao.matricula=veiculo.matricula 
 WHERE resultado=1 AND data_hora BETWEEN 'xxxx-xx-xx 00:00:00' AND 'yyyy-yy-yy 23:59:59';

 -- Cada veiculo aprrendido SE mais de 100dias "muito grave" 50-100 "grave" menos de 50 "leve"

SELECT veiculo.matricula, CASE WHEN numerodias>=100 THEN
 "Veículo com apreensão muito grave" 
 WHEN numerodias<50 THEN 
 "Veículo com apreensão leve" 
 ELSE "Veículo com apreensão grave" 
 END as descricao from veiculo
INNER JOIN apreensao ON apreensao.matricula=veiculo.matricula
GROUP by apreensao.matricula;