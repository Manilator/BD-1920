// 11. Obter o número de clientes total

MATCH (c:Cliente) RETURN count(c);

// 12. Consultar quais os clientes que vivem num dado distrito

MATCH (c:Cliente{distrito: 'Porto'}) return c;

// 13. Obter o número de clientes que vivem em cada distrito

MATCH (c:Cliente)
RETURN c.distrito, count(c);

// 14. Consultar os artigos por tipo

MATCH (f:Filme) RETURN f;
MATCH (l:Livro) RETURN l;
MATCH (j:Jogo) RETURN j;
MATCH (m:Musica) RETURN m;

// 15. Consultar os artigos que não têm stock disponível

MATCH (a)-[r:TEM_STOCK{qtd_disponivel: 0}]-(l)
RETURN a, r, l;

// 16. Obter o top 3 dos clientes com mais artigos comprados

MATCH (cl:Cliente)-[f:FAZ]-(co:Compra)-[d:DE]-(x)
RETURN cl, sum(d.quantidade)
ORDER BY sum(d.quantidade) DESC
LIMIT 3;

// 17. Obter o top 3 dos clientes que mais dinheiro gastaram

MATCH (cl:Cliente)-[f:FAZ]-(co:Compra)
RETURN cl, sum(co.montante)
ORDER BY sum(co.montante) DESC
LIMIT 3;

// 18. Obter o top 3 artigos mais vendidos

MATCH (co:Compra)-[d:DE]-(x)
RETURN x, sum(d.quantidade)
ORDER BY sum(d.quantidade) DESC
LIMIT 3;

// 19. Obter o top 3 artigos mais vendidos de um tipo específico

// Filme:
MATCH (co:Compra)-[d:DE]-(f:Filme)
RETURN f, sum(d.quantidade)
ORDER BY sum(d.quantidade) DESC
LIMIT 3;
// Jogo:
MATCH (co:Compra)-[d:DE]-(j:Jogo)
RETURN j, sum(d.quantidade)
ORDER BY sum(d.quantidade) DESC
LIMIT 3;
// Livro:
MATCH (co:Compra)-[d:DE]-(l:Livro)
RETURN l, sum(d.quantidade)
ORDER BY sum(d.quantidade) DESC
LIMIT 3;
// Musica:
MATCH (co:Compra)-[d:DE]-(m:Musica)
RETURN m, sum(d.quantidade)
ORDER BY sum(d.quantidade) DESC
LIMIT 3;

// 20. Consultar a disponibilidade de um artigo em todas as lojas

MATCH (x{id_artigo: 1})-[t:TEM_STOCK]-(l:Loja)
RETURN x, t.qtd_disponivel, l;

// 21. Consultar livros de um autor específico

MATCH (l:Livro{autor: 'John Green'})
RETURN l;

// 22. Verificar que jogos o cliente tem idade mínima para comprar

MATCH (j:Jogo),(c:Cliente{id_cliente: 1})
WHERE j.idade_min <= duration.between(date(c.data_nascimento),date()).years
RETURN j;

// 23. Análise das vendas de cada autor (quantidade e montante totais)

MATCH (cl:Cliente)-[f:FAZ]-(co:Compra)-[d:DE]-(l:Livro)
RETURN l.autor, sum(d.quantidade), sum(co.montante)
ORDER BY sum(d.quantidade) DESC, sum(co.montante) DESC;

// 24. Consultar quanto foi vendido numa loja específica num ano específico

MATCH (c:Compra)
WHERE (datetime(REPLACE(c.data_hora," ","T"))).year = 2019
AND c.loja = "Gaia Shopping"
RETURN sum(c.montante);

// 25. Consultar quanto foi vendido em cada mês num ano específico

MATCH (c:Compra)
WHERE (datetime(REPLACE(c.data_hora," ","T"))).year = 2019
RETURN (datetime(REPLACE(c.data_hora," ","T"))).month AS mes, sum(c.montante)
ORDER BY mes;

// 26. Verificar a existência de stock de um certo artigo no distrito de um certo cliente

MATCH (c:Cliente{id_cliente:1}),(x{id_artigo: 1})-[t:TEM_STOCK]-(l:Loja)
WHERE c.distrito = l.distrito
RETURN x, t.qtd_disponivel, l;

// 27. Fazer análise das vendas de cada ano (loja que lucrou mais: qual o lucro e a média entre lojas de cada ano)

// ?