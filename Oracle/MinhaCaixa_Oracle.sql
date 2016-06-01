--Seta o formato da data como Ano-Mês-Dia. Ex.: 2016-05-25
SET DATEFORMAT YMD 

GO 

--Seta o Banco de dados Atual como sendo o Master
ALTER SESSION SET CURRENT_SCHEMA = MASTER; 

--Se o banco Minha Caixa já existir
IF EXISTS (SELECT * FROM SYS.DATABASES WHERE NAME = 'MinhaCaixa') 
		 
	--Então	 
	THEN 
		--Seta o banco Minha Caixa para alteração
		ALTER DATABASE MINHACAIXA 

		--Seta Rollback imediato para o usuário
		SET SINGLE_USER WITH 

		ROLLBACK IMMEDIATE 

		--Dropa o banco Minha Caixa
		DROP DATABASE MINHACAIXA 
END IF; 

--Recria o banco Minha Caixa 
CREATE DATABASE MINHACAIXA 

GO 

--Seta o esquema de banco de dados atual como sendo o Minha Caixa
ALTER SESSION SET CURRENT_SCHEMA = MINHACAIXA; 

-- Cria a tabela Grupo
CREATE TABLE GRUPO 
( 
	Grupocodigo Number(10) CONSTRAINT PK_GRUPO PRIMARY KEY, 
	Gruponome  Varchar2(50), 
	Gruporazaosocial Varchar2(50), 
	Grupocnpj  Varchar2(20), 
);

-- Cria o sequencial da tabela Grupo
CREATE SEQUENCE GRUPO_sequen START WITH 1 INCREMENT BY 1;

-- Cria o gatilho que irá preencher o Sequencial
CREATE OR REPLACE TRIGGER GRUPO_sequen_trigger
	BEFORE INSERT ON GRUPO FOR EACH ROW
	WHEN (NEW.Grupocodigo IS NULL)
BEGIN
	SELECT GRUPO_seq.NEXTVAL INTO :NEW.Grupocodigo FROM DUAL;
END;
/ 
--Obs.: A tabela DUAL é utilizada quando precisa-se fazer um SELECT mas sem extrair dados de uma tabela propriamente dita

--Popula a tabela Grupo
INSERT DBO.GRUPO (Gruponome, Gruporazaosocial, Grupocnpj) 
SELECT 'MyBank', 'MyBank International SA', '11.222.333/0001-44' FROM DUAL 

-- Cria a tabela Clientes		 
CREATE TABLE CLIENTES 
( 
	Clientecodigo  Number(10) CONSTRAINT PK_CLIENTES PRIMARY KEY, 
	Clientenome  Varchar2 (50), 
	Clienterua  Varchar2 (50), 
	Clientecidade  Varchar2 (50), 
	Clientenascimento Timestamp(3) 
);

-- Cria o sequencial da tabela Clientes
CREATE SEQUENCE CLIENTES_sequen START WITH 1 INCREMENT BY 1;

-- Cria o gatilho que irá preencher o Sequencial
CREATE OR REPLACE TRIGGER CLIENTES_sequen_trigger
	BEFORE INSERT ON CLIENTES FOR EACH ROW
	WHEN (NEW.Clientecodigo IS NULL)
BEGIN
	SELECT CLIENTES_seq.NEXTVAL INTO :NEW.Clientecodigo FROM DUAL;
END;
/ 

--Popula a tabela Clientes
INSERT CLIENTES 
SELECT 'Ana', 'XV de Novembro', 'Joinville', '1980-08-06' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Laura', '07 de Setembro', 'Blumenau', '1981-08-08' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Vânia', '01 de Maio', 'Blumenau', '1982-08-06' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Franco', 'Felipe Schmidt', 'Florianopolis', '1985-08-06' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Eduardo', 'Beria Mar Norte', 'Florianópolis', '1970-11-10' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Bruno', '24 de maio', 'Criciúma', '1982-07-05' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Rodrigo', '06 de agosto', 'Joinville', '1981-08-06' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Ricardo', 'João Colin', 'Joinville', '1980-02-15' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Alexandre', 'Margem esquerda', 'Blumenau', '1980-03-07' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Luciana', 'Estreito', 'Florianópolis', '1987-09-06' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Juliana', 'Iririu', 'Joinville', '1970-01-06' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Pedro', 'Aventureiro', 'Joinville', '1975-06-08' FROM DUAL 

GO 

INSERT CLIENTES 
SELECT 'Julia', 'Nova Brasília', 'Joinville', '1985-03-18' FROM DUAL 

GO 

--Cria a tabela Agências
CREATE TABLE AGENCIAS 
( 
	Agenciacodigo Number(10) CONSTRAINT PK_AGENCIAS PRIMARY KEY, 
	Agencianome Varchar2 (50), 
	Agenciacidade Varchar2 (50), 
	Agenciafundos Number, 
	Grupocodigo Number(10) 
); 


-- Cria o sequencial da tabela Agências
CREATE SEQUENCE AGENCIAS_sequen START WITH 1 INCREMENT BY 1;

-- Cria o gatilho que irá preencher o Sequencial
CREATE OR REPLACE TRIGGER AGENCIAS_sequen_trigger
	BEFORE INSERT ON AGENCIAS FOR EACH ROW
	WHEN (NEW.Agenciacodigo IS NULL)
BEGIN
	SELECT AGENCIAS_seq.NEXTVAL INTO :NEW.Agenciacodigo FROM DUAL;
END;
/ 

--Altera a tabela Agências e Insere a chave Estangeira do codigo do Grupo
ALTER TABLE AGENCIAS 
 ADD CONSTRAINT FK_GRUPOS_AGENCIAS FOREIGN KEY (Grupocodigo) REFERENCES GRUPO 

GO 

--Popula a tabela Agência
INSERT AGENCIAS
SELECT 'Verde Vale', 'Blumenau',900000, 1 FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Cidade das Flores', 'Joinville', 800000, 1 FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Universitária', 'Florianópolis', 750000, 1 FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Joinville', 'Joinville', 950000, 1 FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Beira Mar', 'Florianópolis', 600000, 1,FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Criciúma', 'Criciúma', 500000, 1 FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Blumenau', 'Blumenau', 1100000, 1 FROM DUAL

GO

INSERT AGENCIAS
SELECT 'Germânia', 'Blumenau', 400000, 1 FROM DUAL

GO

--Cria a tabela Contas
CREATE TABLE CONTAS 
( 
	Agenciacodigo Number(10), 
	Contanumero Varchar2 (10) CONSTRAINT PK_CONTA PRIMARY KEY, 
	Clientecodigo Number(10), 
	Contasaldo Number, 
	Contaabertura Timestamp(3) 
); 

--Altera a tabela Contas para inserir a chave estrangeira de código do Cliente
ALTER TABLE CONTAS 
 ADD CONSTRAINT FK_CLIENTES_CONTAS FOREIGN KEY (Clientecodigo) REFERENCES 
 CLIENTES 

GO 

--Altera a tabela Contas para inserir a chave estrangeira de código da Agência
ALTER TABLE CONTAS 
 ADD CONSTRAINT FK_AGENCIA_CONTAS FOREIGN KEY (Agenciacodigo) REFERENCES 
 AGENCIAS 

GO 

--Popula a tabela Contas
INSERT CONTAS 
SELECT 4, 'C-401', 1, 500, '2014-01-01' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 4, 'C-402', 2, 200, '2014-02-27' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 4, 'C-403', 3, 350, '2013-07-21' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 4, 'C-404', 7, 870, '2013-08-11' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 1, 'C-101', 11, 800, '2013-08-03' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 2, 'C-201', 4, 800, '2013-04-12' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 3, 'C-301', 5, 400, '2014-07-04' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 5, 'C-501', 6, 300, '2011-03-23' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 6, 'C-601', 8, 900, '2013-10-12' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 7, 'C-701', 9, 550, '2011-09-02' FROM DUAL 

GO 

INSERT CONTAS 
SELECT 8, 'C-801', 10, 1000, '2007-08-01' FROM DUAL 

GO 

--Cria a tabela Empréstimos
CREATE TABLE EMPRESTIMOS 
 ( 
  Agenciacodigo Number(10), 
  Clientecodigo Number(10), 
  Emprestimocodigo Varchar2 (10), 
  Emprestimototal Number 
 ); 

--Altera a tabela Empréstimos para inserir a chave estrangeira de código do Cliente
ALTER TABLE EMPRESTIMOS 
 ADD CONSTRAINT FK_EMPRESTIMOS_CLIENTES FOREIGN KEY (Clientecodigo) REFERENCES 
 CLIENTES 

GO 

--Altera a tabela Empréstimos para inserir a chave estrangeira de código da Agência
ALTER TABLE EMPRESTIMOS 
 ADD CONSTRAINT FK_EMPRESTIMOS_AGENGIA FOREIGN KEY (Agenciacodigo) REFERENCES 
 AGENCIAS 

GO 

--Popula a tabela Empréstimos
INSERT EMPRESTIMOS 
SELECT 4, 1, 'L-10', 2000 FROM DUAL 

GO 

INSERT EMPRESTIMOS 
SELECT 2, 4, 'L-20', 1500 FROM DUAL 

GO 

INSERT EMPRESTIMOS 
SELECT 4, 2, 'L-15', 1800 FROM DUAL 

GO 

INSERT EMPRESTIMOS 
SELECT 4, 3, 'L-30', 2500 FROM DUAL 

GO 

INSERT EMPRESTIMOS 
SELECT 6, 8, 'L-40', 3000 FROM DUAL 

GO 

INSERT EMPRESTIMOS 
SELECT 1, 11, 'L-35', 2800 FROM DUAL 

GO 

INSERT EMPRESTIMOS 
SELECT 4, 7, 'L-50', 2300 FROM DUAL 

GO 

--Cria a tabela Depositantes
CREATE TABLE DEPOSITANTES 
( 
	Agenciacodigo Number(10), 
	Contanumero Varchar2(10), 
	Clientecodigo Number(10), 
	Depositovalor Number, 
	Depositodata Timestamp(3) 
); 


--Altera a tabela Depositantes para inserir a chave estrangeira de código da Agência
ALTER TABLE DEPOSITANTES 
	ADD CONSTRAINT FK_CONTA_AGENGIA FOREIGN KEY (Agenciacodigo) REFERENCES 
	AGENCIAS 

GO 

--Altera a tabela Depositantes para inserir a chave estrangeira de número da Conta
ALTER TABLE DEPOSITANTES 
	ADD CONSTRAINT FK_DEPOSITANTES_CONTAS FOREIGN KEY (Contanumero) REFERENCES 
	CONTAS 

GO 

--Altera a tabela Depositantes para inserir a chave estrangeira de código do Cliente
ALTER TABLE DEPOSITANTES 
	ADD CONSTRAINT FK_DEPOSITANTES_CLIENTES FOREIGN KEY (Clientecodigo) REFERENCES 
	CLIENTES 

GO

--Popula a tabela Depositantes
INSERT DEPOSITANTES 
SELECT 4, 'C-401', 1, 500, '2014-01-01' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 4, 'C-402', 2, 200, '2014-02-27' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 4, 'C-403', 3, 350, '2013-07-21' FROM DUAL
 
GO 

INSERT DEPOSITANTES 
SELECT 2, 'C-201', 4, 800, '2013-04-12' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 3, 'C-301', 5, 400, '2014-07-04' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 4, 'C-404', 7, 870, '2013-08-11' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 5, 'C-501', 6, 300, '2011-03-23' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 6, 'C-601', 8, 900, '2013-10-12' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 7, 'C-701', 9, 550, '2011-09-02' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 8, 'C-801', 10, 1000, '2007-08-01' FROM DUAL 

GO 

INSERT DEPOSITANTES 
SELECT 1, 'C-101', 11, 800, '2013-08-03' FROM DUAL 

GO 

--Cria a tabela Devedores
CREATE TABLE DEVEDORES 
( 
	Agenciacodigo Number(10), 
	Clientecodigo Number(10), 
	Emprestimocodigo Varchar2 (10), 
	Devedorsaldo  Number 
 ); 

--Altera a tabela Devedores para inserir a chave estrangeira de código da Agência
ALTER TABLE DEVEDORES 
	ADD CONSTRAINT FK_DEVEDORES_AGENGIA FOREIGN KEY (Agenciacodigo) REFERENCES 
	AGENCIAS 

GO 

--Altera a tabela Devedores para inserir a chave estrangeira de código do Cliente
ALTER TABLE DEVEDORES 
	ADD CONSTRAINT FK_DEVEDORES_CONTAS FOREIGN KEY (Clientecodigo) REFERENCES 
	CLIENTES 

GO 

--Popula a tabela Devedores
INSERT DEVEDORES 
SELECT 4, 1, 'L-10', 1000 FROM DUAL 

GO 

INSERT DEVEDORES 
SELECT 2, 4, 'L-20', 500 FROM DUAL 

GO 

INSERT DEVEDORES 
SELECT 4, 2, 'L-15', 800 FROM DUAL 

GO 

INSERT DEVEDORES 
SELECT 4, 3, 'L-30', 2000 FROM DUAL 

GO 

INSERT DEVEDORES 
SELECT 6, 8, 'L-40', 2000 FROM DUAL 

GO 

INSERT DEVEDORES 
SELECT 1, 11, 'L-35', 2600 FROM DUAL 

GO 

INSERT DEVEDORES 
SELECT 4, 7, 'L-50', 2300 FROM DUAL 

GO 

--Cria a tabela Cartão de Crédito
CREATE TABLE CARTAOCREDITO 
( 
	Agenciacodigo Number(10), 
	Clientecodigo Number(10), 
	Cartaocodigo Varchar2 (20), 
	Cartaolimite Number 
); 

--Altera a tabela Cartão de Crédito para inserir a chave estrangeira de código da Agência
ALTER TABLE CARTAOCREDITO 
	ADD CONSTRAINT FK_CARTAOCREDITO_AGENGIA FOREIGN KEY (Agenciacodigo) REFERENCES 
	AGENCIAS 

GO 

--Altera a tabela Cartão de Crédito para inserir a chave estrangeira de código do Cliente
ALTER TABLE CARTAOCREDITO 
	ADD CONSTRAINT FK_CARTAOCREDITO_CLIENTES FOREIGN KEY (Clientecodigo) 
	REFERENCES CLIENTES 

GO 

--Popula a tabela Cartão de Crédito
INSERT DBO.CARTAOCREDITO 
SELECT 1, 12, '1111-2222-3333-4444', 1000 FROM DUAL 

GO 

INSERT DBO.CARTAOCREDITO 
SELECT 4, 13, '1234-4567-8910-1112', 1000 FROM DUAL 

GO 

INSERT DBO.CARTAOCREDITO 
SELECT 4, 7, '2222-3333-4444-5555', 2000 FROM DUAL 

GO 
