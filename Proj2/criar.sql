PRAGMA foreign_keys = on;
--END TRANSACTION;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS AtribuiCartao;
DROP TABLE IF EXISTS MarcaGolo;
DROP TABLE IF EXISTS Arbitro;
DROP TABLE IF EXISTS Treinador;
DROP TABLE IF EXISTS PavilhaoJogo;
DROP TABLE IF EXISTS Pavilhao;
DROP TABLE IF EXISTS JornadaJogo;
DROP TABLE IF EXISTS Jornada;
DROP TABLE IF EXISTS JogoPlayoff;
DROP TABLE IF EXISTS Timeout;
DROP TABLE IF EXISTS Substituicao;
DROP TABLE IF EXISTS Jogador;
DROP TABLE IF EXISTS Golo;
DROP TABLE IF EXISTS Cartao;
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS Jogo;
DROP TABLE IF EXISTS Desqualificadas;
DROP TABLE IF EXISTS Playoffs;
DROP TABLE IF EXISTS Equipa;
DROP TABLE IF EXISTS Classificacao;
DROP TABLE IF EXISTS Clube;

-- Table: Clube
CREATE TABLE Clube (
	nome CHAR (32) NOT NULL PRIMARY KEY,
	Localizacao CHAR (64) NOT NULL,
	dataFundacao DATE NOT NULL
	);
	

-- Table: Classificacao
CREATE TABLE Classificacao (
	nomeClube CHAR (32) NOT NULL PRIMARY KEY UNIQUE,
	ranking INTEGER NOT NULL CHECK (ranking>=1 and ranking<=16),
	pontos INTEGER NOT NULL CHECK (pontos = vitorias*3 + empates AND numJogos = vitorias + empates + derrotas),
	numJogos INTEGER NOT NULL,
	vitorias INTEGER NOT NULL,
	empates INTEGER NOT NULL, 
	derrotas INTEGER NOT NULL,
	golosMarcados INTEGER NOT NULL,
	golosSofridos INTEGER NOT NULL,
	diferencaGolos INTEGER NOT NULL,
	FOREIGN KEY(nomeClube) REFERENCES Clube(nome) ON DELETE CASCADE ON UPDATE CASCADE
	);

-- Table: Equipa
CREATE TABLE Equipa(
	idEquipa INTEGER NOT NULL PRIMARY KEY,
	nomeClube CHAR (32) NOT NULL UNIQUE,
	ranking INTEGER NOT NULL UNIQUE,
	FOREIGN KEY (nomeClube) REFERENCES Clube (nome) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

CREATE TABLE Playoffs (
-- Table: Playoffs
	idEquipa INTEGER NOT NULL PRIMARY KEY,
	nomeClube CHAR (32) NOT NULL UNIQUE,
	ranking INTEGER UNIQUE CHECK (ranking <= 8),
	FOREIGN KEY (nomeClube) REFERENCES Clube (nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ranking) REFERENCES Classificacao (ranking) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
-- Table: Desqualificadas
CREATE TABLE Desqualificadas (
	idEquipa INTEGER NOT NULL PRIMARY KEY,
	nomeClube CHAR (32) NOT NULL UNIQUE,
	ranking INTEGER NOT NULL UNIQUE CHECK (ranking >= 12),
	FOREIGN KEY (nomeClube) REFERENCES Clube (nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ranking) REFERENCES Classificacao (ranking) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: Jogo
CREATE TABLE Jogo (
	idJogo INTEGER NOT NULL PRIMARY KEY,
	data DATE,
	horaInicio TIME NOT NULL,
	vencedor CHAR (32),
	derrotado CHAR (32),
	idEquipaVisitada INTEGER NOT NULL,
	idEquipaVisitante INTEGER NOT NULL,
	FOREIGN KEY (idEquipaVisitada) REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idEquipaVisitante) REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

-- Table: Evento
CREATE TABLE Evento (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	idJogo INTEGER NOT NULL,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

-- Table: Cartao
CREATE TABLE Cartao (
	idEvento INTEGER PRIMARY KEY NOT NULL,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	cor CHAR (32) NOT NULL,
	idJogo INTEGER NOT NULL,
	FOREIGN KEY (idEvento) REFERENCES Evento (idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: Golo
CREATE TABLE Golo (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	tipo CHAR (32) NOT NULL,
	idJogo INTEGER NOT NULL,
	FOREIGN KEY (idEvento) REFERENCES Evento (idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

-- Table: Jogador
CREATE TABLE Jogador (
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	nome CHAR (64) NOT NULL,
	dataNasc DATE,
	numero INTEGER NOT NULL,
	posicao CHAR (32),
	idEquipa INTEGER NOT NULL,
	FOREIGN KEY (idEquipa) REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

-- Table: Substituicao
CREATE TABLE Substituicao (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	idJogadorSai INTEGER NOT NULL,
	idJogadorEntra INTEGER NOT NULL,
	idJogo INTEGER NOT NULL,
	FOREIGN KEY (idEvento) REFERENCES Evento (idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogadorSai) REFERENCES Jogador (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogadorEntra) REFERENCES Jogador (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: Timeout 
CREATE TABLE Timeout (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	idEquipa INTEGER NOT NULL,
	idJogo INTEGER NOT NULL,
	FOREIGN KEY (idEvento) REFERENCES Evento (idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idEquipa) REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: JogoPlayoff
CREATE TABLE JogoPlayoff (
	idJogo INTEGER PRIMARY KEY NOT NULL,
	ronda CHAR (32) NOT NULL,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

--Table: Jornada
CREATE TABLE Jornada (
	numero INTEGER NOT NULL PRIMARY KEY CHECK (numero >= 1 AND numero <= 26)
	);


-- Table: JornadaJogo
CREATE TABLE JornadaJogo (
	numJornada INTEGER NOT NULL,
	idJogo INTEGER NOT NULL PRIMARY KEY,
	FOREIGN KEY (numJornada) REFERENCES Jornada (numero) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: Pavilhao
CREATE TABLE Pavilhao (
	idPavilhao INTEGER PRIMARY KEY NOT NULL,
	nome CHAR (32) UNIQUE,
	capacidade INTEGER,
	nomeClube CHAR (32) UNIQUE,
	FOREIGN KEY (nomeClube) REFERENCES Clube (nome) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: PavilhaoJogo
CREATE TABLE PavilhaoJogo (
	idPavilhao INTEGER NOT NULL,
	idJogo INTEGER PRIMARY KEY NOT NULL,
	FOREIGN KEY (idPavilhao) REFERENCES Pavilhao (idPavilhao) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogo) REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

-- Table: Treinador
CREATE TABLE Treinador (
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	nome CHAR (64) NOT NULL,
	dataNasc DATE,
	experiencia CHAR (64),
	idEquipa INTEGER UNIQUE NOT NULL,
	FOREIGN KEY (idEquipa) REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
	);


-- Table: Arbitro
CREATE TABLE Arbitro (
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	nome CHAR (64) NOT NULL,
	dataNasc DATE,
	numero INTEGER NOT NULL
	);
	

-- Table: MarcaGolo
CREATE TABLE MarcaGolo (
	idGolo INTEGER PRIMARY KEY UNIQUE NOT NULL,
	idJogador INTEGER NOT NULL,
	idEquipa INTEGER NOT NULL,
	FOREIGN KEY (idGolo) REFERENCES Golo (idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogador) REFERENCES Jogador (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idEquipa) REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
	);
	

-- Table: AtribuiCartao
CREATE TABLE AtribuiCartao (
	idCartao INTEGER PRIMARY KEY UNIQUE NOT NULL,
	idArbitro INTEGER NOT NULL,
	idJogador INTEGER NOT NULL,
	FOREIGN KEY (idCartao) REFERENCES Cartao (idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idArbitro) REFERENCES Arbitro (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (idJogador) REFERENCES Jogador (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE
	);


COMMIT TRANSACTION;