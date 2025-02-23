-- Consultas: 10 consultas variadas de acordo com requisitos da aplicação, 
-- com justificativa semântica e conforme critérios seguintes:

-- 1 consulta com uma tabela usando operadores básicos de filtro (e.g., IN, between, is null, etc).
SELECT * 
FROM Bem_cultural 
WHERE Seculo IN (17, 18) 
AND Descricao IS NOT NULL;

-- 3 consultas com inner JOIN na cláusula FROM (pode ser self join, caso o domínio indique esse uso).
-- consulta 1:
SELECT B.Nome AS "Bem Cultural", C.Nome AS "Categoria"
FROM Bem_cultural B
INNER JOIN Categoria C ON B.IdCategoria = C.IdCategoria;
-- consulta 2:
SELECT B.Nome AS "Bem Cultural", R.Nome AS "Região", R.UF
FROM Bem_cultural B
INNER JOIN Bem_cultural_material BM ON B.IdBem = BM.IdBem
INNER JOIN Regiao R ON B.IdRegiao = R.IdRegiao;
-- consulta 3:
SELECT R.Nome AS "Responsável", B.Nome AS "Bem Cultural"
FROM Responsavel R
INNER JOIN Bem_cultural B ON R.IdResponsavel = B.IdResponsavel;

-- 1 consulta com left/right/full outer join na cláusula FROM
-- retorna todos os bens culturais, mesmo que nao estejam associados a eventos historicos
SELECT B.Nome AS "Bem Cultural", E.Nome AS "Evento Histórico"
FROM Bem_cultural B
LEFT JOIN Evento_historico E ON B.IdEvento = E.IdEvento;

-- 2 consultas usando Group By (e possivelmente o having)
-- consulta 1:
SELECT C.Nome AS "Categoria", COUNT(B.IdBem) AS "Total de Bens"
FROM Bem_cultural B
INNER JOIN Categoria C ON B.IdCategoria = C.IdCategoria
GROUP BY C.Nome;
-- consulta 2:
SELECT R.Nome AS "Região", COUNT(B.IdBem) AS "Quantidade de Bens"
FROM Bem_cultural B
INNER JOIN Regiao R ON B.IdRegiao = R.IdRegiao
GROUP BY R.Nome
HAVING COUNT(B.IdBem) > 1; -- retorna as regiões que possuem mais de um bem cultural cadastrado 


-- 1 consulta usando alguma operação de conjunto (union, except ou intersect)
SELECT B.IdBem, B.Nome, 'Material' AS Tipo
FROM Bem_cultural B
INNER JOIN Bem_cultural_material BM ON B.IdBem = BM.IdBem
UNION -- combina os dois conjuntos em uma única lista
SELECT B.IdBem, B.Nome, 'Imaterial' AS Tipo
FROM Bem_cultural B
INNER JOIN Bem_cultural_imaterial BI ON B.IdBem = BI.IdBem;

-- 2 consultas que usem subqueries.
-- consulta 1:
-- retorna os nomes dos bens culturais que pertencem à categoria mais representada na tabela Bem_cultural
SELECT Nome
FROM Bem_cultural
WHERE IdCategoria = (
    SELECT IdCategoria
    FROM Bem_cultural
    GROUP BY IdCategoria
    ORDER BY COUNT(IdBem) DESC -- Conta quantos bens culturais existem em cada categoria; ordena os bens por ordem decrescente, logo, a categoria com maior qtde vão aparecer primeiro
    LIMIT 1 -- Retorna apenas o primeiro grupo, ou seja, a categoria que possui o maior número de bens culturais.
);
-- consulta 2:
SELECT Nome, Seculo
FROM Bem_cultural
WHERE Seculo = (
    SELECT MIN(Seculo) FROM Bem_cultural
);

