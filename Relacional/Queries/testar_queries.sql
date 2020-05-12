Use FNAC;

-- 11. Obter o número de clientes total
call contagem_clientes();

-- 12. Consultar quais os clientes que vivem num dado distrito
call clientes_distrito('Porto');

-- 13. Obter o número de clientes que vivem em cada distrito
call clientes_por_distrito();

-- 14. Consultar os artigos por tipo
call pesquisa_por_tipo('Livro',10,20);

-- 15. Consultar os artigos que não têm stock disponível
call stock_indisponivel();

-- 16. Obter o top 3 dos clientes com mais artigos comprados
call top_clientes_quantidade();

-- 17. Obter o top 3 dos clientes que mais dinheiro gastaram
call top_clientes_montante();

-- 18. Obter o top 3 artigos mais vendidos
select * from top_artigos;

-- 19. Obter o top 3 artigos mais vendidos de um tipo específico
call top_artigos_tipo('Livro');

-- 20.Consultar a disponibilidade de um artigo em todas as lojas
call verifica_stock(1);

-- 21. Consultar livros de um autor específico
call livros_autor('Jane Austen');

-- 22. Verificar que jogos o cliente tem idade mínima para comprar
call jogos_permitidos(1);

-- 23. quanto cada autor já vendeu no total (quantidade e montante total) ordenado por lucro total e qtd decrescente
select * from top_vendas_autor;

-- 24. Consultar quanto foi vendido numa loja específica num dado ano
call vendas_loja(2019);

-- 25. Consultar quanto foi vendido em cada mês num ano específico
call vendas_mes(2019);

-- 26. Verificar a existência de stock de um certo artigo no distrito de um certo cliente
call stock_near_me(11,1);

-- 27. Fazer análise das vendas de um ano (loja que lucrou mais: qual o lucro e a média entre lojas desse ano)
call analise_anual();