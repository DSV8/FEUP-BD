--
-- File generated with SQLiteStudio v3.3.3 on Thu Nov 17 12:11:26 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = on;
BEGIN TRANSACTION;


DROP TABLE IF EXISTS Clube;

-- Table: Clube
CREATE TABLE Clube (
	nome CHAR (32) NOT NULL PRIMARY KEY,
	Localizacao CHAR (64) NOT NULL UNIQUE,
	dataFundacao DATE NOT NULL
	);


DROP TABLE IF EXISTS Equipa;

-- Table: Equipa
CREATE TABLE Equipa (
	idEquipa INTEGER NOT NULL PRIMARY KEY,
	nomeClube CHAR (32) NOT NULL REFERENCES Clube (nome) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE,
	ranking INTEGER NOT NULL REFERENCES Classificacao (ranking) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Playoffs;

-- Table: Playoffs
CREATE TABLE Playoffs (
	idEquipa INTEGER NOT NULL PRIMARY KEY,
	nomeClube CHAR (32) NOT NULL REFERENCES Clube (nome) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE,
	ranking INTEGER REFERENCES Classificacao (ranking) UNIQUE CHECK (ranking <= 8)ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Desqualificadas;
	
-- Table: Desqualificadas
CREATE TABLE Desqualificadas (
	idEquipa INTEGER NOT NULL PRIMARY KEY,
	nomeClube CHAR (32) NOT NULL REFERENCES REFERENCES Clube (nome) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE,
	ranking INTEGER NOT NULL REFERENCES Classificacao (ranking) UNIQUE CHECK (ranking >= 12) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Classificacao;

-- Table: Classificacao
CREATE TABLE Classificacao (
	ranking INTEGER NOT NULL PRIMARY KEY CHECK (ranking>=1 and ranking<=16),
	pontos INTEGER NOT NULL,
	numJogos INTEGER NOT NULL,
	vitorias INTEGER NOT NULL,
	empates INTEGER NOT NULL, 
	derrotas INTEGER NOT NULL,
	golosMarcados INTEGER NOT NULL,
	golosSofridos INTEGER NOT NULL,
	diferencaGolos INTEGER NOT NULL,
	CHECK (pontos = vitorias*3 + empates AND numJogos = vitorias + empates + derrotas)
	);


DROP TABLE IF EXISTS Evento;

-- Table: Evento
CREATE TABLE Evento (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	idJogo INTEGER NOT NULL REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Cartao;

-- Table: Cartao
CREATE TABLE Cartao (
	idEvento INTEGER PRIMARY KEY NOT NULL,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	cor CHAR (32) NOT NULL,
	idJogo INTEGER NOT NULL REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);


DROP TABLE IF EXISTS Golo;

-- Table: Golo
CREATE TABLE Golo (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	tipo CHAR (32) NOT NULL,
	idJogo INTEGER NOT NULL REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Substituicao;

-- Table: Substituicao
CREATE TABLE Substituicao (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	idJogadorSai INTEGER NOT NULL REFERENCES Jogador (idPessoa), ON DELETE CASCADE ON UPDATE CASCADE
	idJogadorEntra INTEGER NOT NULL REFERENCES Jogador (idPessoa), ON DELETE CASCADE ON UPDATE CASCADE
	idJogo INTEGER NOT NULL REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);


DROP TABLE IF EXISTS Timeout;

-- Table: Timeout 
CREATE TABLE Timeout (
	idEvento INTEGER NOT NULL PRIMARY KEY,
	minuto INTEGER NOT NULL CHECK (minuto >= 0 AND minuto <= 25),
	parte INTEGER NOT NULL CHECK (parte = 1 OR parte = 2),
	idEquipa INTEGER NOT NULL REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE,
	idJogo INTEGER NOT NULL REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Jogo;	

-- Table: Jogo
CREATE TABLE Jogo (
	idJogo INTEGER NOT NULL PRIMARY KEY,
	data DATE,
	horaInicio TIME NOT NULL,
	vencedor CHAR (32),
	derrotado CHAR (32),
	idEquipaVisitada INTEGER REFERENCES Equipa (idEquipa) NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	idEquipaVisitante INTEGER NOT NULL REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
	);


DROP TABLE IF EXISTS JogoPlayoff;

-- Table: JogoPlayoff
CREATE TABLE JogoPlayoff (
	idJogo INTEGER PRIMARY KEY REFERENCES Jogo (idJogo) NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	ronda CHAR (32) NOT NULL UNIQUE,
	);
	


DROP TABLE IF EXISTS Jornada;

-- Table: Jornada
CREATE TABLE Jornada (
	numero INTEGER NOT NULL PRIMARY KEY CHECK (numero >= 1 AND numero <= 26)
	);


DROP TABLE IF EXISTS JornadaJogo;

-- Table: JornadaJogo
CREATE TABLE JornadaJogo (
	numJornada INTEGER REFERENCES Jornada (numero) NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	idJogo INTEGER NOT NULL REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (numJornada, idJogo)
	);


DROP TABLE IF EXISTS Pavilhao;

-- Table: Pavilhao
CREATE TABLE Pavilhao (
	idPavilhao INTEGER PRIMARY KEY NOT NULL,
	nome CHAR (32) UNIQUE,
	capacidade INTEGER,
	nomeClube CHAR (32) REFERENCES Clube (idClube) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE
	);


DROP TABLE IF EXISTS PavilhaoJogo;

-- Table: PavilhaoJogo
CREATE TABLE PavilhaoJogo (
	idPavilhao INTEGER PRIMARY KEY REFERENCES Pavilhao (idPavilhao) NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	idJogo INTEGER REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
	);
	
	
DROP TABLE IF EXISTS Jogador;

-- Table: Jogador
CREATE TABLE Jogador (
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	nome CHAR (64) NOT NULL,
	dataNasc DATE,
	numero INTEGER NOT NULL,
	posicao CHAR (32) NOT NULL,
	idEquipa INTEGER NOT NULL REFERENCES Equipa (idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS Treinador;

-- Table: Treinador
CREATE TABLE Treinador (
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	nome CHAR (64) NOT NULL,
	dataNasc DATE,
	experiencia CHAR (64),
	idEquipa INTEGER NOT NULL REFERENCES Equipa (idEquipa) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE
	);

DROP TABLE IF EXISTS Arbitro;

-- Table: Arbitro
CREATE TABLE Arbitro (
	idPessoa INTEGER NOT NULL PRIMARY KEY,
	nome CHAR (64) NOT NULL,
	dataNasc DATE,
	numero INTEGER NOT NULL
	);
	
	
DROP TABLE IF EXISTS MarcaGolo;

-- Table: MarcaGolo
CREATE TABLE MarcaGolo (
	idGolo INTEGER PRIMARY KEY REFERENCES Golo (idEvento) UNIQUE NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	idJogador INTEGER NOT NULL REFERENCES Jogador (idPessoa) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE,
	idEquipa INTEGER NOT NULL REFERENCES Equipa (idEquipa) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE
	);
	
	
DROP TABLE IF EXISTS AtribuiCartao;

-- Table: AtribuiCartao
CREATE TABLE AtribuiCartao (
	idCartao INTEGER PRIMARY KEY REFERENCES Cartao (idEvento) UNIQUE NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	idArbitro INTEGER REFERENCES Arbitro (idPessoa) UNIQUE NOT NULL ON DELETE CASCADE ON UPDATE CASCADE,
	idJogador INTEGER NOT NULL REFERENCES Jogador (idPessoa) UNIQUE ON DELETE CASCADE ON UPDATE CASCADE
	);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
