Use FNAC;

-- 11. Obter o número de clientes total
drop procedure if exists contagem_clientes;
DELIMITER //
create procedure contagem_clientes()
begin
	select count(id_cliente) from Cliente;
end //
DELIMITER ;

call contagem_clientes();

-- 12. Consultar quais os clientes que vivem num dado distrito
drop procedure if exists clientes_distrito;
DELIMITER //
create procedure clientes_distrito(in dist varchar(45))
begin
	select * from Cliente
	where distrito = dist;
end //
DELIMITER ;

call clientes_distrito('Porto');

-- 13. Obter o número de clientes que vivem em cada distrito
drop procedure if exists clientes_por_distrito;
DELIMITER //
create procedure clientes_por_distrito()
begin
	select distrito, count(id_cliente)
	from Cliente
	group by distrito;
end //
DELIMITER ;

call clientes_por_distrito();

-- 14. Consultar os artigos por tipo
-- tipo especifico, ordenado por preço ascendente, classificacao descendente, com limites inferior e superior de preço
drop procedure if exists pesquisa_por_tipo;
DELIMITER //
create procedure pesquisa_por_tipo(in tipo_artigo varchar(45), in inf int, in sup int)
begin
select titulo as Título, preco as Preço,
ano as Publicado, classificacao as Classificação
from Artigo
where tipo = tipo_artigo and preco between inf and sup
order by preco ASC, classificacao DESC;
end //
DELIMITER ;

call pesquisa_por_tipo('Livro',10,20);

-- 15. Consultar os artigos que não têm stock disponível
drop procedure if exists stock_indisponivel;
DELIMITER //
create procedure stock_indisponivel()
begin
	select a.id_artigo, a.titulo, a.tipo, a.preco, s.loja, s.distrito from Artigo a
	join Stock s on a.id_artigo = s.id_artigo
	where s.qtd_disponivel = 0;
end //
DELIMITER ;

call stock_indisponivel();

-- 16. Obter o top 3 dos clientes com mais artigos comprados
drop procedure if exists top_clientes_quantidade;
DELIMITER //
create procedure top_clientes_quantidade()
begin
	select cl.id_cliente, cl.nome, sum(cx.quantidade) as `quantidade total` from Cliente cl
	join Compra co on cl.id_cliente = co.id_cliente
	join Compra_de_X_Artigos cx on co.id_compra = cx.id_compra
	group by cl.id_cliente
	order by sum(cx.quantidade) DESC
	limit 3;
end //
DELIMITER ;

call top_clientes_quantidade();

-- 17. Obter o top 3 dos clientes que mais dinheiro gastaram
drop procedure if exists top_clientes_montante;
DELIMITER //
create procedure top_clientes_montante()
begin
	select cl.id_cliente, cl.nome, sum(co.montante) as `montante total` from Cliente cl
	join Compra co on cl.id_cliente = co.id_cliente
	group by cl.id_cliente
	order by sum(co.montante) DESC
	limit 3;
end //
DELIMITER ;

call top_clientes_montante();

-- 18. views.sql

-- 19. Obter o top 3 artigos mais vendidos de um tipo específico
drop procedure if exists top_artigos_tipo;
DELIMITER //
create procedure top_artigos_tipo(in t varchar(45))
begin
	select a.id_artigo, titulo, tipo, preco, sum(co.montante) as `montante total` from Artigo a
	join Compra_de_X_Artigos cx on cx.id_artigo = a.id_artigo
	join Compra co on co.id_compra = cx.id_compra
	group by a.id_artigo having a.tipo = t
	order by sum(co.montante) DESC
	limit 3;
end //
DELIMITER ;

call top_artigos_tipo('Livro');

-- 20. Consultar a disponibilidade de um artigo em todas as lojas
drop procedure if exists verifica_stock;
DELIMITER //
create procedure verifica_stock(in id int)
begin
	select * from Stock where id_artigo = id;
end //
DELIMITER ;

call verifica_stock(1);

-- 21. Consultar livros de um autor específico
drop procedure if exists livros_autor;
DELIMITER //
create procedure livros_autor(in autor varchar(45))
begin
select a.titulo as Título, a.preco as Preço,
a.ano as Publicado, a.classificacao as Classificação,
l.genero as Género, l.editora as Editora, l.n_paginas as Nº_Páginas
from Livro l join Artigo a on a.id_artigo = l.id_artigo
where l.autor = autor
order by a.titulo ASC;
end //
DELIMITER ;

call livros_autor('Jane Austen');

-- 22. Verificar que jogos o cliente tem idade mínima para comprar
drop procedure if exists jogos_permitidos;
DELIMITER //
create procedure jogos_permitidos(in id int)
begin
	select * from jogos_titulo_asc j, Cliente c
	where c.id_cliente = id
    and idade(c.data_nascimento) >= j.`Idade Mínima`;
end //
DELIMITER ;

call jogos_permitidos(1);

-- 23. views.sql

-- 24. Consultar quanto foi vendido numa loja específica num dado ano
drop procedure if exists vendas_loja;
DELIMITER //
create procedure vendas_loja(in ano int)
begin
	select c.loja as Loja, sum(x.quantidade) as Quantidade, sum(c.montante) as `Total Faturado`
	from Compra c join Compra_de_X_Artigos x on c.id_compra = x.id_compra
	where year(c.data_hora) = ano
	group by c.loja;
end //
DELIMITER ;

call vendas_loja(2019);

-- 25. Consultar quanto foi vendido em cada mês num ano específico
-- quanto foi vendido (qtd e preco) em cada mês no ano x
drop procedure if exists vendas_mes;
DELIMITER //
create procedure vendas_mes(in ano int)
begin
	select month(c.data_hora) as Mês, sum(x.quantidade) as Quantidade, sum(c.montante) as `Total Faturado`
	from Compra c join Compra_de_X_Artigos x on c.id_compra = x.id_compra
	where year(c.data_hora) = ano
	group by month(c.data_hora);
end //
DELIMITER ;

call vendas_mes(2019);

-- 26. Verificar a existência de stock de um certo artigo no distrito de um certo cliente
-- verifica a existência de stock de um artigo Y perto de um cliente X (no mesmo distrito)
drop procedure if exists stock_near_me;
DELIMITER //
create procedure stock_near_me(in id_c int, in id_a int)
begin
	select s.loja as Loja, s.qtd_disponivel as `Stock`
    from Cliente c, Stock s
    where s.id_artigo = id_a
    and c.id_cliente = id_c
    and s.distrito = c.distrito
    and s.qtd_disponivel > 0;
end //
DELIMITER ;

call stock_near_me(11,1);

-- 27. Fazer análise das vendas de cada ano (loja que lucrou mais: qual o lucro e a média entre lojas de cada ano)
-- por cada ano:
-- que loja lucrou mais?
-- quanto lucro?
-- qual foi a média entre lojas desse ano?
drop procedure if exists analise_anual;
DELIMITER //
create procedure analise_anual()
begin

	declare ano int;
	declare done bool;
    
    declare curs1 cursor for
		select year(data_hora) from Compra group by year(data_hora);
	declare continue handler for not found set done = true;
    
    drop table if exists `Análise Anual`;
    create table `Análise Anual` (`Ano` int, `Loja` varchar(45), `Maior Lucro` decimal(7,2), `Média` decimal(6,2));
    
    open curs1;
    loop_name: loop
    fetch curs1 into ano;
    
    if done then
		leave loop_name;
	end if;
    
    insert into `Análise Anual` (Ano, Loja, `Maior Lucro`, `Média`)
		(select ano, get_loja.l, results.x, results.average
		from (select ano, max(total) as x, avg(total) as average
			  from (select loja, sum(montante) as total
					from Compra
					where year(data_hora) = ano
					group by loja
					) as linha
			  ) as results
		join (select loja as l, ano, sum(montante) as total
			  from Compra
              where ano = year(data_hora)
			  group by year(data_hora), loja
			 ) as get_loja
		on results.x = get_loja.total
		);
    
    end loop;
    close curs1;
    
    select * from `Análise Anual`;
    drop table `Análise Anual`;

end //
DELIMITER ;

call analise_anual();