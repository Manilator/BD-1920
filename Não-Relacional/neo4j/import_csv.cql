// Criar FNAC

// Criar clientes
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/cliente.csv" AS row
CREATE (:Cliente {id_cliente: toInteger(row.id_cliente), nome: row.nome, data_nascimento: row.data_nascimento, data_subscricao: row.data_subscricao, email: row.email, telemovel: toInteger(row.telemovel), distrito: row.distrito});

// Criar compras
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/compra.csv" AS row
CREATE (:Compra {id_compra: toInteger(row.id_compra), montante: toFloat(row.montante), loja: row.loja, data_hora: row.data_hora, id_cliente: toInteger(row.id_cliente)});

// cliente faz compra
MATCH (co:Compra),(cl:Cliente)
WHERE co.id_cliente = cl.id_cliente
CREATE (cl)-[f:FAZ]->(co)
RETURN cl, f, co;

// Criar jogos
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/jogo.csv" AS row
CREATE (:Jogo {id_artigo: toInteger(row.id_artigo), titulo: row.titulo, preco: toFloat(row.preco), ano: toInteger(row.ano),classificacao: toInteger(row.classificacao), plataforma: row.plataforma, idade_min: toInteger(row.idade_min), publisher: row.publisher, n_jogadores_max: toInteger(row.n_jogadores_max), genero: row.genero});

// compra de x jogos
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/compra_de_x_artigos.csv" AS row
MATCH (co:Compra),(j:Jogo)
WHERE co.id_compra = toInteger(row.id_compra)
AND j.id_artigo = toInteger(row.id_artigo)
CREATE (co)-[de:DE {quantidade: toInteger(row.quantidade)}]->(j)
RETURN co, de, j;

// Criar musicas
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/musica.csv" AS row
CREATE (:Musica {id_artigo: toInteger(row.id_artigo), titulo: row.titulo, preco: toFloat(row.preco), ano: toInteger(row.ano), classificacao: toInteger(row.classificacao), genero_musical: row.genero_musical, artista: row.artista, formato: row.formato});

// compra de x musicas
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/compra_de_x_artigos.csv" AS row
MATCH (co:Compra),(m:Musica)
WHERE co.id_compra = toInteger(row.id_compra)
AND m.id_artigo = toInteger(row.id_artigo)
CREATE (co)-[de:DE {quantidade: toInteger(row.quantidade)}]->(m)
RETURN co, de, m;

// Criar livros
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/livro.csv" AS row
CREATE (:Livro {id_artigo: toInteger(row.id_artigo), titulo: row.titulo, preco: toFloat(row.preco), ano: toInteger(row.ano), classificacao: toInteger(row.classificacao), autor: row.autor, genero: row.genero, editora: row.editora, n_paginas: toInteger(row.n_paginas)});

// compra de x livros
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/compra_de_x_artigos.csv" AS row
MATCH (co:Compra),(l:Livro)
WHERE co.id_compra = toInteger(row.id_compra)
AND l.id_artigo = toInteger(row.id_artigo)
CREATE (co)-[de:DE {quantidade: toInteger(row.quantidade)}]->(l)
RETURN co, de, l;

// Criar filmes
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/filme.csv" AS row
CREATE (:Filme {id_artigo: toInteger(row.id_artigo), titulo: row.titulo, preco: toFloat(row.preco), ano: toInteger(row.ano), classificacao: toInteger(row.classificacao), duracao: toInteger(row.duracao), realizador: row.realizador, genero: row.genero});

// compra de x filmes
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/compra_de_x_artigos.csv" AS row
MATCH (co:Compra),(f:Filme)
WHERE co.id_compra = toInteger(row.id_compra)
AND f.id_artigo = toInteger(row.id_artigo)
CREATE (co)-[de:DE {quantidade: toInteger(row.quantidade)}]->(f)
RETURN co, de, f;

// criar lojas
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lojas.csv" AS row
CREATE (:Loja {loja: row.loja, distrito: row.distrito});

// jogo tem x stock na loja
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/stock.csv" AS row
MATCH (j:Jogo),(lo:Loja)
WHERE j.id_artigo = toInteger(row.id_artigo)
AND lo.loja = row.loja
CREATE (j)-[t:TEM_STOCK {qtd_disponivel: toInteger(row.qtd_disponivel)}]->(lo)
RETURN j, t, lo;

// musica tem x stock na loja
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/stock.csv" AS row
MATCH (m:Musica),(lo:Loja)
WHERE m.id_artigo = toInteger(row.id_artigo)
AND lo.loja = row.loja
CREATE (m)-[t:TEM_STOCK {qtd_disponivel: toInteger(row.qtd_disponivel)}]->(lo)
RETURN m, t, lo;

// livro tem x stock na loja
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/stock.csv" AS row
MATCH (l:Livro),(lo:Loja)
WHERE l.id_artigo = toInteger(row.id_artigo)
AND lo.loja = row.loja
CREATE (l)-[t:TEM_STOCK {qtd_disponivel: toInteger(row.qtd_disponivel)}]->(lo)
RETURN l, t, lo;

// filme tem x stock na loja
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/stock.csv" AS row
MATCH (f:Filme),(lo:Loja)
WHERE f.id_artigo = toInteger(row.id_artigo)
AND lo.loja = row.loja
CREATE (f)-[t:TEM_STOCK {qtd_disponivel: toInteger(row.qtd_disponivel)}]->(lo)
RETURN f, t, lo;