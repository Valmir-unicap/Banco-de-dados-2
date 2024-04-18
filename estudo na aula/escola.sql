DROP DATABASE escola;

CREATE DATABASE escola;

 USE escola;
 
CREATE TABLE aluno(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	idade INT CHECK(idade<=18),
    nomeAluno varchar(255)
);

CREATE TABLE disciplina(
	idDisciplina INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nomeDisciplina varchar(255)
   -- idProfessor int
   -- foreign key(idProfessor) REFERENCES professor(idProfessor)
);

CREATE TABLE professor(
	idProfessor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nomeProfessor varchar(255)
    -- idDisciplina INT
	-- foreign key(idDisciplina) REFERENCES disciplina(idDisciplina)
);

INSERT INTO aluno(idade,nomeAluno) values (16,"andré");
INSERT INTO aluno(idade,nomeAluno) values (14,"tomas");
INSERT INTO aluno(idade,nomeAluno) values (17,"Julieta");
INSERT INTO aluno(idade,nomeAluno) values (18,"Jake");
INSERT INTO aluno(idade,nomeAluno) values (19,"Lucas");

INSERT INTO professor(nomeProfessor) values ("Garbriela");
INSERT INTO professor(nomeProfessor) values ("Hanna");
INSERT INTO professor(nomeProfessor) values ("Keila");

INSERT INTO disciplina(nomeDisciplina) values ("Engenharia");
INSERT INTO disciplina(nomeDisciplina) values ("Medicina");
INSERT INTO disciplina(nomeDisciplina) values ("Arte");

-- SELECT * FROM aluno group by aluno.nomeAluno;

-- ALTER TABLE aluno add sexo char;

-- SELECT * FROM aluno WHERE idade BETWEEN 16 AND 17 ;

 SELECT * FROM aluno;
