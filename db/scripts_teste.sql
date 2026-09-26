--Ativa as Chaves estrangeiras do Sqlite
PRAGMA foreign_keys;

CREATE TABLE
    cargo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
        status INTEGER NOT NULL DEFAULT 1
    ) STRICT;

CREATE TABLE
    funcionario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_funcionario TEXT NOT NULL COLLATE NOCASE,
        id_cargo INTEGER NOT NULL,
        status INTEGER NOT NULL DEFAULT 1,
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_cargo) REFERENCES cargo (id) ON UPDATE CASCADE ON DELETE CASCADE,
        UNIQUE (id, id_cargo)
    ) STRICT;

INSERT INTO
    cargo (nome_cargo)
VALUES
    ('Gerente'),
    ('Atendente'),
    ('Técnico');

INSERT INTO
    funcionario (nome_funcionario, id_cargo)
VALUES
    ('Carlos Silva', 1),
    ('Ana Souza', 2),
    ('Bruno Lima', 2),
    ('Diego Santos', 3),
    ('Felipe Costa', 3),
    ('Sarah Oliveira', 3);

CREATE TABLE
    cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_cliente TEXT NOT NULL COLLATE NOCASE,
        email TEXT NOT NULL COLLATE NOCASE UNIQUE,
        id_funcionario INTEGER NOT NULL,
        --    CHECK: Avalia se o usuario inserido tem o id de cargo definido na tabela de Funcionario
        id_funcionario_cargo INTEGER NOT NULL CHECK (
            id_funcionario_cargo = 1
            OR id_funcionario_cargo = 2
        ),
        status INTEGER NOT NULL DEFAULT 1,
        data_cadastro TEXT NOT NULL DEFAULT (DATETIME ('now', 'localtime')),
        FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario (id, id_cargo)
    ) STRICT;

DROP TABLE cliente;

INSERT INTO
    cliente (
        nome_cliente,
        email,
        id_funcionario,
        id_funcionario_cargo
    )
VALUES
    (
        'João Pereira',
        'joao.pereira@email.com',
        1,
        (
            SELECT
                id_cargo
            FROM
                funcionario
            WHERE
                id = 1
        )
    );