-- FUNÇÕES E PROCEDURES ARMAZENADAS

-- Funções que usam SUM, MAX, MIN, AVG ou COUNT
CREATE OR REPLACE FUNCTION contar_bens_por_categoria(p_categoria_id INT)
RETURNS INT AS $$
DECLARE
    v_contagem INT;
BEGIN
    SELECT COUNT(*) INTO v_contagem 
    FROM Bem_cultural 
    WHERE IdCategoria = p_categoria_id;

    RETURN v_contagem;
END;
$$ LANGUAGE plpgsql;

SELECT contar_bens_por_categoria(1);

-- Função: Obter o bem cultural mais antigo registrado
CREATE OR REPLACE FUNCTION bem_cultural_mais_antigo()
RETURNS TABLE(IdBem INT, Nome VARCHAR, Seculo INT) AS $$
BEGIN
    RETURN QUERY 
    SELECT bc.IdBem, bc.Nome, bc.Seculo
    FROM Bem_cultural bc
    ORDER BY bc.Seculo ASC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM bem_cultural_mais_antigo();

-- Função: Verificar se um bem cultural está associado a um evento histórico
CREATE OR REPLACE FUNCTION verificar_evento_bem(p_bem_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    v_existe INT;
BEGIN
    SELECT COUNT(*) INTO v_existe 
    FROM Bem_cultural
    WHERE IdBem = p_bem_id AND IdEvento IS NOT NULL;

    RETURN v_existe > 0;
END;
$$ LANGUAGE plpgsql;

SELECT verificar_evento_bem(2);

-- Procedure: Inserir um novo bem cultural com tratamento de exceção
CREATE OR REPLACE PROCEDURE inserir_bem_cultural(
    p_nome VARCHAR,
    p_descricao TEXT,
    p_data_origem VARCHAR,
    p_seculo INT,
    p_id_categoria INT,
    p_id_regiao INT,
    p_id_responsavel INT
) AS $$
BEGIN
    -- Verificar se a categoria existe
    IF NOT EXISTS (SELECT 1 FROM Categoria WHERE IdCategoria = p_id_categoria) THEN
        RAISE EXCEPTION 'Categoria % não existe', p_id_categoria;
    END IF;

    -- Verificar se a região existe
    IF NOT EXISTS (SELECT 1 FROM Regiao WHERE IdRegiao = p_id_regiao) THEN
        RAISE EXCEPTION 'Região % não existe', p_id_regiao;
    END IF;

    -- Inserir o bem cultural
    INSERT INTO Bem_cultural (Nome, Descricao, DataOrigem, Seculo, IdCategoria, IdRegiao, IdResponsavel)
    VALUES (p_nome, p_descricao, p_data_origem, p_seculo, p_id_categoria, p_id_regiao, p_id_responsavel);

    RAISE NOTICE 'Bem cultural % inserido com sucesso!', p_nome;
END;
$$ LANGUAGE plpgsql;

CALL inserir_bem_cultural('Museu Imperial', 'Museu do século XIX', 'Século XIX', 19, 1, 2, 1);

-- TRIGGERS

-- Impedir a inserção de bens culturais sem responsável
CREATE OR REPLACE FUNCTION validar_responsavel()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.IdResponsavel IS NULL THEN
        RAISE EXCEPTION 'Todo bem cultural precisa ter um responsável!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_responsavel
BEFORE INSERT ON Bem_cultural
FOR EACH ROW
EXECUTE FUNCTION validar_responsavel();

INSERT INTO Bem_cultural (Nome, Descricao, DataOrigem, Seculo, IdCategoria, IdRegiao, IdResponsavel) 
VALUES ('Forte de Santa Catarina', 'Forte militar histórico', '1589', 16, 1, 1, NULL); -- ERRO

-- Atualizar estado de conservação automaticamente
CREATE OR REPLACE FUNCTION atualizar_estado_conservacao()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.EstadoConservacao = 'Ruim' THEN
        RAISE NOTICE 'Alerta: Bem cultural % precisa de restauração!', NEW.IdBem;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_estado_conservacao
AFTER UPDATE ON Bem_cultural_material
FOR EACH ROW
WHEN (NEW.EstadoConservacao = 'Ruim')
EXECUTE FUNCTION atualizar_estado_conservacao();

UPDATE Bem_cultural_material SET EstadoConservacao = 'Ruim' WHERE IdBem = 1;

-- Registrar alterações em eventos históricos
CREATE TABLE Log_Evento (
    IdLog SERIAL PRIMARY KEY,
    IdEvento INT,
    NomeAntigo VARCHAR(25),
    NomeNovo VARCHAR(25),
    DataAlteracao TIMESTAMP DEFAULT NOW()
);

ALTER TABLE Log_Evento
  ALTER COLUMN NomeAntigo TYPE VARCHAR(100),
  ALTER COLUMN NomeNovo TYPE VARCHAR(100);

CREATE OR REPLACE FUNCTION log_alteracao_evento()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Evento (IdEvento, NomeAntigo, NomeNovo)
    VALUES (OLD.IdEvento, OLD.Nome, NEW.Nome);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_evento
AFTER UPDATE ON Evento_historico
FOR EACH ROW
EXECUTE FUNCTION log_alteracao_evento();

UPDATE Evento_historico SET Nome = 'Revolução Pernambucana de 1817' WHERE IdEvento = 1;

SELECT * FROM Log_Evento;
