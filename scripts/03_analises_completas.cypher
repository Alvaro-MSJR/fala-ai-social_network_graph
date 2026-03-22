
// *********************************************
// * Para execução das analises e necessário 
// * ter o banco de dados criado e populado
// * com os scripts anteriores:
// * 01_criacao_banco.cypher
// * 02_analise_queries.cypher
// *********************************************


//## 🔍 Queries de Negócio e Análises

//### 1. Cypher Implicit Aggregations

//Objetivo: Analisar distribuições agregadas de forma simples.

	cypher
	// Distribuição de usuários por faixa etária
	MATCH (p:Pessoa)
	RETURN 
	    CASE 
	        WHEN p.idade < 18 THEN '0-17'
            WHEN p.idade < 30 THEN '18-29'
	        WHEN p.idade < 50 THEN '30-49'
	        ELSE '50+'
	    END AS faixa_etaria,
	    count(*) AS total_usuarios
	ORDER BY total_usuarios DESC;


///**Resultado esperado**: Permite identificar o público-alvo predominante na plataforma.

//### 2. Node Degree Distribution

//Objetivo: Analisar a distribuição de conexões para identificar usuários influentes.

// Distribuição de seguidores (in-degree)

MATCH (p:Pessoa)
WITH p, count{ (p)<-[:SEGUE]-() } AS seguidores
RETURN 
    CASE 
        WHEN seguidores = 0 THEN '0'
        WHEN seguidores <= 10 THEN '1-10'
        WHEN seguidores <= 100 THEN '11-100'
        WHEN seguidores <= 1000 THEN '101-1000'
        ELSE '1000+'
    END AS faixa_seguidores,
    count(*) AS total_pessoas
ORDER BY faixa_seguidores;

// Estatísticas da distribuição usando APOC

MATCH (p:Pessoa)
WITH count{ (p)<-[:SEGUE]-() } AS seguidores
RETURN apoc.agg.statistics(seguidores) AS estatisticas;

// **Insight: Identifica a concentração de seguidores - normalmente uma distribuição power-law (poucos influenciadores, muitos com poucos seguidores).**

//### 3. Weakly Connected Components (WCC)

//Objetivo: Identificar componentes isolados na rede social.


//**3.1. Projetar o grafo para o GDS**

CALL gds.graph.project(
    'fala-ai-graph',
    'Pessoa',
    {
        SEGUE: { type: 'SEGUE', orientation: 'UNDIRECTED' },
        AMIGO_DE: { type: 'AMIGO_DE', orientation: 'UNDIRECTED' }
    }
);


//**3.2. Executar WCC e analisar componentes**

CALL gds.wcc.stats('fala-ai-graph')
YIELD componentCount, componentDistribution
RETURN componentCount AS total_componentes,
       componentDistribution.p99 AS percentil_99_tamanho;
 

//**3.3. Encontrar os maiores componentes**

CALL gds.wcc.stream('fala-ai-graph')
YIELD nodeId, componentId
WITH componentId, collect(gds.util.asNode(nodeId).nome) AS membros
RETURN componentId, size(membros) AS tamanho, membros[0..3] AS exemplos
ORDER BY tamanho DESC LIMIT 10;


//### 4. PageRank (Influência)

//Objetivo: Calcular a importância/influência de cada usuário na rede.

//- **Executar PageRank na rede de seguidores**

CALL gds.pageRank.stream('fala-ai-graph')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS pessoa, score
RETURN pessoa.nome AS usuario,
       score AS influencia,
       pessoa.profissao AS profissao,
       pessoa.idade AS idade
ORDER BY score DESC LIMIT 10;

//Interpretação: Usuários com maior PageRank são aqueles que recebem muitos seguidores e também são seguidos por outros influenciadores.


//### 5. Community Detection (Louvain)**

//Objetivo: Descobrir comunidades naturais baseadas em interações.

//**Executar Louvain na rede de interações**

CALL gds.louvain.stream('fala-ai-graph', {
    relationshipTypes: ['SEGUE', 'AMIGO_DE']
})
YIELD nodeId, communityId
WITH communityId, collect(gds.util.asNode(nodeId).nome) AS membros
RETURN communityId, size(membros) AS tamanho, membros[0..5] AS exemplos
ORDER BY tamanho DESC LIMIT 5;


//### 6. Shared Audience Analysis

//Objetivo: Encontrar comunidades baseadas em audiência compartilhada (usuários que interagem com os mesmos posts).

//**6.1. Projetar grafo de audiência compartilhada**

CALL gds.graph.project(
    'shared-audience',
    { Pessoa: { properties: 'idade', label: 'Pessoa' }, Post: {} },
    { CURTIU: { type: 'CURTIU', orientation: 'REVERSE' } }
);

//**6.2. Calcular similaridade entre usuários baseada em posts curtidos**

CALL gds.nodeSimilarity.stream('shared-audience', {
    nodeLabels: ['Pessoa'],
    similarityCutoff: 0.3,
    topK: 5
})
YIELD node1, node2, similarity
WHERE gds.util.asNode(node1).nome <> gds.util.asNode(node2).nome
RETURN gds.util.asNode(node1).nome AS usuario1,
       gds.util.asNode(node2).nome AS usuario2,
       similarity
ORDER BY similarity DESC LIMIT 20;
 
// 6.2 Alternativa Cypher puro.
// Análise de similaridade com Cypher puro
MATCH (p1:Pessoa)-[:CURTIU]->(post:Post)<-[:CURTIU]-(p2:Pessoa)
WHERE p1 <> p2
WITH p1, p2, COUNT(DISTINCT post) AS posts_comuns
WHERE posts_comuns > 0
WITH p1, p2, posts_comuns,
     COUNT{ (p1)-[:CURTIU]->() } AS total_curtidas_p1,
     COUNT{ (p2)-[:CURTIU]->() } AS total_curtidas_p2
RETURN p1.nome AS usuario1,
       p2.nome AS usuario2,
       posts_comuns AS posts_em_comum,
       total_curtidas_p1 AS curtidas_p1,
       total_curtidas_p2 AS curtidas_p2,
       toFloat(posts_comuns) / (total_curtidas_p1 + total_curtidas_p2 - posts_comuns) AS jaccard_similaridade
ORDER BY jaccard_similaridade DESC
LIMIT 20;

//### 7. Análises de Caminho e Proximidade

//Objetivo: Encontrar o menor caminho entre usuários.

//**Caminho mais curto entre dois usuários específicos**


MATCH path = shortestPath(
    (a:Pessoa {nome: 'Felipe Araújo'})-[*]-(b:Pessoa {nome: 'Fernanda Lima'})
)
RETURN length(path) AS distancia,
       [node IN nodes(path) | node.nome] AS caminho;
 

//**Caminho mais curto baseado em tipo de relacionamento específico**

MATCH path = shortestPath(
    (a:Pessoa {nome: 'Felipe Araújo'})-[:AMIGO_DE*]-(b:Pessoa {nome: 'Fernanda Lima'})
)
RETURN length(path) AS distancia_amizade,
       [node IN nodes(path) | node.nome] AS caminho_amigos;
 

//### 8. Algoritmo Node Similarity para Recomendações

//Objetivo: Recomendar novos usuários para seguir baseado em similaridade.

//**8.1. Projetar grafo para similaridade**

CALL gds.graph.project(
    'user-similarity',
    'Pessoa',
    {
        CURTIU: { type: 'CURTIU', orientation: 'UNDIRECTED' },
        SEGUE: { type: 'SEGUE', orientation: 'UNDIRECTED' }
    }
);


//**8.2. Calcular similaridade entre usuários**

CALL gds.nodeSimilarity.stream('user-similarity', {
    topK: 10,
    similarityCutoff: 0.4
})
YIELD node1, node2, similarity
WHERE gds.util.asNode(node1).nome = 'Fernanda Lima'
RETURN gds.util.asNode(node2).nome AS recomendado,
       similarity AS pontuacao_similaridade
ORDER BY similarity DESC LIMIT 5;

//### 9. Critérios para Recomendação de Seguidores

//Objetivo: Recomendar usuários com base em critérios demográficos e de interesse.

//**Critério 9.1: Interesses similares (posts curtidos em comum)**

MATCH (p:Pessoa {nome: 'Fernanda Lima'})-[:CURTIU]->(post:Post)<-[:CURTIU]-(candidato:Pessoa)
WHERE NOT EXISTS( (p)-[:SEGUE]->(candidato) )
  AND p <> candidato
WITH candidato, COUNT(DISTINCT post) AS posts_comuns
RETURN candidato.nome AS recomendado,
       candidato.profissao AS profissao,
       posts_comuns
ORDER BY posts_comuns DESC LIMIT 5;

//**Critério 9.2: Mesma faixa etária e sexo**

MATCH (p:Pessoa {nome: 'Fernanda Lima'})
MATCH (c:Pessoa)
WHERE p <> c
  AND NOT EXISTS((p)-[:SEGUE]->(c))
  AND c.idade >= p.idade - 5
  AND c.idade <= p.idade + 5
  AND c.sexo = p.sexo
  AND c.cidade = p.cidade
RETURN c.nome AS recomendado,
       c.idade AS idade,
       c.profissao AS profissao
LIMIT 5;
 

//**Critério 9.3: Amigos em comum (amizade indireta)**

MATCH (p:Pessoa {nome: 'João Pereira'})-[:AMIGO_DE*2]-(c:Pessoa)
WHERE NOT EXISTS( (p)-[:AMIGO_DE]-(c) )
  AND p <> c
WITH c, COUNT(*) AS amigos_em_comum
RETURN c.nome AS recomendado,
       amigos_em_comum
ORDER BY amigos_em_comum DESC LIMIT 5;

//### 10. Análise de Público-Alvo por Grupo/Comunidade

//Objetivo: Caracterizar demograficamente os membros de grupos e comunidades.

//**Análise do público de um grupo específico**

MATCH (g:Grupo {nome: 'Tecnologia'})<-[:PERTENCE]-(p:Pessoa)
RETURN 
    AVG(p.idade) AS idade_media,
    COUNT(CASE WHEN p.sexo = 'M' THEN 1 END) AS homens,
    COUNT(CASE WHEN p.sexo = 'F' THEN 1 END) AS mulheres,
    COLLECT(DISTINCT p.profissao)[0..5] AS profissoes_comuns,
    p.cidade AS cidade_mais_comum
ORDER BY p.cidade DESC;
