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

DROP TABLE categoria;

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
    preco_compra INTEGER NOT NULL,
    preco_venda INTEGER NOT NULL,
    estoque_atual INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    status INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id)
) STRICT;

INSERT INTO peca (nome_peca, id_categoria, preco_compra, preco_venda, estoque_atual, id_funcionario, id_funcionario_cargo) VALUES
('Display Frontal Completo iPhone 11', 12, 18000, 35000, 4, 1, 1),
('Display Frontal Completo Samsung Galaxy A54', 12, 16000, 31000, 6, 1, 1),
('Display Frontal Completo Motorola Moto G84', 12, 14000, 28000, 5, 1, 1),
('Bateria Compatível iPhone 11 (3110mAh)', 13, 7500, 16000, 8, 1, 1),
('Bateria Compatível Samsung Galaxy A32', 13, 6000, 13000, 7, 1, 1),
('Bateria Compatível Moto G30', 13, 5500, 12000, 6, 1, 1),
('Conector de Carga Type-C Universal (Unidade)', 14, 250, 2000, 100, 1, 1),
('Conector de Carga Micro USB V8', 14, 150, 1500, 100, 1, 1),
('Flex de Carga e Microfone Moto G9 Play', 14, 1800, 5500, 10, 1, 1),
('Tampa Traseira de Vidro iPhone 12', 15, 4000, 11000, 4, 1, 1),
('Câmera Traseira Principal Redmi Note 11', 14, 6500, 14000, 3, 1, 1),
('Alto-Falante Auricular Universal', 14, 500, 2500, 40, 1, 1),
('Barra de LED TV Samsung 50" (Kit com 3 barras)', 16, 11000, 23000, 4, 1, 1),
('Barra de LED TV LG 43" (Kit com 3 barras)', 16, 9500, 19500, 5, 1, 1),
('Placa Fonte TV Samsung UN50TU8000', 16, 16000, 31000, 2, 1, 1),
('Placa Principal TV LG 43UP7500', 16, 21000, 42000, 2, 1, 1),
('Cabo Flat T-Con para Display TV 55"', 16, 2200, 6500, 8, 1, 1),
('Receptor Infravermelho para Controle Remoto TV', 14, 400, 2000, 15, 1, 1),
('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', 10, 8500, 15000, 3, 1, 1),
('Álcool Isopropílico 99.8% 1 Litro', 10, 2200, 4500, 12, 1, 1),
('Fita Kapton Térmica 10mm x 33m', 10, 1200, 3000, 15, 1, 1),
('Fita Dupla Face Fixação de Telas (3mm x 50m)', 10, 1500, 3500, 10, 1, 1),
('Fusível de Louça 5A 250V (Pacote c/ 10)', 14, 500, 1800, 20, 1, 1),
('Capacitor Eletrolítico 1000uF x 25V', 14, 80, 500, 150, 1, 1),
('SSD NVMe 512GB M.2', 9, 14000, 26000, 15, 1, 1),
('SSD SATA III 480GB 2.5"', 9, 11000, 21000, 20, 1, 1),
('Memória RAM DDR4 8GB 2666MHz (Notebook)', 9, 9000, 17000, 12, 1, 1),
('Memória RAM DDR4 16GB 3200MHz (Desktop)', 9, 18000, 32000, 8, 1, 1),
('Pasta Térmica de Alta Performance (Bisnaga 4g)', 10, 2500, 6000, 25, 1, 1),
('Fonte ATX 500W 80 Plus Bronze', 9, 19000, 34000, 6, 1, 1),
('Bateria Célula Moeda CR2032 (Cartela c/ 5)', 10, 800, 2500, 30, 1, 1),
('Cooler para Processador Socket Universal', 9, 4500, 9500, 10, 1, 1),
('Cabo SATA III 6Gbps 50cm', 11, 300, 1500, 50, 1, 1),
('Tela LED 15.6" Slim 30 Pinos Full HD', 12, 28000, 48000, 5, 1, 1);

SELECT * FROM peca p WHERE p.preco_venda >= 10000;

CREATE VIEW vw_preco_venda_maior_100 AS 
SELECT id, nome_peca, preco_venda AS 'Preço', estoque_atual FROM peca p WHERE p.preco_venda >= 10000;

DROP VIEW vw_preco_venda_maior_100;

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
    
    FOREIGN KEY (id_peca) REFERENCES peca (id),
    FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id),
    FOREIGN KEY (id_tecnico, id_cargo_tecnico) REFERENCES funcionario (id, id_cargo)
) STRICT;
	
	
	
INSERT INTO situacao (nome_situacao) VALUES 
('Aberto'),
('Em Diagnóstico'),
('Orçamento Aprovado'),
('Em Reparo'),
('Pronto'),
('Entregue'),
('Cancelado');

INSERT INTO forma_pagamento (nome_forma_pagamento, id_funcionario, id_funcionario_cargo) VALUES 
('Dinheiro', 1, 1),
('PIX', 1, 1),
('Cartão de Crédito', 1, 1),
('Cartão de Débito', 1, 1),
('Transferência Bancária', 1, 1);