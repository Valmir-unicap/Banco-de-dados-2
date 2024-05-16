DROP database hotelaria;

CREATE DATABASE hotelaria;

USE hotelaria;

CREATE TABLE cliente(
idCliente INT PRIMARY KEY auto_increment,
nomeCliente VARCHAR(255),
idadeCliente INT,
sexoCliente CHAR CHECK(sexoCliente = 'm' OR sexoCliente = 'f' OR sexoCliente = 'o'),
endereco VARCHAR(255),
rendaCliente FLOAT 
);

CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY auto_increment,
nomeFuncionario VARCHAR(255),
idadeFuncionario INT,
sexoFuncionario CHAR CHECK(sexoFuncionario = 'm' OR sexoFuncionario = 'f' OR sexoFuncionario = 'o'),
salario FLOAT,
cargo VARCHAR(255)
);

CREATE TABLE quarto(
idQuarto INT,
numeroQuarto INT,
andar INT,
idFuncionario INT NOT NULL,
tipo VARCHAR(255),
idCliente INT(11) NOT NULL,
CONSTRAINT fk_id_cliente FOREIGN KEY (idCliente) REFERENCES
cliente(idCliente),
entrada DATETIME ,
saida DATETIME ,
diaria FLOAT,
ocupado boolean
);

CREATE TABLE faxina(
idFaxina INT,
dia DATETIME,
hora TIME,
idFuncionario INT(11) NOT NULL,
CONSTRAINT fk_id_funcionario FOREIGN KEY (idFuncionario) REFERENCES
funcionario(idFuncionario),
idQuarto INT(11) NOT NULL,
CONSTRAINT fk_id_quarto FOREIGN KEY (idQuarto) REFERENCES
quarto(idQuarto),
observacao VARCHAR(255)
);

INSERT INTO cliente (nomeCliente, idadeCliente, sexoCliente, endereco, rendaCliente) values ("Carlos", 25, 'm', "Boa Viagem", 1.250);
INSERT INTO cliente (nomeCliente, idadeCliente, sexoCliente, endereco, rendaCliente) values ("Andre", 32, 'm', "Boa Vista", 2.650);
INSERT INTO cliente (nomeCliente, idadeCliente, sexoCliente, endereco, rendaCliente) values ("Carla", 18, 'f', "Ibura", 1.350);
INSERT INTO cliente (nomeCliente, idadeCliente, sexoCliente, endereco, rendaCliente) values ("Tomas", 41, 'o', "Arruda", 1.150);
INSERT INTO cliente (nomeCliente, idadeCliente, sexoCliente, endereco, rendaCliente) values ("Gabriella", 30, 'f', "Candeias", 2.500);

INSERT INTO funcionario (nomeFuncionario, idadeFuncionario, sexoFuncionario, salario, cargo) values ("Hugo", 21, 'o', "1.780", "Atendente");
INSERT INTO funcionario (nomeFuncionario, idadeFuncionario, sexoFuncionario, salario, cargo) values ("Keila", 28, 'f', "1.580", "Faxineiro");
INSERT INTO funcionario (nomeFuncionario, idadeFuncionario, sexoFuncionario, salario, cargo) values ("Paulo", 22, 'm', "1.680", "Cozinheiro");
INSERT INTO funcionario (nomeFuncionario, idadeFuncionario, sexoFuncionario, salario, cargo) values ("Jake", 24, 'm', "2.780", "Gestor");

INSERT INTO quarto (numeroQuarto, andar, idCliente, tipo, entrada, saida, diaria, ocupado) values (10, 2, 1, "solteiro", '2025-05-15', '2025-04-19', 1.500, true);
INSERT INTO quarto (numeroQuarto, andar, idCliente, tipo, entrada, saida, diaria, ocupado) values (5, 1, 2, "casado", '2025-05-16', '2025-04-19', 1.500, true);
INSERT INTO quarto (numeroQuarto, andar, idCliente, tipo, entrada, saida, diaria, ocupado) values (7, 2, 3, "solteiro", '2025-02-12', '2025-03-19', 1.500, false);
INSERT INTO quarto (numeroQuarto, andar, idCliente, tipo, entrada, saida, diaria, ocupado) values (3, 1, 4, "casado", '2025-04-13', '2025-04-19', 1.500,true);

INSERT INTO faxina (dia, hora, idFuncionario, idQuarto, observacao) values (2025-05-15, 12, 1, 1,'agradevel');
INSERT INTO faxina (dia, hora, idFuncionario, idQuarto, observacao) values (2025-04-12, 9, 2, 2,'ruim');
INSERT INTO faxina (dia, hora, idFuncionario, idQuarto, observacao) values (2025-03-17, 7, 3, 3,'agradevel');
INSERT INTO faxina (dia, hora, idFuncionario, idQuarto, observacao) values (2025-03-19, 5, 4, 4,'ruim');

-- Realizando as consultas
-- 1. Retornar o salário total por cada cargo de funcionários
SELECT cargo, SUM(salario) AS salario_total
FROM funcionario
GROUP BY cargo;

-- 2. Retornar quantos quartos estão ocupados por andar
SELECT andar, COUNT(*) AS quartos_ocupados
FROM quarto
WHERE ocupado = 'sim'
GROUP BY andar;

-- 3. Retornar a quantidade e o valor arrecadado por cada quarto agrupado pelo mês
SELECT EXTRACT(MONTH FROM entrada) AS mes, COUNT(*) AS quantidade_quartos, SUM(diaria) AS valor_arrecadado
FROM quarto
GROUP BY EXTRACT(MONTH FROM entrada);

-- 4. Retornar a renda média dos clientes por sexo
SELECT sexoCliente, AVG(renda) AS renda_media
FROM cliente
GROUP BY sexo;

-- Adicionando uma coluna chamada observacao na tabela de cliente
ALTER TABLE cliente
ADD COLUMN observacao VARCHAR(255);

-- Criando o usuário 'responsavellimpeza' com permissão para consultar e inserir na visao_faxina
CREATE USER responsavellimpeza;
GRANT SELECT, INSERT ON visao_faxina TO responsavellimpeza;

-- Criando as visões
CREATE VIEW visao_corredores AS
SELECT quarto.andar, SUM(quarto.diaria) AS receita_total
FROM quarto
WHERE ocupado = 'sim'
GROUP BY andar;

CREATE VIEW visao_funcionario AS
SELECT idFuncionario, nomeFuncionario, salario, cargo
FROM funcionario;
