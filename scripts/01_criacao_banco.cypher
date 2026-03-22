// ============================================
// SCRIPT 01: CRIAÇÃO DO BANCO DE DADOS
// Banco: Fala Ai - Rede Social em Grafo
// ============================================

// ============================================
// PARTE 1: DROP E CRIAÇÃO DE CONSTRAINTS
// ============================================

// 1.1 Remover constraints existentes
DROP CONSTRAINT unique_pessoa_id IF EXISTS;
DROP CONSTRAINT unique_post_id IF EXISTS ;
DROP CONSTRAINT unique_grupo_id IF EXISTS;
DROP CONSTRAINT unique_comunidade_id IF EXISTS;

// 1.2 Criar constraints de unicidade
CREATE CONSTRAINT unique_pessoa_id IF NOT EXISTS FOR (p:Pessoa) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT unique_post_id IF NOT EXISTS FOR (po:Post) REQUIRE po.id IS UNIQUE;
CREATE CONSTRAINT unique_grupo_id IF NOT EXISTS FOR (g:Grupo) REQUIRE g.id IS UNIQUE;
CREATE CONSTRAINT unique_comunidade_id IF NOT EXISTS FOR (c:Comunidade) REQUIRE c.id IS UNIQUE;

// 1.3 Verificação das constraints
SHOW CONSTRAINTS;

// ============================================
// PARTE 2: DROP E CRIAÇÃO DE ÍNDICES
// ============================================

// 2.1 Remover índices existentes
DROP INDEX idx_pessoa_nome IF EXISTS;
DROP INDEX idx_pessoa_idade IF EXISTS;
DROP INDEX idx_pessoa_cidade IF EXISTS;
DROP INDEX idx_post_data IF EXISTS;
DROP INDEX idx_grupo_categoria IF EXISTS;

// 2.2 Criar índices para consultas frequentes
CREATE INDEX idx_pessoa_nome IF NOT EXISTS FOR (p:Pessoa) ON (p.nome);
CREATE INDEX idx_pessoa_idade IF NOT EXISTS FOR (p:Pessoa) ON (p.idade);
CREATE INDEX idx_pessoa_cidade IF NOT EXISTS FOR (p:Pessoa) ON (p.cidade);
CREATE INDEX idx_post_data IF NOT EXISTS FOR (po:Post) ON (po.dataCriacao);
CREATE INDEX idx_grupo_categoria IF NOT EXISTS FOR (g:Grupo) ON (g.categoria);

// 2.3 Verificação dos índices
SHOW INDEXES;

// ============================================
// PARTE 3: LIMPEZA DO BANCO
// ============================================

// 3.1 Remover todos os relacionamentos
MATCH ()-[r]-() DETACH DELETE r;

// 3.2 Remover todos os nós
MATCH (n) DETACH DELETE n;

// 3.3 Verificação de limpeza
MATCH (n) RETURN count(n) AS total_nos;

MATCH ()-[r]-() RETURN count(r) AS total_relacionamentos;

// ============================================
// PARTE 4: CRIAÇÃO DOS NÓS - PESSOAS (30 nós)
// ============================================

// 4.1 Criar pessoas com diferentes perfis demográficos
CREATE (p1:Pessoa {id: 1, nome: 'Ana Silva', idade: 28, sexo: 'F', cidade: 'São Paulo', escolaridade: 'Superior Completo', profissao: 'Desenvolvedora'});
CREATE (p2:Pessoa {id: 2, nome: 'Carlos Santos', idade: 35, sexo: 'M', cidade: 'Rio de Janeiro', escolaridade: 'Pós-Graduação', profissao: 'Engenheiro de Dados'});
CREATE (p3:Pessoa {id: 3, nome: 'Mariana Oliveira', idade: 24, sexo: 'F', cidade: 'Belo Horizonte', escolaridade: 'Superior Incompleto', profissao: 'Designer'});
CREATE (p4:Pessoa {id: 4, nome: 'João Pereira', idade: 42, sexo: 'M', cidade: 'Porto Alegre', escolaridade: 'Mestrado', profissao: 'Arquiteto de Software'});
CREATE (p5:Pessoa {id: 5, nome: 'Fernanda Lima', idade: 31, sexo: 'F', cidade: 'Curitiba', escolaridade: 'Superior Completo', profissao: 'Product Manager'});
CREATE (p6:Pessoa {id: 6, nome: 'Roberto Alves', idade: 29, sexo: 'M', cidade: 'São Paulo', escolaridade: 'Superior Completo', profissao: 'Cientista de Dados'});
CREATE (p7:Pessoa {id: 7, nome: 'Patrícia Souza', idade: 26, sexo: 'F', cidade: 'Brasília', escolaridade: 'Superior Completo', profissao: 'Analista de Marketing'});
CREATE (p8:Pessoa {id: 8, nome: 'Lucas Mendes', idade: 33, sexo: 'M', cidade: 'Salvador', escolaridade: 'Pós-Graduação', profissao: 'DevOps Engineer'});
CREATE (p9:Pessoa {id: 9, nome: 'Amanda Costa', idade: 27, sexo: 'F', cidade: 'São Paulo', escolaridade: 'Superior Completo', profissao: 'UX Researcher'});
CREATE (p10:Pessoa {id: 10, nome: 'Ricardo Gomes', idade: 45, sexo: 'M', cidade: 'Rio de Janeiro', escolaridade: 'Doutorado', profissao: 'Professor Universitário'});
CREATE (p11:Pessoa {id: 11, nome: 'Juliana Ferreira', idade: 23, sexo: 'F', cidade: 'Belo Horizonte', escolaridade: 'Superior Incompleto', profissao: 'Estagiária de Marketing'});
CREATE (p12:Pessoa {id: 12, nome: 'André Rodrigues', idade: 38, sexo: 'M', cidade: 'Curitiba', escolaridade: 'Mestrado', profissao: 'Gerente de Projetos'});
CREATE (p13:Pessoa {id: 13, nome: 'Camila Nunes', idade: 29, sexo: 'F', cidade: 'Porto Alegre', escolaridade: 'Superior Completo', profissao: 'Advogada'});
CREATE (p14:Pessoa {id: 14, nome: 'Felipe Araújo', idade: 34, sexo: 'M', cidade: 'São Paulo', escolaridade: 'Superior Completo', profissao: 'Empreendedor'});
CREATE (p15:Pessoa {id: 15, nome: 'Larissa Castro', idade: 25, sexo: 'F', cidade: 'Rio de Janeiro', escolaridade: 'Superior Completo', profissao: 'Jornalista'});
CREATE (p16:Pessoa {id: 16, nome: 'Thiago Barbosa', idade: 41, sexo: 'M', cidade: 'Brasília', escolaridade: 'Pós-Graduação', profissao: 'Consultor Político'});
CREATE (p17:Pessoa {id: 17, nome: 'Beatriz Rocha', idade: 22, sexo: 'F', cidade: 'Salvador', escolaridade: 'Superior Incompleto', profissao: 'Estagiária de Design'});
CREATE (p18:Pessoa {id: 18, nome: 'Gustavo Martins', idade: 36, sexo: 'M', cidade: 'São Paulo', escolaridade: 'Mestrado', profissao: 'Tech Lead'});
CREATE (p19:Pessoa {id: 19, nome: 'Vanessa Cardoso', idade: 32, sexo: 'F', cidade: 'Curitiba', escolaridade: 'Superior Completo', profissao: 'Psicóloga'});
CREATE (p20:Pessoa {id: 20, nome: 'Bruno Teixeira', idade: 39, sexo: 'M', cidade: 'Belo Horizonte', escolaridade: 'Pós-Graduação', profissao: 'Administrador'});
CREATE (p21:Pessoa {id: 21, nome: 'Isabela Freitas', idade: 27, sexo: 'F', cidade: 'Porto Alegre', escolaridade: 'Superior Completo', profissao: 'Médica'});
CREATE (p22:Pessoa {id: 22, nome: 'Daniel Carvalho', idade: 44, sexo: 'M', cidade: 'São Paulo', escolaridade: 'Doutorado', profissao: 'Pesquisador'});
CREATE (p23:Pessoa {id: 23, nome: 'Renata Mendonça', idade: 30, sexo: 'F', cidade: 'Rio de Janeiro', escolaridade: 'Superior Completo', profissao: 'Arquiteta'});
CREATE (p24:Pessoa {id: 24, nome: 'Paulo Henrique', idade: 48, sexo: 'M', cidade: 'Brasília', escolaridade: 'Superior Completo', profissao: 'Empresário'});
CREATE (p25:Pessoa {id: 25, nome: 'Tatiana Borges', idade: 26, sexo: 'F', cidade: 'Salvador', escolaridade: 'Superior Completo', profissao: 'Publicitária'});
CREATE (p26:Pessoa {id: 26, nome: 'Marcelo Ribeiro', idade: 33, sexo: 'M', cidade: 'Curitiba', escolaridade: 'Pós-Graduação', profissao: 'Engenheiro Civil'});
CREATE (p27:Pessoa {id: 27, nome: 'Priscila Almeida', idade: 28, sexo: 'F', cidade: 'Belo Horizonte', escolaridade: 'Superior Completo', profissao: 'Farmacêutica'});
CREATE (p28:Pessoa {id: 28, nome: 'Eduardo Correia', idade: 52, sexo: 'M', cidade: 'São Paulo', escolaridade: 'Mestrado', profissao: 'Diretor Executivo'});
CREATE (p29:Pessoa {id: 29, nome: 'Gabriela Lopes', idade: 24, sexo: 'F', cidade: 'Porto Alegre', escolaridade: 'Superior Completo', profissao: 'Fotógrafa'});
CREATE (p30:Pessoa {id: 30, nome: 'Sérgio Monteiro', idade: 37, sexo: 'M', cidade: 'Rio de Janeiro', escolaridade: 'Pós-Graduação', profissao: 'Analista Financeiro'});

// 4.2 Verificação da criação das pessoas
MATCH (p:Pessoa) RETURN count(p) AS total_pessoas;

// ============================================
// PARTE 5: CRIAÇÃO DOS NÓS - POSTS (20 nós)
// ============================================

// 5.1 Criar posts com diferentes tipos de conteúdo
CREATE (po1:Post {id: 101, texto: 'Hoje aprendi sobre grafos! Muito interessante!', dataCriacao: datetime('2024-01-15T10:30:00'), midiaTipo: 'texto', curtidas: 45});
CREATE (po2:Post {id: 102, texto: 'Dica de livro: "Database Internals" - leitura obrigatória!', dataCriacao: datetime('2024-01-16T14:20:00'), midiaTipo: 'texto', curtidas: 32});
CREATE (po3:Post {id: 103, texto: 'Vista incrível hoje em São Paulo!', dataCriacao: datetime('2024-01-17T18:15:00'), midiaTipo: 'imagem', curtidas: 89});
CREATE (po4:Post {id: 104, texto: 'Evento de tecnologia nesse final de semana', dataCriacao: datetime('2024-01-18T09:00:00'), midiaTipo: 'texto', curtidas: 56});
CREATE (po5:Post {id: 105, texto: 'Reflexão: a vida é feita de conexões', dataCriacao: datetime('2024-01-19T20:30:00'), midiaTipo: 'texto', curtidas: 128});
CREATE (po6:Post {id: 106, texto: 'Novo projeto open-source lançado!', dataCriacao: datetime('2024-01-20T11:45:00'), midiaTipo: 'texto', curtidas: 234});
CREATE (po7:Post {id: 107, texto: 'Playlist para codar no flow', dataCriacao: datetime('2024-01-21T16:00:00'), midiaTipo: 'video', curtidas: 67});
CREATE (po8:Post {id: 108, texto: 'Workshop de Cypher básico', dataCriacao: datetime('2024-01-22T13:30:00'), midiaTipo: 'texto', curtidas: 112});
CREATE (po9:Post {id: 109, texto: 'Meu setup de trabalho atual', dataCriacao: datetime('2024-01-23T10:00:00'), midiaTipo: 'imagem', curtidas: 445});
CREATE (po10:Post {id: 110, texto: 'Dúvida: qual banco de dados usar para analytics?', dataCriacao: datetime('2024-01-24T15:20:00'), midiaTipo: 'texto', curtidas: 78});
CREATE (po11:Post {id: 111, texto: 'Fim de semana merecido!', dataCriacao: datetime('2024-01-25T19:00:00'), midiaTipo: 'imagem', curtidas: 156});
CREATE (po12:Post {id: 112, texto: 'Dica de ferramenta: Neo4j Bloom é sensacional!', dataCriacao: datetime('2024-01-26T12:15:00'), midiaTipo: 'texto', curtidas: 89});
CREATE (po13:Post {id: 113, texto: 'Participando de um hackathon esse mês', dataCriacao: datetime('2024-01-27T08:45:00'), midiaTipo: 'texto', curtidas: 203});
CREATE (po14:Post {id: 114, texto: 'Café e código ☕', dataCriacao: datetime('2024-01-28T09:30:00'), midiaTipo: 'imagem', curtidas: 312});
CREATE (po15:Post {id: 115, texto: 'Review do novo framework', dataCriacao: datetime('2024-01-29T17:00:00'), midiaTipo: 'video', curtidas: 45});
CREATE (po16:Post {id: 116, texto: 'Pensando em mudar de área... opiniões?', dataCriacao: datetime('2024-01-30T14:30:00'), midiaTipo: 'texto', curtidas: 234});
CREATE (po17:Post {id: 117, texto: 'Viagem incrível para o Chile', dataCriacao: datetime('2024-02-01T11:00:00'), midiaTipo: 'imagem', curtidas: 567});
CREATE (po18:Post {id: 118, texto: 'Webinar sobre Inteligência Artificial', dataCriacao: datetime('2024-02-02T16:30:00'), midiaTipo: 'texto', curtidas: 89});
CREATE (po19:Post {id: 119, texto: 'Meu primeiro artigo publicado!', dataCriacao: datetime('2024-02-03T10:15:00'), midiaTipo: 'texto', curtidas: 678});
CREATE (po20:Post {id: 120, texto: 'Gratidão por mais um ano', dataCriacao: datetime('2024-02-04T20:00:00'), midiaTipo: 'texto', curtidas: 345});

// 5.2 Verificação da criação dos posts
MATCH (po:Post) RETURN count(po) AS total_posts;

// ============================================
// PARTE 6: CRIAÇÃO DOS NÓS - GRUPOS (10 nós)
// ============================================

// 6.1 Criar grupos temáticos
CREATE (g1:Grupo {id: 1, nome: 'Tecnologia', descricao: 'Discussões sobre tecnologia e inovação', categoria: 'Tecnologia'});
CREATE (g2:Grupo {id: 2, nome: 'Desenvolvimento de Software', descricao: 'Comunidade de devs', categoria: 'Programação'});
CREATE (g3:Grupo {id: 3, nome: 'Data Science Brasil', descricao: 'Análise de dados e IA', categoria: 'Dados'});
CREATE (g4:Grupo {id: 4, nome: 'Design e UX', descricao: 'Designers e UX researchers', categoria: 'Design'});
CREATE (g5:Grupo {id: 5, nome: 'Empreendedorismo', descricao: 'Startups e negócios', categoria: 'Negócios'});
CREATE (g6:Grupo {id: 6, nome: 'Marketing Digital', descricao: 'Estratégias de marketing', categoria: 'Marketing'});
CREATE (g7:Grupo {id: 7, nome: 'Viagens', descricao: 'Dicas de viagem e turismo', categoria: 'Lazer'});
CREATE (g8:Grupo {id: 8, nome: 'Saúde e Bem-estar', descricao: 'Dicas de saúde e qualidade de vida', categoria: 'Saúde'});
CREATE (g9:Grupo {id: 9, nome: 'Carreira e Networking', descricao: 'Oportunidades e conexões profissionais', categoria: 'Carreira'});
CREATE (g10:Grupo {id: 10, nome: 'Cultura e Entretenimento', descricao: 'Arte, música e cinema', categoria: 'Cultura'});

// 6.2 Verificação da criação dos grupos
MATCH (g:Grupo) RETURN count(g) AS total_grupos;

// ============================================
// PARTE 7: CRIAÇÃO DOS NÓS - COMUNIDADES (5 nós)
// ============================================

// 7.1 Criar comunidades dentro dos grupos
CREATE (c1:Comunidade {id: 1, nome: 'Neo4j Users Brasil', tipo: 'Tecnologia'});
CREATE (c2:Comunidade {id: 2, nome: 'Python Brasil', tipo: 'Programação'});
CREATE (c3:Comunidade {id: 3, nome: 'Mulheres na Tecnologia', tipo: 'Diversidade'});
CREATE (c4:Comunidade {id: 4, nome: 'Startups SP', tipo: 'Negócios'});
CREATE (c5:Comunidade {id: 5, nome: 'UI/UX Designers', tipo: 'Design'});

// 7.2 Verificação da criação das comunidades
MATCH (c:Comunidade) RETURN count(c) AS total_comunidades;

// ============================================
// PARTE 8: CRIAÇÃO DOS RELACIONAMENTOS - SEGUE (42 relacionamentos)
// ============================================

// 8.1 Criar relacionamentos de seguir
MATCH (p1:Pessoa {id: 1}), (p2:Pessoa {id: 2}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 1}), (p2:Pessoa {id: 3}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-12')}]->(p2);
MATCH (p1:Pessoa {id: 1}), (p2:Pessoa {id: 6}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-15')}]->(p2);
MATCH (p1:Pessoa {id: 2}), (p2:Pessoa {id: 4}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-08')}]->(p2);
MATCH (p1:Pessoa {id: 2}), (p2:Pessoa {id: 8}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-09')}]->(p2);
MATCH (p1:Pessoa {id: 3}), (p2:Pessoa {id: 1}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-14')}]->(p2);
MATCH (p1:Pessoa {id: 3}), (p2:Pessoa {id: 5}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-16')}]->(p2);
MATCH (p1:Pessoa {id: 4}), (p2:Pessoa {id: 2}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-05')}]->(p2);
MATCH (p1:Pessoa {id: 4}), (p2:Pessoa {id: 10}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-07')}]->(p2);
MATCH (p1:Pessoa {id: 5}), (p2:Pessoa {id: 1}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-11')}]->(p2);
MATCH (p1:Pessoa {id: 5}), (p2:Pessoa {id: 9}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-13')}]->(p2);
MATCH (p1:Pessoa {id: 5}), (p2:Pessoa {id: 12}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-15')}]->(p2);
MATCH (p1:Pessoa {id: 6}), (p2:Pessoa {id: 1}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-09')}]->(p2);
MATCH (p1:Pessoa {id: 6}), (p2:Pessoa {id: 3}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 6}), (p2:Pessoa {id: 8}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-12')}]->(p2);
MATCH (p1:Pessoa {id: 7}), (p2:Pessoa {id: 5}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-14')}]->(p2);
MATCH (p1:Pessoa {id: 7}), (p2:Pessoa {id: 11}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-15')}]->(p2);
MATCH (p1:Pessoa {id: 8}), (p2:Pessoa {id: 2}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-06')}]->(p2);
MATCH (p1:Pessoa {id: 8}), (p2:Pessoa {id: 6}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-08')}]->(p2);
MATCH (p1:Pessoa {id: 8}), (p2:Pessoa {id: 14}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 9}), (p2:Pessoa {id: 5}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-12')}]->(p2);
MATCH (p1:Pessoa {id: 9}), (p2:Pessoa {id: 15}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-13')}]->(p2);
MATCH (p1:Pessoa {id: 10}), (p2:Pessoa {id: 4}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-05')}]->(p2);
MATCH (p1:Pessoa {id: 10}), (p2:Pessoa {id: 22}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-07')}]->(p2);
MATCH (p1:Pessoa {id: 11}), (p2:Pessoa {id: 7}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-16')}]->(p2);
MATCH (p1:Pessoa {id: 11}), (p2:Pessoa {id: 17}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-18')}]->(p2);
MATCH (p1:Pessoa {id: 12}), (p2:Pessoa {id: 5}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 12}), (p2:Pessoa {id: 20}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-12')}]->(p2);
MATCH (p1:Pessoa {id: 13}), (p2:Pessoa {id: 21}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-09')}]->(p2);
MATCH (p1:Pessoa {id: 13}), (p2:Pessoa {id: 23}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-11')}]->(p2);
MATCH (p1:Pessoa {id: 14}), (p2:Pessoa {id: 8}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-08')}]->(p2);
MATCH (p1:Pessoa {id: 14}), (p2:Pessoa {id: 18}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 15}), (p2:Pessoa {id: 9}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-14')}]->(p2);
MATCH (p1:Pessoa {id: 15}), (p2:Pessoa {id: 25}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-16')}]->(p2);
MATCH (p1:Pessoa {id: 16}), (p2:Pessoa {id: 24}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-05')}]->(p2);
MATCH (p1:Pessoa {id: 16}), (p2:Pessoa {id: 28}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-07')}]->(p2);
MATCH (p1:Pessoa {id: 17}), (p2:Pessoa {id: 11}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-19')}]->(p2);
MATCH (p1:Pessoa {id: 17}), (p2:Pessoa {id: 29}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-21')}]->(p2);
MATCH (p1:Pessoa {id: 18}), (p2:Pessoa {id: 14}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-09')}]->(p2);
MATCH (p1:Pessoa {id: 18}), (p2:Pessoa {id: 22}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-11')}]->(p2);
MATCH (p1:Pessoa {id: 19}), (p2:Pessoa {id: 27}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-13')}]->(p2);
MATCH (p1:Pessoa {id: 19}), (p2:Pessoa {id: 30}) CREATE (p1)-[:SEGUE {dataInicio: date('2024-01-15')}]->(p2);

// 8.2 Verificação dos relacionamentos SEGUE
MATCH ()-[r:SEGUE]->() RETURN count(r) AS total_segue;

// ============================================
// PARTE 9: CRIAÇÃO DOS RELACIONAMENTOS - AMIGO_DE (20 relacionamentos)
// ============================================

// 9.1 Criar relacionamentos de amizade mútua
MATCH (p1:Pessoa {id: 1}), (p2:Pessoa {id: 2}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-12-15')}]->(p2);
MATCH (p1:Pessoa {id: 2}), (p2:Pessoa {id: 1}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-12-15')}]->(p2);
MATCH (p1:Pessoa {id: 1}), (p2:Pessoa {id: 3}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-05')}]->(p2);
MATCH (p1:Pessoa {id: 3}), (p2:Pessoa {id: 1}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-05')}]->(p2);
MATCH (p1:Pessoa {id: 2}), (p2:Pessoa {id: 4}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-11-20')}]->(p2);
MATCH (p1:Pessoa {id: 4}), (p2:Pessoa {id: 2}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-11-20')}]->(p2);
MATCH (p1:Pessoa {id: 3}), (p2:Pessoa {id: 5}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 5}), (p2:Pessoa {id: 3}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-10')}]->(p2);
MATCH (p1:Pessoa {id: 5}), (p2:Pessoa {id: 6}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-12-01')}]->(p2);
MATCH (p1:Pessoa {id: 6}), (p2:Pessoa {id: 5}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-12-01')}]->(p2);
MATCH (p1:Pessoa {id: 6}), (p2:Pessoa {id: 8}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-08')}]->(p2);
MATCH (p1:Pessoa {id: 8}), (p2:Pessoa {id: 6}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-08')}]->(p2);
MATCH (p1:Pessoa {id: 7}), (p2:Pessoa {id: 9}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-12-20')}]->(p2);
MATCH (p1:Pessoa {id: 9}), (p2:Pessoa {id: 7}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-12-20')}]->(p2);
MATCH (p1:Pessoa {id: 10}), (p2:Pessoa {id: 22}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-10-15')}]->(p2);
MATCH (p1:Pessoa {id: 22}), (p2:Pessoa {id: 10}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-10-15')}]->(p2);
MATCH (p1:Pessoa {id: 11}), (p2:Pessoa {id: 17}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-12')}]->(p2);
MATCH (p1:Pessoa {id: 17}), (p2:Pessoa {id: 11}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2024-01-12')}]->(p2);
MATCH (p1:Pessoa {id: 14}), (p2:Pessoa {id: 18}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-11-30')}]->(p2);
MATCH (p1:Pessoa {id: 18}), (p2:Pessoa {id: 14}) CREATE (p1)-[:AMIGO_DE {dataAmizade: date('2023-11-30')}]->(p2);

// 9.2 Verificação dos relacionamentos AMIGO_DE
MATCH ()-[r:AMIGO_DE]->() RETURN count(r) AS total_amizades;

// ============================================
// PARTE 10: CRIAÇÃO DOS RELACIONAMENTOS - POSTOU (30 relacionamentos)
// ============================================

// 10.1 Associar pessoas aos posts que criaram
MATCH (p:Pessoa {id: 1}), (po:Post {id: 101}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-15T10:30:00')}]->(po);
MATCH (p:Pessoa {id: 2}), (po:Post {id: 102}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-16T14:20:00')}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 103}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-17T18:15:00')}]->(po);
MATCH (p:Pessoa {id: 4}), (po:Post {id: 104}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-18T09:00:00')}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 105}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-19T20:30:00')}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 106}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-20T11:45:00')}]->(po);
MATCH (p:Pessoa {id: 7}), (po:Post {id: 107}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-21T16:00:00')}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 108}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-22T13:30:00')}]->(po);
MATCH (p:Pessoa {id: 9}), (po:Post {id: 109}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-23T10:00:00')}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 110}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-24T15:20:00')}]->(po);
MATCH (p:Pessoa {id: 11}), (po:Post {id: 111}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-25T19:00:00')}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 112}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-26T12:15:00')}]->(po);
MATCH (p:Pessoa {id: 13}), (po:Post {id: 113}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-27T08:45:00')}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 114}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-28T09:30:00')}]->(po);
MATCH (p:Pessoa {id: 15}), (po:Post {id: 115}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-29T17:00:00')}]->(po);
MATCH (p:Pessoa {id: 16}), (po:Post {id: 116}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-30T14:30:00')}]->(po);
MATCH (p:Pessoa {id: 17}), (po:Post {id: 117}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-02-01T11:00:00')}]->(po);
MATCH (p:Pessoa {id: 18}), (po:Post {id: 118}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-02-02T16:30:00')}]->(po);
MATCH (p:Pessoa {id: 19}), (po:Post {id: 119}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-02-03T10:15:00')}]->(po);
MATCH (p:Pessoa {id: 20}), (po:Post {id: 120}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-02-04T20:00:00')}]->(po);
MATCH (p:Pessoa {id: 21}), (po:Post {id: 101}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-16T08:00:00')}]->(po);
MATCH (p:Pessoa {id: 22}), (po:Post {id: 103}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-18T14:30:00')}]->(po);
MATCH (p:Pessoa {id: 23}), (po:Post {id: 105}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-20T19:15:00')}]->(po);
MATCH (p:Pessoa {id: 24}), (po:Post {id: 107}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-22T11:45:00')}]->(po);
MATCH (p:Pessoa {id: 25}), (po:Post {id: 109}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-24T09:20:00')}]->(po);
MATCH (p:Pessoa {id: 26}), (po:Post {id: 111}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-26T16:30:00')}]->(po);
MATCH (p:Pessoa {id: 27}), (po:Post {id: 113}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-28T12:00:00')}]->(po);
MATCH (p:Pessoa {id: 28}), (po:Post {id: 115}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-01-30T18:45:00')}]->(po);
MATCH (p:Pessoa {id: 29}), (po:Post {id: 117}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-02-02T14:20:00')}]->(po);
MATCH (p:Pessoa {id: 30}), (po:Post {id: 119}) CREATE (p)-[:POSTOU {dataHora: datetime('2024-02-04T22:00:00')}]->(po);

// 10.2 Verificação dos relacionamentos POSTOU
MATCH ()-[r:POSTOU]->() RETURN count(r) AS total_postou;

// ============================================
// PARTE 11: CRIAÇÃO DOS RELACIONAMENTOS - CURTIU (53 relacionamentos)
// ============================================

// 11.1 Associar pessoas aos posts que curtiram
MATCH (p:Pessoa {id: 1}), (po:Post {id: 102}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-17T09:15:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 1}), (po:Post {id: 106}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-21T14:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 2}), (po:Post {id: 101}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-16T11:20:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 2}), (po:Post {id: 108}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-23T15:45:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 101}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-16T18:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 105}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-20T22:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 109}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-24T12:15:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 4}), (po:Post {id: 102}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-17T10:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 4}), (po:Post {id: 112}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-27T09:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 103}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-18T19:45:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 107}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-22T17:20:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 114}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-29T10:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 104}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-19T08:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 108}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-23T14:15:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 116}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-31T16:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 7}), (po:Post {id: 105}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-20T21:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 7}), (po:Post {id: 111}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-26T20:15:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 106}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-21T12:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 110}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-25T16:45:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 9}), (po:Post {id: 107}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-22T18:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 9}), (po:Post {id: 113}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-28T09:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 109}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-24T11:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 115}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-30T19:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 11}), (po:Post {id: 108}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-23T13:45:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 11}), (po:Post {id: 112}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-27T10:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 109}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-24T14:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 117}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-02T12:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 13}), (po:Post {id: 110}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-25T09:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 13}), (po:Post {id: 118}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-03T15:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 111}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-26T22:15:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 114}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-29T12:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 15}), (po:Post {id: 112}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-27T14:45:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 15}), (po:Post {id: 119}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-04T11:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 16}), (po:Post {id: 113}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-28T10:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 16}), (po:Post {id: 116}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-31T20:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 17}), (po:Post {id: 114}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-29T13:15:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 17}), (po:Post {id: 117}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-02T10:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 18}), (po:Post {id: 115}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-30T20:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 18}), (po:Post {id: 118}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-03T17:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 19}), (po:Post {id: 116}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-31T18:45:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 19}), (po:Post {id: 119}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-04T09:15:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 20}), (po:Post {id: 117}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-02T15:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 20}), (po:Post {id: 120}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-05T21:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 21}), (po:Post {id: 118}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-03T18:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 22}), (po:Post {id: 119}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-04T14:30:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 23}), (po:Post {id: 120}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-02-05T19:15:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 24}), (po:Post {id: 101}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-16T07:00:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 25}), (po:Post {id: 103}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-18T20:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 26}), (po:Post {id: 105}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-20T23:15:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 27}), (po:Post {id: 107}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-22T19:00:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 28}), (po:Post {id: 109}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-24T15:45:00'), dispositivo: 'web'}]->(po);
MATCH (p:Pessoa {id: 29}), (po:Post {id: 111}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-26T23:30:00'), dispositivo: 'mobile'}]->(po);
MATCH (p:Pessoa {id: 30}), (po:Post {id: 113}) CREATE (p)-[:CURTIU {dataHora: datetime('2024-01-28T13:00:00'), dispositivo: 'web'}]->(po);

// 11.2 Verificação dos relacionamentos CURTIU
MATCH ()-[r:CURTIU]->() RETURN count(r) AS total_curtiu;

// ============================================
// PARTE 12: CRIAÇÃO DOS RELACIONAMENTOS - PERTENCE (54 relacionamentos)
// ============================================

// 12.1 Associar pessoas aos grupos
MATCH (p:Pessoa {id: 1}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-10'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 1}), (g:Grupo {id: 2}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-10'), cargo: 'moderador'}]->(g);
MATCH (p:Pessoa {id: 2}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-05'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 2}), (g:Grupo {id: 3}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-05'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 3}), (g:Grupo {id: 4}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-08'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 3}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-08'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 4}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-03'), cargo: 'admin'}]->(g);
MATCH (p:Pessoa {id: 4}), (g:Grupo {id: 2}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-03'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 5}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-12'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 5}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-12'), cargo: 'moderador'}]->(g);
MATCH (p:Pessoa {id: 6}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-07'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 6}), (g:Grupo {id: 3}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-07'), cargo: 'admin'}]->(g);
MATCH (p:Pessoa {id: 7}), (g:Grupo {id: 6}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-09'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 7}), (g:Grupo {id: 9}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-09'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 8}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-06'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 8}), (g:Grupo {id: 2}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-06'), cargo: 'moderador'}]->(g);
MATCH (p:Pessoa {id: 9}), (g:Grupo {id: 4}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-11'), cargo: 'admin'}]->(g);
MATCH (p:Pessoa {id: 9}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-11'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 10}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-04'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 10}), (g:Grupo {id: 10}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-04'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 11}), (g:Grupo {id: 6}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-13'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 11}), (g:Grupo {id: 9}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-13'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 12}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-08'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 12}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-08'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 13}), (g:Grupo {id: 8}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-07'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 13}), (g:Grupo {id: 9}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-07'), cargo: 'moderador'}]->(g);
MATCH (p:Pessoa {id: 14}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-09'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 14}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-09'), cargo: 'admin'}]->(g);
MATCH (p:Pessoa {id: 15}), (g:Grupo {id: 6}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-10'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 15}), (g:Grupo {id: 10}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-10'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 16}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-05'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 16}), (g:Grupo {id: 9}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-05'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 17}), (g:Grupo {id: 4}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-12'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 17}), (g:Grupo {id: 7}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-12'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 18}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-06'), cargo: 'moderador'}]->(g);
MATCH (p:Pessoa {id: 18}), (g:Grupo {id: 2}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-06'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 19}), (g:Grupo {id: 8}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-11'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 19}), (g:Grupo {id: 9}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-11'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 20}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-08'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 20}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-08'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 21}), (g:Grupo {id: 8}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-09'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 22}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-04'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 22}), (g:Grupo {id: 3}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-04'), cargo: 'admin'}]->(g);
MATCH (p:Pessoa {id: 23}), (g:Grupo {id: 4}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-10'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 24}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-03'), cargo: 'moderador'}]->(g);
MATCH (p:Pessoa {id: 25}), (g:Grupo {id: 6}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-11'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 26}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-07'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 27}), (g:Grupo {id: 8}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-12'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 28}), (g:Grupo {id: 1}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-05'), cargo: 'admin'}]->(g);
MATCH (p:Pessoa {id: 28}), (g:Grupo {id: 5}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-05'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 29}), (g:Grupo {id: 7}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-13'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 29}), (g:Grupo {id: 10}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-13'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 30}), (g:Grupo {id: 8}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-14'), cargo: 'membro'}]->(g);
MATCH (p:Pessoa {id: 30}), (g:Grupo {id: 9}) CREATE (p)-[:PERTENCE {dataEntrada: date('2024-01-14'), cargo: 'membro'}]->(g);

// 12.2 Verificação dos relacionamentos PERTENCE
MATCH ()-[r:PERTENCE]->() RETURN count(r) AS total_pertence;

// ============================================
// PARTE 13: CRIAÇÃO DOS RELACIONAMENTOS - PARTICIPA (20 relacionamentos)
// ============================================

// 13.1 Associar pessoas às comunidades
MATCH (p:Pessoa {id: 1}), (c:Comunidade {id: 1}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-15'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 2}), (c:Comunidade {id: 1}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-10'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 3}), (c:Comunidade {id: 5}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-12'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 4}), (c:Comunidade {id: 2}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-08'), nivelAtividade: 'baixo'}]->(c);
MATCH (p:Pessoa {id: 5}), (c:Comunidade {id: 4}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-14'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 6}), (c:Comunidade {id: 1}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-09'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 6}), (c:Comunidade {id: 2}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-09'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 7}), (c:Comunidade {id: 3}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-11'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 8}), (c:Comunidade {id: 1}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-07'), nivelAtividade: 'baixo'}]->(c);
MATCH (p:Pessoa {id: 9}), (c:Comunidade {id: 5}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-13'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 10}), (c:Comunidade {id: 1}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-05'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 14}), (c:Comunidade {id: 4}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-10'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 18}), (c:Comunidade {id: 2}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-08'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 20}), (c:Comunidade {id: 4}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-12'), nivelAtividade: 'baixo'}]->(c);
MATCH (p:Pessoa {id: 22}), (c:Comunidade {id: 1}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-06'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 22}), (c:Comunidade {id: 2}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-06'), nivelAtividade: 'alto'}]->(c);
MATCH (p:Pessoa {id: 23}), (c:Comunidade {id: 5}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-14'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 25}), (c:Comunidade {id: 3}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-13'), nivelAtividade: 'baixo'}]->(c);
MATCH (p:Pessoa {id: 28}), (c:Comunidade {id: 4}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-09'), nivelAtividade: 'medio'}]->(c);
MATCH (p:Pessoa {id: 29}), (c:Comunidade {id: 5}) CREATE (p)-[:PARTICIPA {dataEntrada: date('2024-01-15'), nivelAtividade: 'alto'}]->(c);

// 13.2 Verificação dos relacionamentos PARTICIPA
MATCH ()-[r:PARTICIPA]->() RETURN count(r) AS total_participa;

// ============================================
// PARTE 14: CRIAÇÃO DOS RELACIONAMENTOS - COMENTOU (15 relacionamentos)
// ============================================

// 14.1 Criar comentários em posts
MATCH (p:Pessoa {id: 1}), (po:Post {id: 102}) CREATE (p)-[:COMENTOU {texto: 'Ótima recomendação!', dataHora: datetime('2024-01-17T15:30:00')}]->(po);
MATCH (p:Pessoa {id: 2}), (po:Post {id: 101}) CREATE (p)-[:COMENTOU {texto: 'Grafos são incríveis mesmo!', dataHora: datetime('2024-01-16T14:00:00')}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 106}) CREATE (p)-[:COMENTOU {texto: 'Compartilha o link do projeto?', dataHora: datetime('2024-01-21T10:30:00')}]->(po);
MATCH (p:Pessoa {id: 4}), (po:Post {id: 105}) CREATE (p)-[:COMENTOU {texto: 'Belas palavras!', dataHora: datetime('2024-01-20T22:15:00')}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 109}) CREATE (p)-[:COMENTOU {texto: 'Setup top demais!', dataHora: datetime('2024-01-24T13:45:00')}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 108}) CREATE (p)-[:COMENTOU {texto: 'Vou participar, obrigado!', dataHora: datetime('2024-01-23T16:00:00')}]->(po);
MATCH (p:Pessoa {id: 7}), (po:Post {id: 107}) CREATE (p)-[:COMENTOU {texto: 'Compartilha a playlist?', dataHora: datetime('2024-01-22T19:30:00')}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 112}) CREATE (p)-[:COMENTOU {texto: 'Bloom é fantástico!', dataHora: datetime('2024-01-27T11:00:00')}]->(po);
MATCH (p:Pessoa {id: 9}), (po:Post {id: 114}) CREATE (p)-[:COMENTOU {texto: 'Café sempre presente!', dataHora: datetime('2024-01-29T14:30:00')}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 116}) CREATE (p)-[:COMENTOU {texto: 'Mudar de área é sempre desafiador', dataHora: datetime('2024-01-31T09:00:00')}]->(po);
MATCH (p:Pessoa {id: 11}), (po:Post {id: 117}) CREATE (p)-[:COMENTOU {texto: 'Que foto linda!', dataHora: datetime('2024-02-02T13:15:00')}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 119}) CREATE (p)-[:COMENTOU {texto: 'Parabéns pelo artigo!', dataHora: datetime('2024-02-04T11:45:00')}]->(po);
MATCH (p:Pessoa {id: 13}), (po:Post {id: 118}) CREATE (p)-[:COMENTOU {texto: 'Vou me inscrever!', dataHora: datetime('2024-02-03T19:00:00')}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 120}) CREATE (p)-[:COMENTOU {texto: 'Gratidão é tudo!', dataHora: datetime('2024-02-05T10:30:00')}]->(po);
MATCH (p:Pessoa {id: 15}), (po:Post {id: 103}) CREATE (p)-[:COMENTOU {texto: 'Que vista incrível!', dataHora: datetime('2024-01-18T20:00:00')}]->(po);

// 14.2 Verificação dos relacionamentos COMENTOU
MATCH ()-[r:COMENTOU]->() RETURN count(r) AS total_comentou;

// ============================================
// PARTE 15: CRIAÇÃO DOS RELACIONAMENTOS - VIU (40 relacionamentos)
// ============================================

// 15.1 Criar visualizações de posts
MATCH (p:Pessoa {id: 1}), (po:Post {id: 103}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-18T10:00:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 1}), (po:Post {id: 104}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-19T14:30:00'), duracao: 30}]->(po);
MATCH (p:Pessoa {id: 2}), (po:Post {id: 105}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-20T08:15:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 2}), (po:Post {id: 106}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-21T09:45:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 107}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-22T11:00:00'), duracao: 120}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 108}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-23T15:30:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 4}), (po:Post {id: 109}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-24T12:00:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 4}), (po:Post {id: 110}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-25T16:45:00'), duracao: 75}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 111}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-26T18:30:00'), duracao: 30}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 112}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-27T13:15:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 113}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-28T10:00:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 114}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-29T14:30:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 7}), (po:Post {id: 115}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-30T19:15:00'), duracao: 120}]->(po);
MATCH (p:Pessoa {id: 7}), (po:Post {id: 116}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-31T20:30:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 117}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-01T15:00:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 118}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-02T11:45:00'), duracao: 75}]->(po);
MATCH (p:Pessoa {id: 9}), (po:Post {id: 119}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-03T09:30:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 9}), (po:Post {id: 120}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-04T16:15:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 101}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-16T09:00:00'), duracao: 30}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 102}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-17T13:30:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 11}), (po:Post {id: 103}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-18T17:45:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 11}), (po:Post {id: 104}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-19T12:15:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 105}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-20T19:30:00'), duracao: 75}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 106}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-21T14:00:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 13}), (po:Post {id: 107}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-22T16:30:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 13}), (po:Post {id: 108}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-23T18:15:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 109}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-24T20:00:00'), duracao: 120}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 110}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-25T11:30:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 15}), (po:Post {id: 111}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-26T21:45:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 15}), (po:Post {id: 112}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-27T15:00:00'), duracao: 75}]->(po);
MATCH (p:Pessoa {id: 16}), (po:Post {id: 113}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-28T12:30:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 16}), (po:Post {id: 114}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-29T17:45:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 17}), (po:Post {id: 115}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-30T22:00:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 17}), (po:Post {id: 116}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-31T14:30:00'), duracao: 30}]->(po);
MATCH (p:Pessoa {id: 18}), (po:Post {id: 117}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-01T18:15:00'), duracao: 60}]->(po);
MATCH (p:Pessoa {id: 18}), (po:Post {id: 118}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-02T20:30:00'), duracao: 75}]->(po);
MATCH (p:Pessoa {id: 19}), (po:Post {id: 119}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-03T22:00:00'), duracao: 90}]->(po);
MATCH (p:Pessoa {id: 19}), (po:Post {id: 120}) CREATE (p)-[:VIU {dataHora: datetime('2024-02-04T19:45:00'), duracao: 45}]->(po);
MATCH (p:Pessoa {id: 20}), (po:Post {id: 101}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-16T11:00:00'), duracao: 30}]->(po);
MATCH (p:Pessoa {id: 20}), (po:Post {id: 102}) CREATE (p)-[:VIU {dataHora: datetime('2024-01-17T14:00:00'), duracao: 60}]->(po);

// 15.2 Verificação dos relacionamentos VIU
MATCH ()-[r:VIU]->() RETURN count(r) AS total_viu;

// ============================================
// PARTE 16: CRIAÇÃO DOS RELACIONAMENTOS - REPOSTOU (10 relacionamentos)
// ============================================

// 16.1 Criar repostagens de posts
MATCH (p:Pessoa {id: 1}), (po:Post {id: 105}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-21T09:00:00'), comentario: 'Compartilhando essa reflexão!'}]->(po);
MATCH (p:Pessoa {id: 3}), (po:Post {id: 106}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-22T14:30:00'), comentario: 'Projeto incrível!'}]->(po);
MATCH (p:Pessoa {id: 5}), (po:Post {id: 109}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-25T11:15:00'), comentario: 'Meu setup também!'}]->(po);
MATCH (p:Pessoa {id: 6}), (po:Post {id: 112}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-28T16:45:00'), comentario: 'Ferramenta indispensável'}]->(po);
MATCH (p:Pessoa {id: 8}), (po:Post {id: 108}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-24T10:30:00'), comentario: 'Workshop gratuito!'}]->(po);
MATCH (p:Pessoa {id: 10}), (po:Post {id: 118}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-02-04T09:00:00'), comentario: 'Recomendo a todos'}]->(po);
MATCH (p:Pessoa {id: 12}), (po:Post {id: 119}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-02-05T14:30:00'), comentario: 'Artigo muito relevante'}]->(po);
MATCH (p:Pessoa {id: 14}), (po:Post {id: 114}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-30T08:45:00'), comentario: 'Café e código é vida!'}]->(po);
MATCH (p:Pessoa {id: 17}), (po:Post {id: 117}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-02-03T19:30:00'), comentario: 'Lugar incrível!'}]->(po);
MATCH (p:Pessoa {id: 22}), (po:Post {id: 101}) CREATE (p)-[:REPOSTOU {dataHora: datetime('2024-01-17T22:00:00'), comentario: 'Excelente conteúdo'}]->(po);

// 16.2 Verificação dos relacionamentos REPOSTOU
MATCH ()-[r:REPOSTOU]->() RETURN count(r) AS total_repostou;

// ============================================
// PARTE 17: VERIFICAÇÃO FINAL DOS DADOS
// ============================================

// 17.1 Contagem total de nós por label
MATCH (p:Pessoa) RETURN 'Pessoa' AS Label, count(p) AS Total
UNION ALL
MATCH (po:Post) RETURN 'Post' AS Label, count(po) AS Total
UNION ALL
MATCH (g:Grupo) RETURN 'Grupo' AS Label, count(g) AS Total
UNION ALL
MATCH (c:Comunidade) RETURN 'Comunidade' AS Label, count(c) AS Total;

// 17.2 Contagem total de relacionamentos por tipo
MATCH ()-[r:SEGUE]->() RETURN 'SEGUE' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:AMIGO_DE]->() RETURN 'AMIGO_DE' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:POSTOU]->() RETURN 'POSTOU' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:CURTIU]->() RETURN 'CURTIU' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:PERTENCE]->() RETURN 'PERTENCE' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:PARTICIPA]->() RETURN 'PARTICIPA' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:COMENTOU]->() RETURN 'COMENTOU' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:VIU]->() RETURN 'VIU' AS Tipo, count(r) AS Total
UNION ALL
MATCH ()-[r:REPOSTOU]->() RETURN 'REPOSTOU' AS Tipo, count(r) AS Total;
