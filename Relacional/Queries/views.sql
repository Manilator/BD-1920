use FNAC;

-- pesquisa completa dos livros
drop view if exists livros_titulo_asc;
create view livros_titulo_asc as
select a.id_artigo as Id, a.titulo as Título, l.autor as Autor,
a.preco as Preço, a.ano as Publicado, a.classificacao as Classificação,
l.genero as Género, l.editora as Editora, l.n_paginas as `Nº Páginas`
from Livro l join Artigo a on a.id_artigo = l.id_artigo
order by a.titulo ASC;

select * from livros_titulo_asc;

-- pesquisa completa dos filmes
drop view if exists filmes_titulo_asc;
create view filmes_titulo_asc as
select a.id_artigo as Id, a.titulo as Título, f.realizador as Realizador,
a.preco as Preço, a.ano as Ano, a.classificacao as Classificação,
f.genero as Género, f.duracao as Duração
from Filme f join Artigo a on a.id_artigo = f.id_artigo
order by a.titulo ASC;

select * from filmes_titulo_asc;

-- pesquisa completa dos jogos
drop view if exists jogos_titulo_asc;
create view jogos_titulo_asc as
select a.id_artigo as Id, a.titulo as Título, j.plataforma as Plataforma, a.preco as Preço,
a.ano as Ano, a.classificacao as Classificação, j.genero as Género,
j.publisher as Editor, j.idade_min as `Idade Mínima`, j.n_jogadores_max as `Nº Max Jogadores`
from Jogo j join Artigo a on a.id_artigo = j.id_artigo
order by a.titulo ASC;

select * from jogos_titulo_asc;

-- pesquisa completa das musicas --
drop view if exists musicas_titulo_asc;
create view musicas_titulo_asc as
select a.id_artigo as Id, a.titulo as Título, m.artista as Artista,
m.formato as Formato, a.preco as Preço, a.ano as Publicado,
a.classificacao as Classificação, m.genero_musical as Género
from Musica m join Artigo a on a.id_artigo = m.id_artigo
order by a.titulo ASC;

select * from musicas_titulo_asc;

-- 18. Obter o top 3 artigos mais vendidos
drop view if exists top_artigos;
create view top_artigos as
	select a.id_artigo, titulo, tipo, preco, sum(co.montante) as `montante total` from Artigo a
	join Compra_de_X_Artigos cx on cx.id_artigo = a.id_artigo
	join Compra co on co.id_compra = cx.id_compra
	group by a.id_artigo
	order by sum(co.montante) DESC
	limit 3;

select * from top_artigos;

-- 23. quanto cada autor já vendeu no total (quantidade e montante total) ordenado por lucro total e qtd decrescente
drop view if exists top_vendas_autor;
create view top_vendas_autor as
select l.autor as Autor, sum(a.preco*c.quantidade) as `Montante Total`, sum(c.quantidade) as `Quantidade Total`
from Compra_de_X_Artigos c
join Artigo a on a.id_artigo = c.id_artigo
join Livro l on c.id_artigo = l.id_artigo
group by l.autor
order by `Montante Total` DESC, `Quantidade Total` DESC;

select * from top_vendas_autor;