
// ============================================
// PARTE 18: EXPLAIN PLAN PARA AVALIAR QUERIES
// ============================================

// 18.1 Explain plan para busca de caminho mais curto
EXPLAIN
MATCH path = shortestPath(
    (a:Pessoa {nome: 'Ana Silva'})-[*]-(b:Pessoa {nome: 'Carlos Santos'})
)
RETURN length(path) AS distancia, [node IN nodes(path) | node.nome] AS caminho;

// 18.2 Explain plan para recomendações baseadas em interesses comuns
EXPLAIN
MATCH (p:Pessoa {nome: 'Ana Silva'})-[:CURTIU]->(post:Post)<-[:CURTIU]-(candidato:Pessoa)
WHERE NOT EXISTS((p)-[:SEGUE]->(candidato))
  AND p <> candidato
WITH candidato, COUNT(DISTINCT post) AS posts_comuns
RETURN candidato.nome AS recomendado, posts_comuns
ORDER BY posts_comuns DESC LIMIT 5;

// 18.3 Explain plan para análise de público por grupo
EXPLAIN
MATCH (g:Grupo {nome: 'Tecnologia'})<-[:PERTENCE]-(p:Pessoa)
RETURN AVG(p.idade) AS idade_media,
       COUNT(CASE WHEN p.sexo = 'M' THEN 1 END) AS homens,
       COUNT(CASE WHEN p.sexo = 'F' THEN 1 END) AS mulheres,
       COLLECT(DISTINCT p.profissao)[0..5] AS profissoes_comuns;

// 18.4 Explain plan para análise de seguidores (node degree)
EXPLAIN
MATCH (p:Pessoa)
WITH p, count{ (p)<-[:SEGUE]-() } AS seguidores
RETURN p.nome AS usuario, seguidores
ORDER BY seguidores DESC LIMIT 10;

// ============================================
// FIM DO SCRIPT
// ============================================