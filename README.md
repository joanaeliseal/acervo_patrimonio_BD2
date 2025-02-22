# Banco de Dados para um Acervo de Patrimônio Cultural

## 1. Descrição do Negócio e da Necessidade

A Secretaria de Cultura do Estado da Paraíba precisa de um sistema informatizado para catalogar e gerenciar os bens culturais do estado. Atualmente, as informações estão dispersas em documentos físicos, planilhas e registros não padronizados, o que dificulta a consulta, atualização e preservação do patrimônio cultural. O sistema proposto tem como finalidade centralizar esses dados, facilitando o acesso e a análise por gestores, pesquisadores, turistas e pela comunidade, promovendo a valorização da cultura paraibana.

## 2. Escopo do Projeto

### 2.1. Objetivo
Desenvolver uma plataforma para cadastrar, gerenciar e disponibilizar informações sobre bens culturais, tanto materiais quanto imateriais, permitindo:
- A preservação e valorização do patrimônio cultural.
- Apoio à tomada de decisões e planejamento de ações de conservação.
- Facilitação do acesso ao acervo por diferentes públicos (gestores, pesquisadores, turistas e comunidade).

### 2.2. Usuários do Sistema
- **Gestores da Secretaria de Cultura:** Responsáveis pelo cadastro, atualização e validação dos registros.
- **Pesquisadores e Historiadores:** Utilizarão o acervo para estudos e publicações.
- **Turistas e Comunidade:** Acesso ao catálogo online para conhecer o patrimônio cultural.

### 2.3. Funcionalidades Principais
1. **Cadastro e Gerenciamento de Bens Culturais:**
   - **Materiais:** Registro detalhado de bens como igrejas, monumentos e sítios arqueológicos.
   - **Imateriais:** Registro de manifestações culturais, como festas populares, culinária e lendas.
   - Associação de informações como localização, data de origem, categoria, estado de conservação e proteção legal.
2. **Registro de Eventos Históricos:**
   - Documentação de eventos históricos relevantes, com associação aos bens culturais.
   - Registro de datas e períodos que contextualizam o patrimônio.
3. **Gestão de Categorias:**
   - Organização dos bens culturais por categorias específicas para facilitar a consulta.
4. **Cadastro de Responsáveis:**
   - Registro de pessoas físicas e jurídicas envolvidas na preservação e promoção dos bens culturais.
5. **Consultas e Relatórios:**
   - Ferramentas de busca avançada por tipo de bem, localização, período histórico, estado de conservação e responsáveis.
   - Geração de relatórios sobre bens cadastrados, bens em risco e eventos relacionados.

## 3. Requisitos Funcionais

- **Cadastro de Bens Culturais:**
  - **Materiais:** Nome, descrição, localização (endereço e coordenadas), data de origem, categoria, estado de conservação e proteção legal.
  - **Imateriais:** Nome, descrição, comunidade associada, localização geográfica, periodicidade, data de origem e estado atual (ativa, em risco, extinta).
  
- **Gestão de Categorias:**
  - Cadastro, edição e exclusão de categorias para organizar os bens culturais.

- **Cadastro de Eventos Históricos:**
  - Registro de eventos com nome, descrição, data ou período e associação com bens culturais.

- **Cadastro de Responsáveis:**
  - Registro de informações de indivíduos ou instituições, incluindo nome, tipo (pessoa física ou jurídica), contato e bens culturais sob sua responsabilidade.

- **Consultas e Relatórios:**
  - Busca e filtragem por tipo de bem, localização, período histórico, estado de conservação e responsável.
  - Geração de relatórios para monitoramento e análise do acervo.

## 4. Requisitos de Dados

- **Bens Culturais:**
  - ID, nome, descrição, localização, data de origem, categoria, estado de conservação, proteção legal e responsável.
  
- **Categorias:**
  - ID, nome e descrição.

- **Eventos Históricos:**
  - ID, nome, descrição, data ou período e bens culturais associados.

- **Responsáveis:**
  - ID, nome, tipo (pessoa física ou jurídica), contato e bens culturais sob sua responsabilidade.

## 5. Requisitos Não Funcionais

- **Segurança:** Controle de acesso com níveis de permissão para edição e visualização.
- **Performance:** Capacidade de processar consultas e gerar relatórios de forma eficiente.
- **Escalabilidade:** Possibilidade de expansão para incluir novos tipos de bens culturais e funcionalidades futuras.

## 6. Benefícios Esperados

- **Centralização e Padronização:** Organização unificada dos registros, eliminando a dispersão de informações.
- **Facilidade de Consulta e Análise:** Interface intuitiva para acesso e pesquisa dos dados.
- **Apoio à Preservação:** Identificação de bens em risco e suporte ao planejamento de ações de conservação.
- **Promoção do Turismo Cultural:** Disponibilização de informações detalhadas para atrair e informar turistas, valorizando a cultura paraibana.
