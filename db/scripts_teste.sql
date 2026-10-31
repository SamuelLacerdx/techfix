--Ativa as Chaves estrangeiras do Sqlite
PRAGMA foreign_keys=1;

CREATE TABLE cargo(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
status INTEGER NOT NULL DEFAULT 1) 
STRICT;

CREATE TABLE funcionario(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_funcionario TEXT NOT NULL COLLATE NOCASE, 
id_cargo INTEGER NOT NULL,
status INTEGER NOT NULL DEFAULT 1, 
data_cadastro TEXT NOT NULL DEFAULT(DATETIME ('now', 'localtime' )), 
FOREIGN KEY(id_cargo) REFERENCES cargo(id) ON UPDATE CASCADE ON DELETE CASCADE,
UNIQUE (id, id_cargo)) STRICT;

INSERT INTO cargo (nome_cargo) VALUES ('Gerente'), ('Atendente'), ('Técnico');

INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES
('Carlos Silva', 1),
('Ana Souza', 2),
('Bruno Lima', 2),
('Diego Santos', 3),
('Felipe Costa', 3),
('Sarah Oliveira', 3);

CREATE TABLE cliente(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_cliente TEXT NOT NULL COLLATE NOCASE,
    email TEXT NOT NULL COLLATE NOCASE UNIQUE,
    id_funcionario INTEGER NOT NULL,
--    CHECK: Avalia se o usuario inserido tem o id de cargo definido na tabela de Funcionario
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT(DATETIME ('now', 'localtime')),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;

INSERT
	INTO
	cliente (nome_cliente,
	email,
	id_funcionario,
	id_funcionario_cargo)
VALUES
('João Pereira',
'joao.pereira@email.com',
1,
(
SELECT
	id_cargo
FROM
	funcionario
WHERE
	id = 1));

CREATE TABLE categoria(
id INTEGER PRIMARY KEY  AUTOINCREMENT,
nome_categoria TEXT NOT NULL COLLATE NOCASE UNIQUE,
id_funcionario INTEGER NOT NULL,
id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
status INTEGER NOT NULL DEFAULT 1,
data_cadastro TEXT NOT NULL DEFAULT(DATETIME ('now', 'localtime' )),
FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
)STRICT;


INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES 
    ('computadores', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('celulares', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('smart tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('redes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('videogames', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('áudio', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('recuperação de dados', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('eletrônica avançada', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('informática', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('insumos', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('acessórios', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('telas', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('baterias', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('componentes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('carcaças', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1)),
    ('tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

CREATE TABLE servicos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_servico TEXT NOT NULL UNIQUE,
    id_categoria INTEGER NOT NULL,
    preco INTEGER NOT NULL,
    horas_trabalho REAL NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    status INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id)
) STRICT;

INSERT INTO servicos (nome_servico, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo) VALUES
('Formatação e Instalação de Sistema Operacional', 1, 12000, 2.0, 1, 1),
('Limpeza Interna e Troca de Pasta Térmica', 1, 15000, 1.5, 1, 1),
('Upgrade de Hardware (RAM/SSD)', 1, 8000, 1.0, 1, 1),
('Remoção de Vírus e Malwares', 1, 10000, 1.5, 1, 1),
('Troca de Tela de Notebook', 1, 18000, 1.5, 1, 1),
('Troca de Display/Frontal de Celular', 2, 15000, 1.0, 1, 1),
('Troca de Bateria de Smartphone', 2, 9000, 0.5, 1, 1),
('Desoxidação após Contato com Líquido', 2, 20000, 3.0, 1, 1),
('Reparo em Conector de Carga (Micro USB / Type-C)', 2, 11000, 1.5, 1, 1),
('Troca de Barra de LED de Smart TV', 3, 35000, 3.0, 1, 1),
('Reparo na Placa Principal de Smart TV', 3, 28000, 2.5, 1, 1),
('Conserto de Fonte de Alimentação Interna (TV)', 3, 22000, 2.0, 1, 1),
('Configuração de Rede e Roteador Wi-Fi', 4, 9000, 1.0, 1, 1),
('Higienização e Troca de Metal Líquido / Pasta Térmica (Console)', 5, 22000, 2.0, 1, 1),
('Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)', 5, 8000, 1.0, 1, 1),
('Substituição de HDMI / Conector de Vídeo (Console)', 5, 25000, 2.5, 1, 1),
('Troca de Bateria de Caixa de Som Portátil (Bluetooth)', 6, 12000, 1.5, 1, 1),
('Troca de Almofadas / Reparo de Cabo de Headset Gamer', 6, 7000, 1.0, 1, 1),
('Recuperação de Dados de HD / SSD / Pendrive Danificado', 7, 30000, 4.0, 1, 1),
('Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo', 8, 45000, 5.0, 1, 1),
('Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)', 8, 16000, 2.0, 1, 1),
('Troca de Vidro Traseiro de Smartphone a Laser / Manual', 2, 18000, 2.5, 1, 1),
('Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador', 6, 9500, 1.0, 1, 1);

CREATE TABLE peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_peca TEXT NOT NULL COLLATE NOCASE UNIQUE,
    id_categoria INTEGER NOT NULL,
    preco_venda INTEGER NOT NULL,
    estoque_atual INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    status INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id)
) STRICT;

INSERT INTO peca (nome_peca, id_categoria, preco_venda, estoque_atual, id_funcionario, id_funcionario_cargo) VALUES
('Display Frontal Completo iPhone 11', 12, 35000, 4, 1, 1),
('Display Frontal Completo Samsung Galaxy A54', 12, 31000, 6, 1, 1),
('Display Frontal Completo Motorola Moto G84', 12, 28000, 5, 1, 1),
('Bateria Compatível iPhone 11 (3110mAh)', 13, 16000, 8, 1, 1),
('Bateria Compatível Samsung Galaxy A32', 13, 13000, 7, 1, 1),
('Bateria Compatível Moto G30', 13, 12000, 6, 1, 1),
('Conector de Carga Type-C Universal (Unidade)', 14, 2000, 100, 1, 1),
('Conector de Carga Micro USB V8', 14, 1500, 100, 1, 1),
('Flex de Carga e Microfone Moto G9 Play', 14, 5500, 10, 1, 1),
('Tampa Traseira de Vidro iPhone 12', 15, 11000, 4, 1, 1),
('Câmera Traseira Principal Redmi Note 11', 14, 14000, 3, 1, 1),
('Alto-Falante Auricular Universal', 14, 2500, 40, 1, 1),
('Barra de LED TV Samsung 50" (Kit com 3 barras)', 16, 23000, 4, 1, 1),
('Barra de LED TV LG 43" (Kit com 3 barras)', 16, 19500, 5, 1, 1),
('Placa Fonte TV Samsung UN50TU8000', 16, 31000, 2, 1, 1),
('Placa Principal TV LG 43UP7500', 16, 42000, 2, 1, 1),
('Cabo Flat T-Con para Display TV 55"', 16, 6500, 8, 1, 1),
('Receptor Infravermelho para Controle Remoto TV', 14, 2000, 15, 1, 1),
('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', 10, 15000, 3, 1, 1),
('Álcool Isopropílico 99.8% 1 Litro', 10, 4500, 12, 1, 1),
('Fita Kapton Térmica 10mm x 33m', 10, 3000, 15, 1, 1),
('Fita Dupla Face Fixação de Telas (3mm x 50m)', 10, 3500, 10, 1, 1),
('Fusível de Louça 5A 250V (Pacote c/ 10)', 14, 1800, 20, 1, 1),
('Capacitor Eletrolítico 1000uF x 25V', 14, 500, 150, 1, 1),
('SSD NVMe 512GB M.2', 9, 26000, 15, 1, 1),
('SSD SATA III 480GB 2.5"', 9, 21000, 20, 1, 1),
('Memória RAM DDR4 8GB 2666MHz (Notebook)', 9, 17000, 12, 1, 1),
('Memória RAM DDR4 16GB 3200MHz (Desktop)', 9, 32000, 8, 1, 1),
('Pasta Térmica de Alta Performance (Bisnaga 4g)', 10, 6000, 25, 1, 1),
('Fonte ATX 500W 80 Plus Bronze', 9, 34000, 6, 1, 1),
('Bateria Célula Moeda CR2032 (Cartela c/ 5)', 10, 2500, 30, 1, 1),
('Cooler para Processador Socket Universal', 9, 9500, 10, 1, 1),
('Cabo SATA III 6Gbps 50cm', 11, 1500, 50, 1, 1),
('Tela LED 15.6" Slim 30 Pinos Full HD', 12, 48000, 5, 1, 1);

SELECT * FROM peca p WHERE p.preco_venda >= 10000;

CREATE VIEW vw_preco_venda_maior_100 AS 
SELECT id, nome_peca, preco_venda AS 'Preço', estoque_atual FROM peca p WHERE p.preco_venda >= 10000;


SELECT * FROM vw_preco_venda_maior_100;

CREATE TABLE marca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_marca TEXT NOT NULL COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;

CREATE TABLE modelo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_modelo TEXT NOT NULL COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;

CREATE TABLE tipo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_tipo TEXT NOT NULL COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;

CREATE TABLE equipamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_equipamento TEXT NOT NULL COLLATE NOCASE,
    id_cliente INTEGER NOT NULL,
    id_marca INTEGER NOT NULL,
    id_modelo INTEGER NOT NULL,
    id_tipo INTEGER NOT NULL,
    id_funcionario integer NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    sn TEXT COLLATE NOCASE,
    imei TEXT COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    FOREIGN KEY (id_marca) REFERENCES marca (id),
    FOREIGN KEY (id_modelo) REFERENCES modelo (id),
    FOREIGN KEY (id_tipo) REFERENCES tipo (id),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;

INSERT INTO marca (nome_marca, id_funcionario, id_funcionario_cargo) VALUES
    ('Apple', 1, 1), 
    ('Samsung', 2, 2),
    ('Dell', 3, 2);

INSERT INTO modelo (nome_modelo, id_funcionario, id_funcionario_cargo) VALUES
    ('iPhone 15 Pro', 1, 1),  
    ('Galaxy S24', 2, 2),     
    ('Inspiron 15', 3, 2);

INSERT INTO tipo (nome_tipo, id_funcionario, id_funcionario_cargo) VALUES
    ('Smartphone', 1, 1),
    ('Notebook', 1, 1),
    ('Tablet', 1, 1);       

INSERT INTO equipamento (
    nome_equipamento,
    id_cliente, 
    id_marca, 
    id_modelo, 
    id_tipo, 
    id_funcionario, 
    id_funcionario_cargo, 
    sn, 
    imei
) VALUES 
    ('iPhone 15 Pro', 1, 1, 1, 1, 1, 1, 'SN-APP-00192', '356789101112131'), 
    ('Galaxy S24', 1, 2, 2, 1, 2, 2, 'SN-SAM-88201', '356789101112132'), 
    ('Inspiron 15', 1, 3, 3, 2, 3, 2, 'SN-DEL-99102', NULL);
SELECT 
    e.id AS id_equipamento,
    c.nome_cliente,
    m.nome_marca,
    mo.nome_modelo,
    t.nome_tipo,
    f.nome_funcionario,
    e.sn,
    e.imei,
    e.data_cadastro
FROM equipamento e
INNER JOIN cliente c ON e.id_cliente = c.id
INNER JOIN marca m ON e.id_marca = m.id
INNER JOIN modelo mo ON e.id_modelo = mo.id
INNER JOIN tipo t ON e.id_tipo = t.id
INNER JOIN funcionario f ON e.id_funcionario = f.id;

SELECT 
    m.id,
    m.nome_marca,
    f.nome_funcionario AS cadastrado_por,
    m.status,
    m.data_cadastro
FROM marca m
INNER JOIN funcionario f ON m.id_funcionario = f.id;

SELECT 
    mo.id,
    mo.nome_modelo,
    f.nome_funcionario AS cadastrado_por,
    mo.status,
    mo.data_cadastro
FROM modelo mo
INNER JOIN funcionario f ON mo.id_funcionario = f.id;

SELECT 
    t.id,
    t.nome_tipo,
    f.nome_funcionario AS cadastrado_por,
    t.status,
    t.data_cadastro
FROM tipo t
INNER JOIN funcionario f ON t.id_funcionario = f.id;

CREATE TABLE situacao(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_situacao TEXT NOT NULL COLLATE NOCASE,
	status INTEGER NOT NULL DEFAULT 1
) STRICT;

CREATE TABLE forma_pagamento(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_forma_pagamento TEXT NOT NULL COLLATE NOCASE,
	id_funcionario integer NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;

CREATE TABLE ordem_servico(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
	id_equipamento INTEGER NOT NULL,
	id_funcionario_abertura INTEGER NOT NULL,
	id_cargo_abertura INTEGER NOT NULL CHECK (id_cargo_abertura = 1 OR id_cargo_abertura = 2),
	id_tecnico INTEGER NOT NULL,
	id_cargo_tecnico INTEGER NOT NULL CHECK (id_cargo_tecnico = 3),  
	data_abertura TEXT NOT NULL DEFAULT(DATETIME ('now', 'localtime') ),
	data_fechamento TEXT,
	descricao_defeito TEXT NOT NULL,
	defeito_costatado TEXT NULL,
	valor_total INTEGER NULL,
	id_pagamento INTEGER NOT NULL,
	id_situacao_atual INTEGER NOT NULL,
	id_servico INTEGER NOT NULL,
	
	FOREIGN KEY (id_servico) REFERENCES servicos (id),
	FOREIGN KEY (id_equipamento) REFERENCES equipamento (id),
    FOREIGN KEY (id_funcionario_abertura, id_cargo_abertura) REFERENCES funcionario (id, id_cargo),
    FOREIGN KEY (id_tecnico, id_cargo_tecnico) REFERENCES funcionario (id, id_cargo),
    FOREIGN KEY (id_pagamento) REFERENCES forma_pagamento (id),
    FOREIGN KEY (id_situacao_atual) REFERENCES situacao (id)

	)STRICT;
	
CREATE TABLE ordem_peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_peca INTEGER NOT NULL,
    id_ordem_servico INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_cargo_tecnico INTEGER NOT NULL CHECK (id_cargo_tecnico = 3),
    data_saida TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    quantidade INTEGER NOT NULL,
	valor_unitario INTEGER NOT NULL,
    FOREIGN KEY (id_peca) REFERENCES peca (id),
    FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id),
    FOREIGN KEY (id_tecnico, id_cargo_tecnico) REFERENCES funcionario (id, id_cargo)
) STRICT;

CREATE TABLE entrada_peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_peca INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_de_compra INTEGER NOT NULL CHECK (preco_de_compra >= 0),
    preco_venda_sugerido INTEGER NOT NULL CHECK (preco_venda_sugerido >= 0),
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_peca) REFERENCES peca (id),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
) STRICT;
 

CREATE TABLE saida_peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_peca INTEGER NOT NULL,
    quantidade_saida INTEGER NOT NULL CHECK (quantidade_saida > 0),
    valor_unitario INTEGER NOT NULL CHECK (valor_unitario >= 0),
    id_situacao INTEGER NOT NULL DEFAULT 8 CHECK (id_situacao = 8),
    id_tecnico INTEGER NOT NULL,
    id_cargo_tecnico INTEGER NOT NULL CHECK (id_cargo_tecnico = 3),
    data_saida TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_peca) REFERENCES peca (id),
    FOREIGN KEY (id_situacao) REFERENCES situacao (id),
    FOREIGN KEY (id_tecnico, id_cargo_tecnico) REFERENCES funcionario (id, id_cargo)
) STRICT;

CREATE TABLE ordem_situacao(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_situacao INTEGER NOT NULL,
    id_ordem_servico INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    data_situacao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario (id)
    FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id),
	FOREIGN KEY (id_situacao) REFERENCES situacao (id)
) STRICT;	

CREATE TABLE servico_ordem_servico (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_servico INTEGER NOT NULL,
    id_ordem_servico INTEGER NOT NULL,
    preco INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    data_execucao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
   	FOREIGN KEY (id_servico) REFERENCES servicos (id),
    FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id)
);

INSERT INTO situacao (nome_situacao) VALUES 
('Aberto'),
('Em Diagnóstico'),
('Orçamento Aprovado'),
('Em Reparo'),
('Pronto'),
('Entregue'),
('Cancelado'),
('Descarte por Defeito/Avaria'),
('Uso em Reparo (OS)');



INSERT INTO forma_pagamento (nome_forma_pagamento, id_funcionario, id_funcionario_cargo) VALUES 
('Dinheiro', 1, 1),
('PIX', 1, 1),
('Cartão de Crédito', 1, 1),
('Cartão de Débito', 1, 1),
('Transferência Bancária', 1, 1);


INSERT INTO ordem_servico (
    id_equipamento, id_funcionario_abertura, id_cargo_abertura, 
    id_tecnico, id_cargo_tecnico, data_abertura, data_fechamento, 
    descricao_defeito, defeito_costatado, valor_total, 
    id_pagamento, id_situacao_atual, id_servico
) VALUES
(1, 1, 1, 4, 3, '2026-06-01 08:30:00', '2026-06-03 17:00:00', 'Computador não liga após queda de energia.', 'Fonte de alimentação queimada.', 35000, 1, 3, 1),
(2, 1, 1, 4, 3, '2026-06-05 10:15:00', NULL, 'Notebook travando na tela de inicialização.', 'SSD com setores defeituosos.', NULL, 2, 1, 1);

-- (triggers de serviço agora definidos na seção de triggers, mais abaixo)


-- 1) Totais de serviço (INSERT / DELETE / UPDATE em servico_ordem_servico)
CREATE TRIGGER trg_ai_servico_ordem_servico_atualiza_valor_total_ordem_servico
AFTER INSERT ON servico_ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0) + (NEW.preco * NEW.quantidade)
    WHERE id = NEW.id_ordem_servico;
END;

CREATE TRIGGER trg_ad_servico_ordem_servico_atualiza_valor_total_ordem_servico
AFTER DELETE ON servico_ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0) - (OLD.preco * OLD.quantidade)
    WHERE id = OLD.id_ordem_servico;
END;

DROP TRIGGER IF EXISTS trg_au_servico_ordem_servico_atualiza_valor_total_ordem_servico;
CREATE TRIGGER trg_au_servico_ordem_servico_atualiza_valor_total_ordem_servico
AFTER UPDATE OF id_ordem_servico, quantidade, preco ON servico_ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0) - (OLD.preco * OLD.quantidade)
    WHERE id = OLD.id_ordem_servico;

    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0) + (NEW.preco * NEW.quantidade)
    WHERE id = NEW.id_ordem_servico;
END;

-- 2) Validação em ordem_peca (INSERT)
DROP TRIGGER IF EXISTS trg_bi_ordem_peca_valida_estoque;
CREATE TRIGGER trg_bi_ordem_peca_valida_estoque
BEFORE INSERT ON ordem_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Quantidade deve ser maior que zero.')
    WHERE NEW.quantidade <= 0;

    SELECT RAISE(ABORT, 'Ordem encerrada: não é possível adicionar peças.')
    WHERE (SELECT data_fechamento FROM ordem_servico WHERE id = NEW.id_ordem_servico) IS NOT NULL;

    SELECT RAISE(ABORT, 'Peça inativa ou inexistente.')
    WHERE (SELECT status FROM peca WHERE id = NEW.id_peca) IS NOT 1;

    SELECT RAISE(ABORT, 'Estoque insuficiente para a quantidade solicitada.')
    WHERE (SELECT estoque_atual FROM peca WHERE id = NEW.id_peca) < NEW.quantidade;
END;

-- 3) Baixa estoque e soma no total
DROP TRIGGER IF EXISTS trg_ai_ordem_peca_baixa_estoque_soma_total;
CREATE TRIGGER trg_ai_ordem_peca_baixa_estoque_soma_total
AFTER INSERT ON ordem_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual - NEW.quantidade
    WHERE id = NEW.id_peca;

    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0) + (NEW.quantidade * NEW.valor_unitario)
    WHERE id = NEW.id_ordem_servico;
END;

-- 4) Devolve estoque e subtrai do total
DROP TRIGGER IF EXISTS trg_ad_ordem_peca_devolve_estoque_subtrai_total;
CREATE TRIGGER trg_ad_ordem_peca_devolve_estoque_subtrai_total
AFTER DELETE ON ordem_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual + OLD.quantidade
    WHERE id = OLD.id_peca;

    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0) - (OLD.quantidade * OLD.valor_unitario)
    WHERE id = OLD.id_ordem_servico;
END;

-- 5) Alteração de item de peça
DROP TRIGGER IF EXISTS trg_bu_ordem_peca_valida;
CREATE TRIGGER trg_bu_ordem_peca_valida
BEFORE UPDATE ON ordem_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Não é permitido trocar ordem ou peça; exclua e insira novamente.')
    WHERE NEW.id_ordem_servico <> OLD.id_ordem_servico OR NEW.id_peca <> OLD.id_peca;

    SELECT RAISE(ABORT, 'Estoque insuficiente.')
    WHERE NEW.quantidade <= 0
       OR (SELECT estoque_atual FROM peca WHERE id = NEW.id_peca) + OLD.quantidade < NEW.quantidade;
END;

DROP TRIGGER IF EXISTS trg_au_ordem_peca_ajusta_estoque_total;
CREATE TRIGGER trg_au_ordem_peca_ajusta_estoque_total
AFTER UPDATE ON ordem_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual + OLD.quantidade - NEW.quantidade
    WHERE id = NEW.id_peca;

    UPDATE ordem_servico
    SET valor_total = COALESCE(valor_total, 0)
                    - (OLD.quantidade * OLD.valor_unitario)
                    + (NEW.quantidade * NEW.valor_unitario)
    WHERE id = NEW.id_ordem_servico;
END;

-- 8) Situação inicial ao abrir a ordem (quem abriu = id_funcionario_abertura)
DROP TRIGGER IF EXISTS trg_ai_ordem_servico_registra_situacao_inicial;
CREATE TRIGGER trg_ai_ordem_servico_registra_situacao_inicial
AFTER INSERT ON ordem_servico
FOR EACH ROW
BEGIN
    INSERT INTO ordem_situacao (id_ordem_servico, id_situacao, id_funcionario)
    VALUES (NEW.id, NEW.id_situacao_atual, NEW.id_funcionario_abertura);
END;

-- 9) Mantém a situação atual sincronizada com o histórico
DROP TRIGGER IF EXISTS trg_ai_ordem_situacao_atualiza_ordem_servico;
CREATE TRIGGER trg_ai_ordem_situacao_atualiza_ordem_servico
AFTER INSERT ON ordem_situacao
FOR EACH ROW
BEGIN
    UPDATE ordem_servico
    SET id_situacao_atual = NEW.id_situacao
    WHERE id = NEW.id_ordem_servico;
END;

-- 10) Data de fechamento (6 = Entregue, 7 = Cancelado)
DROP TRIGGER IF EXISTS trg_au_ordem_servico_registra_data_fechamento;
CREATE TRIGGER trg_au_ordem_servico_registra_data_fechamento
AFTER UPDATE OF id_situacao_atual ON ordem_servico
FOR EACH ROW
BEGIN
    UPDATE ordem_servico
    SET data_fechamento = CASE WHEN NEW.id_situacao_atual IN (6, 7)
                               THEN COALESCE(NEW.data_fechamento, DATETIME('now', 'localtime'))
                               ELSE NULL END
    WHERE id = NEW.id;
END;

-- 11) Bloqueia alterações em ordem encerrada + 12) Serviço ativo
DROP TRIGGER IF EXISTS trg_bi_servico_ordem_servico_valida;
CREATE TRIGGER trg_bi_servico_ordem_servico_valida
BEFORE INSERT ON servico_ordem_servico
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Ordem encerrada.')
    WHERE (SELECT data_fechamento FROM ordem_servico WHERE id = NEW.id_ordem_servico) IS NOT NULL;

    SELECT RAISE(ABORT, 'Serviço inativo ou inexistente.')
    WHERE (SELECT status FROM servicos WHERE id = NEW.id_servico) IS NOT 1;

    SELECT RAISE(ABORT, 'Quantidade deve ser maior que zero.')
    WHERE NEW.quantidade <= 0;
END;

DROP TRIGGER IF EXISTS trg_bi_ordem_situacao_valida_ordem_aberta;
CREATE TRIGGER trg_bi_ordem_situacao_valida_ordem_aberta
BEFORE INSERT ON ordem_situacao
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Ordem já encerrada.')
    WHERE (SELECT data_fechamento FROM ordem_servico WHERE id = NEW.id_ordem_servico) IS NOT NULL
      AND (SELECT COUNT(*) FROM ordem_situacao WHERE id_ordem_servico = NEW.id_ordem_servico) > 0;
END;

-- 13) Soft delete (exemplo; repita para peca, servicos, categoria, ...)
DROP TRIGGER IF EXISTS trg_bd_cliente_bloqueia_delete;
CREATE TRIGGER trg_bd_cliente_bloqueia_delete
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Exclusão física não permitida. Use status = 0.');
END;


CREATE TRIGGER trg_bi_entrada_peca_valida
BEFORE INSERT ON entrada_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Peça inativa ou inexistente.')
    WHERE (SELECT status FROM peca WHERE id = NEW.id_peca) IS NOT 1;
END;
 
CREATE TRIGGER trg_ai_entrada_peca_soma_estoque
AFTER INSERT ON entrada_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual + NEW.quantidade
    WHERE id = NEW.id_peca;
END;
 
-- Histórico de compras é imutável (RN02 / rastreabilidade)
CREATE TRIGGER trg_bu_entrada_peca_imutavel
BEFORE UPDATE ON entrada_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Entrada de peça é imutável: não pode ser alterada.');
END;
 
CREATE TRIGGER trg_bd_entrada_peca_imutavel
BEFORE DELETE ON entrada_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Entrada de peça é imutável: não pode ser excluída.');
END;
 

CREATE TRIGGER trg_bi_saida_peca_valida_estoque
BEFORE INSERT ON saida_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Peça inativa ou inexistente.')
    WHERE (SELECT status FROM peca WHERE id = NEW.id_peca) IS NOT 1;
 
    -- RN03: não permite estoque negativo
    SELECT RAISE(ABORT, 'RN03: estoque insuficiente para a saída solicitada.')
    WHERE (SELECT estoque_atual FROM peca WHERE id = NEW.id_peca) < NEW.quantidade_saida;
END;
 
CREATE TRIGGER trg_ai_saida_peca_baixa_estoque
AFTER INSERT ON saida_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual - NEW.quantidade_saida
    WHERE id = NEW.id_peca;
END;
 
CREATE TRIGGER trg_bu_saida_peca_imutavel
BEFORE UPDATE ON saida_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Saída de peça é imutável: não pode ser alterada.');
END;
 
CREATE TRIGGER trg_bd_saida_peca_imutavel
BEFORE DELETE ON saida_peca
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Saída de peça é imutável: não pode ser excluída.');
END;
 
CREATE TRIGGER trg_bu_peca_estoque_nao_negativo
BEFORE UPDATE OF estoque_atual ON peca
FOR EACH ROW
WHEN NEW.estoque_atual < 0
BEGIN
    SELECT RAISE(ABORT, 'RN03: estoque não pode ficar negativo.');
END;
 