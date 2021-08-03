CREATE TABLE IF NOT EXISTS banco (
	numero integer NOT NULL,
	nome varchar(50) NOT NULL,
	ativo boolean NOT NULL DEFAULT TRUE,
	data_criacao timestamp NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY (numero)
);

CREATE TABLE IF NOT EXISTS agencia (
	banco_numero integer NOT NULL,
	numero integer NOT NULL,
	nome varchar(80) NOT NULL,
	ativo boolean NOT NULL DEFAULT TRUE,
	data_criacao timestamp NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY (banco_numero,numero),
	FOREIGN KEY (banco_numero) REFERENCES banco (numero)
);

CREATE TABLE IF NOT EXISTS cliente (
	numero BIGSERIAL PRIMARY KEY,
	nome varchar(120) NOT NULL,
	email varchar(250) NOT NULL,
	ativo boolean NOT NULL DEFAULT TRUE,
	data_criacao timestamp NOT NULL DEFAULT current_timestamp	
);

CREATE TABLE IF NOT EXISTS conta_corrente (
	banco_numero integer NOT NULL,
	agencia_numero integer NOT NULL,	
	numero bigint NOT NULL,
	digito SMALLINT NOT NULL,
	cliente_numero bigint NOT NULL,
	ativo boolean NOT NULL DEFAULT TRUE,
	data_criacao timestamp NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY (banco_numero,agencia_numero,numero,digito,cliente_numero),
	FOREIGN KEY (banco_numero,agencia_numero) REFERENCES agencia (banco_numero,numero),
	FOREIGN KEY (cliente_numero) REFERENCES cliente (numero)
);

CREATE TABLE IF NOT EXISTS tipo_transacao (
	id smallserial PRIMARY KEY,
	nome varchar(50) NOT NULL,
	ativo boolean NOT NULL DEFAULT TRUE,
	data_criacao timestamp NOT NULL DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS cliente_transacoes (
	id bigserial PRIMARY KEY,
	banco_numero integer NOT NULL,
	agencia_numero integer NOT NULL,
	conta_corrente_numero bigint NOT NULL,
	conta_corrente_digito smallint NOT NULL,
	cliente_numero bigint NOT NULL,
	tipo_transacao_id smallint NOT NULL,
	valor numeric(15,2),
	data_criacao timestamp NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY (banco_numero,agencia_numero,conta_corrente_numero,conta_corrente_digito,cliente_numero) REFERENCES conta_corrente (banco_numero,agencia_numero,numero,digito,cliente_numero)
);
