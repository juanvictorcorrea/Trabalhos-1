CREATE TABLE tab_agencia (
cod_agencia int(10) NOT NULL AUTO_INCREMENT,
nm_agencia char(255),
cid_agencia char(255),
fundos_agencia decimal,
PRIMARY KEY (pk_agencia)
);

FIZ O SCRIPT DA PRIMEIRA TABELA DO BD, UTILIZEM OS NOMES DE TABELAS E COLUNAS CONFORME ABAIXO, PARA FICAR DE ACORDO COM O DESENHO.

TAB_GRUPO_AGENCIA
cod_grupo_agencia
nm_grupo
r_social_grupo
cnpj_grupo
cod_agencia


TAB_CARTAO_CREDITO
cod_cartao
limite_cartao decimal
cod_agencia
cod_cliente


TAB_CLIENTE
cod_cliente
nm_cliente
rua_cliente
cid_cliente
dtnasc_cliente


TAB_CONTAS
cod_conta
saldo_conta
dtabert_conta
cod_agencia
cod_cliente


TAB_DEPOSITANTE
cod_depositante
vl_deposito
dt_deposito
cod_conta
cod_cliente


TAB_DEVEDORES
cod_devedor
saldo_devedor
cod_cliente


TAB_EMPRESTIMO
cod_emprestimo
tot_emprestimo
cod_cliente
cod_agencia


TAB_AGENCIA
cod_depositante
cod_agencia


AGENCIA_DEVEDORES
cod_devedor
cod_agencia

