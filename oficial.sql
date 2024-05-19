-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 22/04/2024 às 23:25
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `teste`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `administrador`
--

CREATE TABLE `administrador` (
  `utilizador_ptr_id` int(11) NOT NULL,
  `gabinete` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `administrador`
--

INSERT INTO `administrador` (`utilizador_ptr_id`, `gabinete`) VALUES
(23, 'Edifício 2, Gabinete 1.5.2'),
(41, 'fct'),
(44, '10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `anfiteatro`
--

CREATE TABLE `anfiteatro` (
  `EspacoID` int(11) NOT NULL,
  `EspacoEdificio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `arlivre`
--

CREATE TABLE `arlivre` (
  `EspacoID` int(11) NOT NULL,
  `EspacoEdificio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atividade`
--

CREATE TABLE `atividade` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Descricao` longtext NOT NULL,
  `Publicoalvo` varchar(255) NOT NULL,
  `nrColaboradoresNecessario` int(11) NOT NULL,
  `Tipo` varchar(64) NOT NULL,
  `Estado` varchar(64) NOT NULL,
  `dataSubmissao` datetime(6) NOT NULL,
  `dataAlteracao` datetime(6) NOT NULL,
  `duracaoEsperada` int(11) NOT NULL,
  `participantesMaximo` int(11) NOT NULL,
  `diaAbertoID` int(11) NOT NULL,
  `EspacoID` int(11) NOT NULL,
  `ProfessorUniversitarioUtilizadorID` int(11) NOT NULL,
  `Tema` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `atividade`
--

INSERT INTO `atividade` (`ID`, `Nome`, `Descricao`, `Publicoalvo`, `nrColaboradoresNecessario`, `Tipo`, `Estado`, `dataSubmissao`, `dataAlteracao`, `duracaoEsperada`, `participantesMaximo`, `diaAbertoID`, `EspacoID`, `ProfessorUniversitarioUtilizadorID`, `Tema`) VALUES
(7, 'Recursos Naturais e Biotecnologia', 'A atividade geral RECURSOS NATURAIS E BIOTECNOLOGIA inclui três atividades específicas integradas na área da biotecnologia: (a) As plantas, a luz e a fotossíntese; (b) Como cultivar plantas em tubos de ensaio; e (c) A bioengenharia na produção de biocombustíveis. Estas três atividades apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes. \r\n\r\nPúblico-alvo: 9º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: laboratorial.\r\n\r\n(a) As plantas, a luz e a fotossíntese\r\nEsta atividade inclui a observação da fotossíntese em ervas marinhas e a extração, separação, observação e identificação de pigmentos fotossintéticos de vários tipos de folhas.\r\nResponsável: Isabel Barrote.\r\nLocal: Edifício 8, laboratório 2.30.\r\n\r\n(b) Como cultivar plantas em tubos de ensaio\r\nNesta atividade os alunos terão oportunidade de contatar com a técnica de cultura in vitro de tecidos vegetais que permite a produção de plantas em ambiente laboratorial controlado.\r\nResponsáveis: Anabela Romano e Sandra Gonçalves.\r\nLocal: Edifício 8, laboratório 3.43.\r\n\r\n(c) A bioengenharia na produção de biocombustíveis\r\nEsta atividade inclui a visita ao Laboratório de Engenharia e Biotecnologia Ambiental, onde os alunos poderão conhecer os trabalhos em curso que utilizam diferentes tipos de microrganismos para produzir biocombustíveis alternativos, amigos do ambiente. Os alunos terão oportunidade de acompanhar e desenvolver uma atividade com um sistema biológico para a produção de bioetanol. Terão ainda contato com sistemas de microalgas, utilizados para a produção de diferentes produtos de interesse comercial. \r\nResponsável: Sara Raposo.\r\nLocal: Edifício 8, laboratório 2.43.', 'Ciencias e Tecnologia', 5, 'Atividade Laboratorial', 'Aceite', '2022-02-23 16:11:25.699722', '2022-03-03 12:19:50.159759', 180, 45, 3, 29, 25, 4),
(8, 'Desafios nos Laboratórios de Química e Ciências Farmacêuticas', 'As atividades especifícas a que terás oportunidade de assistir vão desde:\r\n- A extração de compostos naturais com atividade biológica, à sua formulação, (Vamos fazer pomadas, comprimidos, etc), e saber um pouco sobre a atuação do medicamento no corpo humano, Vamos perceber a relação fármaco-recetor. \r\nJá no controlo de qualidade dos medicamentos, Vamos identificar fármacos presentes num comprimido.  \r\n- E quando há um problema de saúde a Farmácia Comunitária e o Farmacêutico surgem de imediato na nossa mente - PharmaHelp – Do problema à solução!\r\n- Quando é que acaba a pandemia? Uma experiência de cinética é uma das atividades propostas, em que a reação química serve como pano de fundo, que liga com a disciplina da cinética química, contudo a interatividade será com o modelo SIR em Matlab, propondo diferentes parâmetros de doenças, populações, R0, taxas de vacinação, etc.\r\nPodemos ainda observar o fenómeno de oscilação numa reação química -  Semáforo Químico - A Reação de Belousov-Zhabotinskii, através da realização por alunos desta experiência química simples, integrada na área de estudo de Química-Física / Cinética Química. \r\n\r\nIdentificação do público alvo: 10º, 11º, 12º Ano\r\n\r\nLocal onde decorrem as atividades: Departamento de Química e Farmácia da Faculdade de Ciências e Tecnologia, Campus de Gambelas; Edificio 2: Lab de simulação farmacêutica; Lab 1.19; Lab 2.23\r\n\r\nResponsável: Ana Grenha; Ana Serralheiro; Carolina Rio; Custódia Fonseca; Graça Miguel; Isabel Ramalhinho; Jaime Conceição; Mónica Condinho; Wenli Wang e Rui Borges e alunos do NeciFarm.', 'Ciencias e Tecnologia', 3, 'Atividade Laboratorial', 'Aceite', '2022-02-23 19:10:09.309075', '2022-03-03 12:02:27.096099', 180, 45, 3, 30, 26, 4),
(10, 'Tecnologia na nossa vida', 'A atividade geral TECNOLOGIA NA NOSSA VIDA inclui três atividades específicas integradas na área da informática: (a) O jogo LINA; (b) Centro de dados e Rede Informática; (c) Projetos durante e pós curso, apresentação do NEEI. Estas três atividades específicas apresentam uma duração de 50 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes. \r\n\r\nPúblico-alvo: 9º e 10º - 12º ano\r\n\r\n(a)	O jogo LINA \r\nLINA é um jogo sério para telemóvel que utiliza realidade aumentada, teatro interactivo, narrativa, e colaboração entre jogadores para promover o sentimento de pertença e coesão social numa turma, para além de alertar para os problemas de saúde mental.  Foi desenvolvido no contexto de um projeto de investigação internacional e multidisciplinar (https://dot.lbg.ac.at/), e demonstra o que se consegue fazer quando se juntam colaboradores de engenharia informática, psicologia, artes, e teatro. \r\n\"Num dia normal de escola, o professor faz a chamada ... mas há um nome em falta. Onde está a Lina? E o que está no caderno misterioso que ela deixou debaixo da minha mesa?\"\r\nUsando uma história de mistério, e narrativa interactiva, os jogadores utilizam realidade aumentada no telemóvel para procurar e descobrir artefactos deixados na sala de aula por uma colega ficcional. O jogo conduz os jogadores para uma interação cara-a-cara, em que devem colaborar para resolver os puzzles e desbloquear a história sobre o que aconteceu à Lina.\r\n\r\nResponsável: João Dias\r\nLocal: Edifício 1-Sala 1.53\r\n\r\n(b) Centro de dados e Rede Informática \r\n•	Centro de Dados da Universidade do Algarve – apresentação das tecnologias, infraestrutura e conetividade do Centro de Dados da UAlg \r\n•	A minha primeira rede informática – Criação da uma rede informática em Laboratório de Redes para, através de simulador, criar a primeira rede informática utilizando configuração de Vlans e roteamento externo entre dois locais remotos\r\nResponsáveis: Joel Guerreiro e Luís Pisco.\r\nLocal: Edifício 1-Salas 1.41 (centro de dados) e 0.17 (rede informática)\r\n\r\n\r\n\r\n(c)	Projetos durante e pós curso. Apresentação do NEEI\r\n•	Demonstração de diversos projetos desenvolvidos ao longo do curso, visando abranger\r\no maior número de unidades curriculares. O propósito desta atividade específica é mostrar aos alunos os projetos que eles mesmos poderão desenvolver caso ingressem na\r\nUniversidade do Algarve. Para além disso, serão ainda apresentados projetos\r\ndesenvolvidos pelos alunos fora das unidades curriculares, nos quais o conhecimento adquirido no curso, foi imprescindível para a sua elaboração.\r\n•	Conversa com os alunos visitantes com o intuito de mostrar em que consiste o núcleo de\r\nestudantes, apresentar a sua missão e quais os seus objetivos.\r\n\r\nResponsável: Núcleo de estudantes de Engenharia informática\r\nLocal: Edifício 1-Sala 1.63', 'Ciencias e Tecnologia', 3, 'Misto', 'Aceite', '2022-03-01 22:59:47.182199', '2023-04-19 09:34:31.772402', 150, 45, 3, 33, 26, 4),
(11, 'Matemática para sempre', 'A atividade geral MATEMÁTICA NA VIDA inclui três atividades específicas integradas na área da matemática: (a) A navegação e o desenvolvimento tecnológico; (b) Será que tens o que é preciso para ser o próximo milionário?; (c) Algarismos de controlo. Estas três atividades específicas apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes.\r\n\r\nPúblico-alvo: 10º - 12º ano\r\n\r\n(a) A navegação e o desenvolvimento tecnológico \r\nDesde os primórdios da Humanidade os homens precisaram de descobrir a forma de se orientarem na deslocação entre dois pontos da esfera terrestre. As respostas às perguntas “Onde estamos?” e “Qual é a direção correta?” foram dadas por alguns dos mais brilhantes cientistas da história e estiveram na base de importantes avanços tecnológicos. \r\nNo contexto atual, voltamos a levantar as mesmas questões e a nossa história conjunta mostra que as respostas passam pelo desenvolvimento tecnológico, a ciência e o ensino de qualidade.\r\n\r\nResponsável: Juan Rodríguez\r\nLocal: Edifício 2-Sala de seminários\r\n\r\n(b) Será que tens o que é preciso para ser o próximo milionário?\r\nVem descobrir o curso de Matemática Aplicada à Economia e à Gestão e como estes 3 mundos podem mudar a tua vida. Vamos fazer um pequeno jogo, mostrar o que difere este curso dos restantes e responder às tuas questões. Será que tens o que é preciso para ser o próximo Ellon Musk?\r\n\r\nResponsável: NEMAEG-Núcleo de Estudantes de Matemática Aplicada à Economia e à Gestão\r\nLocal: Edifício 2-Sala 3.????\r\n\r\n(c) Algarismos de controlo\r\nOs algarismos de controlo servem para detetar se há erros nas sequências de números que compõem os vários sistemas de identificação que utilizamos no dia-a-dia: bilhete de identidade, número de contribuinte, número do passaporte, códigos de barras, NIB, notas de euro, códigos ISBN para livros, etc. Os erros mais frequentes quando lidamos com sequências grandes de algarismos é a troca de algarismos consecutivos (ex: 49 em vez de 94) ou o erro num dos algarismos (ex: 3 em vez de 8). Vamos aprender a calcular o algarismo de controlo nos códigos de barras e analisar as (des)vantagens deste método. Tragam objetos com código de barras para a atividade para confirmarmos que estes estão corretos.\r\n\r\nSe possível, os alunos devem trazer material de escrita, calculadora e um objeto com código de barras.\r\n\r\nResponsável: Diana Rodelo\r\nLocal: Edifício 2-Sala 3.????', 'Ciencias e Tecnologia', 3, 'Misto', 'Aceite', '2022-03-01 23:08:32.088596', '2022-03-10 18:56:02.216542', 180, 45, 3, 30, 26, 4),
(12, 'Física e Matemática, ontem e hoje', 'A atividade geral FÍSICA E MATEMÁTICA, ONTEM E HOJE inclui três atividades específicas integradas na área da física e matemática: (a) Carga Específica do Eletrão (Experiência de Thomson); (b) A navegação e o desenvolvimento tecnológico; (c) Algarismos de controlo. Estas três atividades específicas apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes. \r\n\r\nPúblico-alvo: 10º - 12º ano\r\n\r\n(a)	Carga Específica do Eletrão (Experiência de Thomson)\r\nAtravés de um feixe de eletrões, obtido com um tubo de raios catódicos, Thomson determinou a carga do eletrão dividida pela sua massa.\r\n\r\nResponsável: José Luís Argain\r\nLocal: Edifício 2-Lab 3.28\r\n\r\n(b)	A navegação e o desenvolvimento tecnológico \r\nDesde os primórdios da Humanidade os homens precisaram de descobrir a forma de se orientarem na deslocação entre dois pontos da esfera terrestre. As respostas às perguntas “Onde estamos?” e “Qual é a direção correta?” foram dadas por alguns dos mais brilhantes cientistas da história e estiveram na base de importantes avanços tecnológicos. \r\nNo contexto atual, voltamos a levantar as mesmas questões e a nossa história conjunta mostra que as respostas passam pelo desenvolvimento tecnológico, a ciência e o ensino de qualidade.\r\n\r\nResponsável: Juan Rodríguez\r\nLocal: Edifício 2-Sala de seminários\r\n\r\n(c) Algarismos de controlo\r\nOs algarismos de controlo servem para detetar se há erros nas sequências de números que compõem os vários sistemas de identificação que utilizamos no dia-a-dia: bilhete de identidade, número de contribuinte, número do passaporte, códigos de barras, NIB, notas de euro, códigos ISBN para livros, etc. Os erros mais frequentes quando lidamos com sequências grandes de algarismos é a troca de algarismos consecutivos (ex: 49 em vez de 94) ou o erro num dos algarismos (ex: 3 em vez de 8). Vamos aprender a calcular o algarismo de controlo nos códigos de barras e analisar as (des)vantagens deste método. Tragam objetos com código de barras para a atividade para confirmarmos que estes estão corretos.\r\n\r\nSe possível, os alunos devem trazer material de escrita, calculadora e um objeto com código de barras.\r\n\r\nResponsável: Diana Rodelo\r\nLocal: Edifício 2-Sala 3.????', 'Ciencias e Tecnologia', 1, 'Misto', 'Aceite', '2022-03-01 23:11:52.860442', '2023-04-19 09:21:19.078054', 60, 45, 3, 30, 26, 4),
(13, 'SOS URBAN: espaços verdes sustentáveis', 'A atividade geral SOS URBAN: ESPAÇOS VERDES SUSTENTÁVEIS inclui duas atividades específicas integradas na área da arquitetura paisagista: (a) SOS URBAN: arquitetura paisagista e alterações climáticas; e (b) Do projeto ao jardim. Estas duas atividades apresentam uma duração de 60 minutos cada e serão frequentadas, sequencialmente, por dois grupos de alunos visitantes. \r\n\r\nPúblico-alvo: 9º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: mista.\r\n\r\n(a) SOS URBAN: Arquitetura Paisagista e Alterações Climáticas\r\nA arquitetura paisagista é uma profissão especialmente preparada para enfrentar os grandes desafios das alterações climáticas, quer no âmbito do ordenamento do território e da conservação da natureza, quer à escala das cidades, onde se impõem mudanças para uma maior sustentabilidade urbana. Nesta atividade revelamos a profissão e mostramos exemplos de projetos que lidam diretamente com estes desafios. Depois de uma breve apresentação do tema da sustentabilidade urbana, segue-se uma atividade prática onde os alunos, trabalhando em equipas, assumem o papel de decisores na adoção de práticas de sustentabilidade, para a melhoria de uma zona urbana. No final cada equipa disporá de seis minutos para apresentar as suas soluções e propostas. Os alunos poderão também descobrir qual o percurso de um estudante universitário de arquitetura paisagista na Universidade do Algarve, o seu dia-a-dia, a diversidade das matérias aprendidas e o seu trabalho prático. \r\nResponsáveis: Paula Gomes da Silva e Desidério Baptista.\r\nLocal: Edifício 8, sala 3.44.\r\n\r\n(b) Do projeto ao jardim\r\nEsta atividade prática pretende motivar os alunos para a conceção e execução de projetos de jardins e de espaços exteriores e inclui a montagem de um projeto de rega e a execução de um plano de plantação. Os alunos recebem um miniprojecto de um jardim (rega e plano de plantação) para o local e sua interpretação. Com este projeto irão piquetar os principais elementos do jardim, montar o sistema de rega à superfície e colocar as plantas envasadas no seu local de plantação.\r\nResponsável: José António Monteiro.\r\nLocal: espaço exterior, Campus de Gambelas.', 'Ciencias e Tecnologia', 2, 'Misto', 'Aceite', '2022-03-03 11:15:04.894347', '2022-03-03 12:18:57.127518', 150, 30, 3, 29, 25, 4),
(14, 'O cultivo das plantas: the sky is the limit!', 'A atividade  geral CULTIVO DE PLANTAS: THE SKY IS THE LIMIT! inclui três atividades específicas integradas na área das ciências agrárias: (a) Avaliar e preservar a qualidade de frutos e legumes; (b) Voa na boa … sobre as plantas!; e (c) Operação de sistemas de cultivo sem solo de plantas hortícolas. Estas três atividades apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes. \r\n\r\nPúblico-alvo: 10º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: mista.\r\n\r\n(a) Avaliar e preservar a qualidade de frutos e legumes\r\nEsta atividade pretende sensibilizar os alunos para a importância qualitativa e nutricional dos frutos e legumes frescos e a melhor forma de os conservar. Os produtos hortofrutícolas continuam os seus processos metabólicos a um ritmo elevado após a sua colheita, o que os torna altamente perecíveis. É também cada vez maior a exigência do consumidor em relação à qualidade dos produtos. É deste modo imprescindível que existam técnicos especializados na área da pós-colheita de produtos hortofrutícolas. Estes técnicos devem conhecer e implementar técnicas que abrandem os processos de deterioração pós-colheita e que permitem manter o valor de mercado e a segurança alimentar dos produtos hortofrutícolas. A atividade prática inclui \r\numa visita à estação e ao laboratório da pós-colheita e sala de provas organoléticas e a determinação de parâmetros de avaliação de qualidade em frutos e legumes e provas organoléticas a realizar no laboratório.\r\nResponsáveis: Custódia Gago, Adriana Guerreiro e Maria Dulce Antunes.\r\nLocal: Edifício 8, laboratório 1.31 e sala de provas. \r\n\r\n(b) Voa na boa … sobre as plantas!\r\nEsta atividade prática inclui uma breve apresentação teórica dos conceitos de agricultura de precisão e como pode o Homem e a tecnologia monitorizar e decidir que práticas culturais deve adotar. Aborda, de forma específica, os sistemas de navegação por satélite, com referência à utilização de drones e câmaras multiespectrais para avaliar o estado das culturas. Inclui uma demonstração prática da utilização de drones com câmara multiespectral, tratamento da informação para avaliar o estado da vegetação e o cálculo de um mapa do índice de vegetação por diferença normalizada (NDVI). \r\nResponsáveis: Carlos Guerrero e Pedro Luiz.\r\nLocal: Horto (Campus de Gambelas) e espaço exterior.\r\n\r\n(c) Operação de sistemas de cultivo sem solo de plantas hortícolas\r\nOs sistemas de cultivo de plantas hortícolas sem recurso ao solo - em sistemas hidropónicos ou em substratos - conhecidos popularmente por “hidroponia”, requerem o controlo constante e rigoroso das condições de desenvolvimento das plantas, mas permitem aumentar a produção por unidade de área, bem como a eficiência de uso de factores de produção como a água ou os fertilizantes, de entre outras importantes vantagens. Nesta atividade, os alunos ficarão a conhecer quais os fatores ambientais cujo controlo é mais importante e de que forma se efectua o seu controlo e visitarão culturas em curso nestes sistemas de cultivo. \r\nResponsável: Mário Reis.\r\nLocal: Horto (Campus de Gambelas).', 'Ciencias e Tecnologia', 3, 'Misto', 'Aceite', '2022-03-03 11:21:15.784539', '2022-03-03 12:18:49.915707', 180, 45, 3, 32, 25, 4),
(15, 'As 20 000 léguas subterrâneas', 'A atividade geral AS 20 000 LÉGUAS SUBTERRÂNEAS inclui duas atividades específicas integradas na gestão de recursos hídricos, em particular os subterrâneos dada a sua importância, uma vez que constituem a principal, ou única, origem de água doce em muitas regiões do planeta. A atividade demonstra a componente subterrânea do ciclo da água e a sua relação com as águas superficiais: (a) Modelo físico e funcionamento de um aquífero; e (b) Monitorização de águas subterrâneas e intrusão salina. Estas duas atividades apresentam uma duração de 60 minutos cada e serão frequentadas, sequencialmente, por dois grupos de alunos visitantes.  Entre as duas atividades, os alunos percorrem o eco-circuito do Campus de Gambelas, onde se apresentam placas botânicas contendo um índice de vulnerabilidade às alterações climáticas. Este percurso serve de ligação entre as componentes superficial e a subterrânea do ciclo da água. \r\n\r\nPúblico-alvo: 9º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: mista.\r\n\r\n(a) Modelo físico e funcionamento de um aquífero\r\nEsta atividade inclui a demonstração do ciclo hidrológico e do escoamento da água no subsolo, evidenciando as particularidades da bacia hidrográfica onde nos encontramos (bacia hidrográfica das Ribeiras do Algarve) utilizando um modelo físico em corte vertical. Adicionalmente, é desenvolvida uma experiência para observação de fenómenos de infiltração e retenção de água no solo. Os alunos adicionam água a recipientes contendo diferentes tipos de solo e de cobertura. Devendo registar o tempo necessário para drenar a água até à capacidade de campo, relacionando com o tipo de solo e particularidades que alteram a sua permeabilidade e porosidade.\r\nResponsáveis: Luís Nunes e Vânia Sousa\r\nLocal: Campus de Gambelas, zonas exteriores (campo de jogos, horto e eco-circuito).\r\n\r\n(b) Monitorização de águas subterrâneas e intrusão salina\r\nEsta atividade inclui a monitorização de águas subterrâneas e a análise da intrusão salina. Utilizando o furo da Universidade do Algarve, pretende-se monitorizar a profundidade da água no furo e a qualidade da mesma através da análise de parâmetros químicos, nomeadamente pH, condutividade e nitratos, utilizando sondas de campo e tiras indicadoras. Posteriormente, diferentes percentagens de água do mar são misturadas com a água subterrânea e através da medição da condutividade elétrica é feita a relação entre os valores registados e as diferentes percentagens de mistura de água do mar Intrusão salina). \r\nResponsáveis: Luís Nunes e Vânia Sousa.\r\nLocal: Campus de Gambelas, zonas exteriores (campo de jogos, horto e eco-circuito).', 'Ciencias e Tecnologia', 7, 'Misto', 'Aceite', '2022-03-03 11:25:59.255578', '2022-03-03 12:18:40.041332', 150, 30, 3, 31, 25, 4),
(16, 'Métodos em Ciências do Mar', 'A atividade geral MÉTODOS EM CIÊNCIAS DO MAR inclui três atividades específicas integradas na área das ciências do mar: (a) Como investigamos a dinâmica litoral?; (b) Mergulho científico: ferramenta para o estudo do ambiente marinho; e (c) O mundo numa gota de água do mar: do microscópio ao satélite. Estas três atividades apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes.  \r\n\r\nPúblico-alvo: 9º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: mista.\r\n\r\n(a) Como investigamos a dinâmica litoral?\r\nNesta atividade, os investigadores do Centro de Ciências do Mar e do Ambiente da Universidade do Algarve (CIMA-UAlg) discutirão com os alunos a importância das zonas costeiras, as metodologias e ferramentas utilizadas nos estudos da dinâmica do litoral e o tipo de resultados obtidos, da composição e tamanho dos sedimentos à evolução de troços costeiros baseada em imagens de satélite. Serão igualmente discutidas a utilidade e as implicações destes resultados.\r\nResponsáveis: Susana Costas, Juan Garzón e Katerina Kompiadou.\r\nLocal: Edifício 7, sala 2.57.\r\n\r\n(b) Mergulho científico: ferramenta para o estudo do ambiente marinho\r\nEsta atividade engloba vários temas e materiais pedagógicos, nomeadamente uma apresentação geral sobre o mergulho científico, vídeos curtos exemplificativos de atividades/técnicas/métodos utilizados em mergulho científico e a observação e manuseamento de equipamento de mergulho. No final, serão  apresentados cenários subaquáticos, com recurso a materiais didáticos diversos, que têm por objetivo realçar as competências requeridas para desempenhar a atividade de mergulhador científico. Destacar-se-á ainda a importância da formação técnico-científica requerida para esta atividade de mergulho, que pode ser obtida na Universidade do Algarve, e as suas saídas profissionais. \r\nResponsáveis: Duarte Duarte e Núcleo de Estudantes de Biologia e Biologia Marinha da Associação Académica da Universidade do Algarve (NEBUA).\r\nLocal: Edifício 7, sala 1.28.\r\n\r\n(c) O mundo numa gota de água do mar: do microscópio ao satélite\r\nA vida nos oceanos é riquíssima e fascinante e todos conhecemos espécies de peixes, mamíferos marinhos, e até algas e plantas marinhas, que habitam os ecossistemas marinhos. Esta atividade aborda os outros organismos marinhos, pequenos mas extremamente importantes, que não conseguimos visualizar a olho nú. A atividade inicia com uma introdução teórica sobre os microrganismos marinhos que pululam numa gota de água de mar, incluindo o fitoplâncton (microalgas), bactérias e vírus, e a sua importância nos ecossistemas. Seguidamente, serão apresentados aos alunos os métodos (ex.: deteção remota por satélite), estratégias e equipamentos utilizados para a recolha de amostras de água e medição de variáveis ambientais relevantes. Por fim, os microrganismos marinhos serão visualizados usando diferentes tipos de microscópios: o microscópio de inversão para explorar fitoplâncton e protistas fagotróficos em amostras in vivo e o microscópio de epifluorescência para observar bactérias heterotróficas e vírus planctónicos.\r\nResponsáveis: Rita Domingues, Helena Galvão e Lilian Krug.\r\nLocal: Edifício 7, laboratório 2.8.', 'Ciencias e Tecnologia', 3, 'Misto', 'Aceite', '2022-03-03 11:31:24.856034', '2022-03-03 12:18:32.858560', 180, 45, 3, 31, 25, 4),
(17, 'Ciências do Mar: organismos, ambientes e investigadores', 'A atividade geral CIÊNCIAS DO MAR: ORGANISMOS, AMBIENTES E INVESTIGADORES inclui três atividades integradas na área das ciências do mar: (a) Fitoplâncton observado sob diferentes perspetivas; (b) À descoberta de organismos gelatinosos; e (c) Quem é quem nas ciências do mar.\r\nEstas três atividades apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes.  \r\n\r\nPúblico-alvo: 9º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: mista.\r\n\r\n(a) Fitoplâncton observado sob diferentes perspetivas \r\nO fitoplâncton, constituído por várias espécies de microalgas planctónicas, representa a base da rede alimentar no oceano e tem um papel fundamental na captação de dióxido de carbono da atmosfera. No entanto, algumas espécies de fitoplâncton produzem toxinas com efeitos nocivos para a saúde pública e ambiente marinho. Assim, conhecer a composição específica e distribuição do fitoplâncton nos ecossistemas marinhos é uma prioridade! Esta atividade aborda, inicialmente, o funcionamento e utilização da deteção remota por satélite para obter informação geral sobre o fitoplâncton. Contudo, para detetar a presença de espécies de fitoplâncton potencialmente nocivas, é necessário colher e analisar diretamente amostras de água. Assim, os alunos terão também oportunidade de assistir a breves demonstrações dos métodos de estudo mais convencionais, incluindo a extração de pigmentos para análise química e a utilização de microscopia para observação direta do fitoplâncton.\r\nResponsável: Sónia Cristina e Carla S. Freitas.\r\nLocal: Edifício 7, sala 1.74 e laboratórios 1.87 e 1.89.\r\n\r\n(b) À descoberta de organismos gelatinosos\r\nEsta atividade aborda a morfologia e ecologia de organismos gelatinosos integrados no Filo Cnidaria, que conhecemos no dia-a-dia por medusas. Os alunos terão oportunidade de realizar algumas atividades interativas e observar diversos organismos vivos.\r\nResponsáveis: Joana Cruz e Núcleo de Estudantes de Biologia e Biologia Marinha da Associação Académica da Universidade do Algarve (NEBUA).\r\nLocal: Edifício 7, laboratório 0.44.\r\n\r\n(c) Quem é quem nas ciências do mar\r\nNesta atividade, os alunos serão desafiados a identificar a área científica de vários investigadores com base num jogo de perguntas e respostas, com tempo limitado. Serão contempladas pelo menos quatro áreas de investigação, no âmbito das ciências do mar e do ambiente. Durante este ‘speed dating’, os investigadores apresentarão objetos representativos da sua área de investigação e estarão disponíveis para responder a perguntas chave por parte de grupos de alunos. A parte final da atividade inclui uma explanação acerca do papel do investigador na sociedade.\r\nResponsáveis: Rita Carrasco, Isabel Mendes, Lilian Krug, Rita Domingues e Margarida Vilas Boas.\r\nLocal: Edifício 7, sala 2.57.', 'Ciencias e Tecnologia', 4, 'Misto', 'Aceite', '2022-03-03 11:41:43.614545', '2022-03-03 12:18:26.976864', 180, 45, 3, 31, 25, 4),
(18, 'Fases do ciclo de vida de animais marinhos', 'A atividade geral FASES DO CICLO DE VIDA DE ANIMAIS MARINHOS inclui três atividades integradas na área da Biologia Marinha: (a) Vem explorar o interior de um peixe; (b) Como preservar espermatozoides de peixe a longo prazo?; e (c) Ciclo de vida do caranguejo: da larva ao adulto, do nativo ao invasor. Estas três atividades apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes.  \r\n\r\nPúblico-alvo: 9º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: laboratorial.\r\n\r\n\r\n(a) Vem explorar o interior de um peixe \r\nEsta atividade permite aos alunos conhecerem a morfologia externa e interna de um peixe ósseo (teleósteo). Os alunos farão a disseção de um indivíduo da espécie Scomber colias, (nome vugar:  cavala) e identificarão os principais órgãos internos e as suas funções fisiológicas.\r\nResponsáveis: Teresa Modesto e Núcleo de Estudantes de Biologia e Biologia Marinha da Associação Académica da Universidade do Algarve (NEBUA).\r\nLocal: Edifício 7, laboratório 0.44.\r\n\r\n(b) Como preservar espermatozóides de peixe a longo prazo?\r\nEsta atividade demonstra como o material biológico pode ser armazenado durante anos com recurso à criopreservação. A criopreservação consiste na congelação em azoto líquido a baixas temperaturas (-196ºC). Esta atividade transmite aos alunos noções básicas de procedimentos de criopreservação, dando a conhecer os materiais e equipamentos necessários. Os alunos terão oportunidade de descongelar espermatozóides de peixes criopreservados e analisar a sua sobrevivência. Será que os espermatozóides conseguem retomar a mobilidade? \r\nResponsáveis: Elsa Cabrita, Catarina Anjos e Francisca Félix.\r\nLocal: Edifício 7, laboratório 0.44.\r\n\r\n(c) Ciclo de vida do caranguejo: da larva ao adulto, do nativo ao invasor\r\nEsta atividade iniciará com uma breve introdução ao ciclo de vida do caranguejo, com referência a espécies nativas e espécies não-nativas invasoras. Os  alunos irão visualizar as fases iniciais (larvas microscópicas planctónicas) de vida de caranguejos, com o auxílio de uma lupa binocular, bem como adultos de espécies nativas e invasoras. No final da sessão, tentarão descobrir fases larvares no estádio zoea, entre muitos outros organismos zooplanctónicos, em amostras de zooplâncton in vivo.\r\nResponsáveis: Joana Cruz e Marta Albo Puigsever\r\nLocal: Edifício 7, laboratório 0.41.', 'Ciencias e Tecnologia', 3, 'Atividade Laboratorial', 'Aceite', '2022-03-03 11:43:58.184348', '2022-03-03 12:18:19.172414', 180, 45, 3, 31, 25, 4),
(19, 'Da célula aos implantes artificiais: ciências e tecnologias', 'A atividade geral DA CÉLULA AOS IMPLANTES ARTIFICIAIS: CIÊNCIAS E TECNOLOGIAS inclui três atividades específicas integradas nas áreas da Bioquímica, Bioengenharia e Ciências da Saúde: (a) Cultura celular: aventura no multiverso da ciência; (b) A imunologia na bioquímica; e (c) Bioengenharia: o que será, como será na UAlg, e o que farei no futuro?. Estas atividades específicas apresentam uma duração de 45 minutos cada e serão frequentadas, sequencialmente, por três grupos de alunos visitantes.  \r\n\r\nPúblico-alvo: 10º - 12º ano, área ciências e tecnologia. Tipologia da atividade geral: misto.\r\n\r\n(a) Cultura celular: aventura no multiverso da ciência\r\nA cultura celular de células humanas compreende um conjunto de técnicas, que simulam as condições naturais do corpo humano, num ambiente artificial (in vitro). Tal permite-nos entender a fisiologia e bioquímica da célula e obter dados a partir de ensaios in vitro que, de outra forma, necessitariam de ser obtidos a partir de ensaios em animais (in vivo). Neste sentido, a cultura de células torna-se crucial para estudar os mecanismos biológicos, sendo utilizada em diversas áreas, principalmente na investigação fundamental, biotecnologia e medicina. A sua aplicação inclui pesquisas sobre mecanismos de doenças como o cancro, até à fabricação de vacinas, seleção e melhoria de medicamentos, terapia genética, biologia de células estaminais, tecnologia de fertilização in vitro e muito mais! Nesta atividade, os alunos vão ter oportunidade de visualizar, com recurso a microscopia de inversão, diferentes tipos de células humanas extraídas a partir de culturas celulares in vitro.\r\nResponsáveis: Dina Simes, Carla Viegas, Catarina Marreiros, Joana Carreira e Bárbara Vieira.\r\nLocal: Edifício 7, laboratório 0.41.\r\n\r\n(b) A imunologia na bioquímica\r\nA imunologia compreende uma área de investigação em Bioquímica, Biologia, Biomedicina e Medicina dedicada ao estudo dos sistemas imunológicos em organismos animais. As suas bases estão relacionadas com processos de reconhecimento celular e molecular, que definem a individualidade de cada indivíduo e o modo como cada organismo interactua com outros organismos. Esta atividade inclui o estudo do microbioma individual de alguns alunos que, por sua vez, permite compreender como é que cada pessoa interage com diversas estirpes bacterianas. \r\nResponsáveis: Deborah Power e Núcleo de Estudantes de Bioquímica da Associação Académica da Universidade do Algarve (NEBQUAL).\r\nLocal: Edifício 7, laboratório 0.32.\r\n\r\n(c) Bioengenharia: o que será, como será na UAlg e o que farei no futuro?\r\nA bioengenharia é um termo ainda pouco conhecido no vocabulário português! Até porque há muitíssimo poucos cursos em Portugal! MAS, é dos cursos mais versáteis. Quem tem gosto pela biologia, física, química, mas ainda não decidiu exatamente de qual gosta mais, pode e deve inscrever-se na licenciatura em Bioengenharia, e, decidir apenas no 3º ano se gosta mais de engenharia biomédica ou engenharia biológica. Emprego não faltará a quem tenha esta base de conhecimentos! Para melhor esclarecer o que é a bioengenharia, esta atividade desmonstrará como formamos os nossos bioengenheiros (\'o que será?\'). O Núcleo de Estudantes de Bioengenharia, recentemente criado, explicará as suas vivências enquanto alunos de bioengenharia da Universidade do Algarve (\'como será na UAlg?\'). No final, para terem idéia de \'como será no futuro?\', experienciarão o uso da tecnologia em prol de próteses clínicas.\r\nResponsáveis: Adriana Cavaco, Rui Borges, Graça Ruano e Núcleo de Estudantes de Bioengenharia da Associação Académica da Universidade do Algarve (NEB)\r\nLocal: Edifício 1, laboratório 2.76.', 'Ciencias e Tecnologia', 3, 'Misto', 'Aceite', '2022-03-03 11:48:07.781673', '2022-03-03 12:18:12.782010', 180, 45, 3, 31, 25, 4),
(21, 'Visita às Artes Visuais', 'Uma visita às instalações onde decorre a Licenciatura em Artes Visuais (AV).', 'Linguas e Humanidades', 2, 'Misto', 'Pendente', '2022-03-15 18:28:03.120040', '2022-03-15 18:29:03.741716', 30, 20, 3, 64, 37, 4),
(22, 'Teste', 'teste', 'Ciencias e Tecnologia', 1, 'Atividade Laboratorial', 'Aceite', '2023-04-19 09:31:38.903251', '2023-04-19 09:34:20.952367', 60, 45, 4, 33, 26, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(4, 'Administrador'),
(5, 'Colaborador'),
(1, 'Coordenador'),
(2, 'Participante'),
(3, 'ProfessorUniversitario');

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add permission', 1, 'add_permission'),
(2, 'Can change permission', 1, 'change_permission'),
(3, 'Can delete permission', 1, 'delete_permission'),
(4, 'Can view permission', 1, 'view_permission'),
(5, 'Can add group', 2, 'add_group'),
(6, 'Can change group', 2, 'change_group'),
(7, 'Can delete group', 2, 'delete_group'),
(8, 'Can view group', 2, 'view_group'),
(9, 'Can add user', 3, 'add_user'),
(10, 'Can change user', 3, 'change_user'),
(11, 'Can delete user', 3, 'delete_user'),
(12, 'Can view user', 3, 'view_user'),
(13, 'Can add log entry', 4, 'add_logentry'),
(14, 'Can change log entry', 4, 'change_logentry'),
(15, 'Can delete log entry', 4, 'delete_logentry'),
(16, 'Can view log entry', 4, 'view_logentry'),
(17, 'Can add anfiteatro', 5, 'add_anfiteatro'),
(18, 'Can change anfiteatro', 5, 'change_anfiteatro'),
(19, 'Can delete anfiteatro', 5, 'delete_anfiteatro'),
(20, 'Can view anfiteatro', 5, 'view_anfiteatro'),
(21, 'Can add arlivre', 6, 'add_arlivre'),
(22, 'Can change arlivre', 6, 'change_arlivre'),
(23, 'Can delete arlivre', 6, 'delete_arlivre'),
(24, 'Can view arlivre', 6, 'view_arlivre'),
(25, 'Can add atividade', 7, 'add_atividade'),
(26, 'Can change atividade', 7, 'change_atividade'),
(27, 'Can delete atividade', 7, 'delete_atividade'),
(28, 'Can view atividade', 7, 'view_atividade'),
(29, 'Can add tema', 8, 'add_tema'),
(30, 'Can change tema', 8, 'change_tema'),
(31, 'Can delete tema', 8, 'delete_tema'),
(32, 'Can view tema', 8, 'view_tema'),
(33, 'Can add tema q', 9, 'add_temaq'),
(34, 'Can change tema q', 9, 'change_temaq'),
(35, 'Can delete tema q', 9, 'delete_temaq'),
(36, 'Can view tema q', 9, 'view_temaq'),
(37, 'Can add sessao', 10, 'add_sessao'),
(38, 'Can change sessao', 10, 'change_sessao'),
(39, 'Can delete sessao', 10, 'delete_sessao'),
(40, 'Can view sessao', 10, 'view_sessao'),
(41, 'Can add materiais', 11, 'add_materiais'),
(42, 'Can change materiais', 11, 'change_materiais'),
(43, 'Can delete materiais', 11, 'delete_materiais'),
(44, 'Can view materiais', 11, 'view_materiais'),
(45, 'Can add preferencia', 12, 'add_preferencia'),
(46, 'Can change preferencia', 12, 'change_preferencia'),
(47, 'Can delete preferencia', 12, 'delete_preferencia'),
(48, 'Can view preferencia', 12, 'view_preferencia'),
(49, 'Can add preferencia atividade', 13, 'add_preferenciaatividade'),
(50, 'Can change preferencia atividade', 13, 'change_preferenciaatividade'),
(51, 'Can delete preferencia atividade', 13, 'delete_preferenciaatividade'),
(52, 'Can view preferencia atividade', 13, 'view_preferenciaatividade'),
(53, 'Can add colaborador horario', 14, 'add_colaboradorhorario'),
(54, 'Can change colaborador horario', 14, 'change_colaboradorhorario'),
(55, 'Can delete colaborador horario', 14, 'delete_colaboradorhorario'),
(56, 'Can view colaborador horario', 14, 'view_colaboradorhorario'),
(57, 'Can add campus', 15, 'add_campus'),
(58, 'Can change campus', 15, 'change_campus'),
(59, 'Can delete campus', 15, 'delete_campus'),
(60, 'Can view campus', 15, 'view_campus'),
(61, 'Can add curso', 16, 'add_curso'),
(62, 'Can change curso', 16, 'change_curso'),
(63, 'Can delete curso', 16, 'delete_curso'),
(64, 'Can view curso', 16, 'view_curso'),
(65, 'Can add departamento', 17, 'add_departamento'),
(66, 'Can change departamento', 17, 'change_departamento'),
(67, 'Can delete departamento', 17, 'delete_departamento'),
(68, 'Can view departamento', 17, 'view_departamento'),
(69, 'Can add diaaberto', 18, 'add_diaaberto'),
(70, 'Can change diaaberto', 18, 'change_diaaberto'),
(71, 'Can delete diaaberto', 18, 'delete_diaaberto'),
(72, 'Can view diaaberto', 18, 'view_diaaberto'),
(73, 'Can add edificio', 19, 'add_edificio'),
(74, 'Can change edificio', 19, 'change_edificio'),
(75, 'Can delete edificio', 19, 'delete_edificio'),
(76, 'Can view edificio', 19, 'view_edificio'),
(77, 'Can add espaco', 20, 'add_espaco'),
(78, 'Can change espaco', 20, 'change_espaco'),
(79, 'Can delete espaco', 20, 'delete_espaco'),
(80, 'Can view espaco', 20, 'view_espaco'),
(81, 'Can add horario', 21, 'add_horario'),
(82, 'Can change horario', 21, 'change_horario'),
(83, 'Can delete horario', 21, 'delete_horario'),
(84, 'Can view horario', 21, 'view_horario'),
(85, 'Can add menu', 22, 'add_menu'),
(86, 'Can change menu', 22, 'change_menu'),
(87, 'Can delete menu', 22, 'delete_menu'),
(88, 'Can view menu', 22, 'view_menu'),
(89, 'Can add transporte', 23, 'add_transporte'),
(90, 'Can change transporte', 23, 'change_transporte'),
(91, 'Can delete transporte', 23, 'delete_transporte'),
(92, 'Can view transporte', 23, 'view_transporte'),
(93, 'Can add transporteuniversitario', 24, 'add_transporteuniversitario'),
(94, 'Can change transporteuniversitario', 24, 'change_transporteuniversitario'),
(95, 'Can delete transporteuniversitario', 24, 'delete_transporteuniversitario'),
(96, 'Can view transporteuniversitario', 24, 'view_transporteuniversitario'),
(97, 'Can add unidadeorganica', 25, 'add_unidadeorganica'),
(98, 'Can change unidadeorganica', 25, 'change_unidadeorganica'),
(99, 'Can delete unidadeorganica', 25, 'delete_unidadeorganica'),
(100, 'Can view unidadeorganica', 25, 'view_unidadeorganica'),
(101, 'Can add transportehorario', 26, 'add_transportehorario'),
(102, 'Can change transportehorario', 26, 'change_transportehorario'),
(103, 'Can delete transportehorario', 26, 'delete_transportehorario'),
(104, 'Can view transportehorario', 26, 'view_transportehorario'),
(105, 'Can add sala', 27, 'add_sala'),
(106, 'Can change sala', 27, 'change_sala'),
(107, 'Can delete sala', 27, 'delete_sala'),
(108, 'Can view sala', 27, 'view_sala'),
(109, 'Can add prato', 28, 'add_prato'),
(110, 'Can change prato', 28, 'change_prato'),
(111, 'Can delete prato', 28, 'delete_prato'),
(112, 'Can view prato', 28, 'view_prato'),
(113, 'Can add idioma', 29, 'add_idioma'),
(114, 'Can change idioma', 29, 'change_idioma'),
(115, 'Can delete idioma', 29, 'delete_idioma'),
(116, 'Can view idioma', 29, 'view_idioma'),
(117, 'Can add tarefa', 30, 'add_tarefa'),
(118, 'Can change tarefa', 30, 'change_tarefa'),
(119, 'Can delete tarefa', 30, 'delete_tarefa'),
(120, 'Can view tarefa', 30, 'view_tarefa'),
(121, 'Can add tarefa acompanhar', 31, 'add_tarefaacompanhar'),
(122, 'Can change tarefa acompanhar', 31, 'change_tarefaacompanhar'),
(123, 'Can delete tarefa acompanhar', 31, 'delete_tarefaacompanhar'),
(124, 'Can view tarefa acompanhar', 31, 'view_tarefaacompanhar'),
(125, 'Can add tarefa auxiliar', 32, 'add_tarefaauxiliar'),
(126, 'Can change tarefa auxiliar', 32, 'change_tarefaauxiliar'),
(127, 'Can delete tarefa auxiliar', 32, 'delete_tarefaauxiliar'),
(128, 'Can view tarefa auxiliar', 32, 'view_tarefaauxiliar'),
(129, 'Can add tarefa outra', 33, 'add_tarefaoutra'),
(130, 'Can change tarefa outra', 33, 'change_tarefaoutra'),
(131, 'Can delete tarefa outra', 33, 'delete_tarefaoutra'),
(132, 'Can view tarefa outra', 33, 'view_tarefaoutra'),
(133, 'Can add escola', 34, 'add_escola'),
(134, 'Can change escola', 34, 'change_escola'),
(135, 'Can delete escola', 34, 'delete_escola'),
(136, 'Can view escola', 34, 'view_escola'),
(137, 'Can add inscricao', 35, 'add_inscricao'),
(138, 'Can change inscricao', 35, 'change_inscricao'),
(139, 'Can delete inscricao', 35, 'delete_inscricao'),
(140, 'Can view inscricao', 35, 'view_inscricao'),
(141, 'Can add responsavel', 36, 'add_responsavel'),
(142, 'Can change responsavel', 36, 'change_responsavel'),
(143, 'Can delete responsavel', 36, 'delete_responsavel'),
(144, 'Can view responsavel', 36, 'view_responsavel'),
(145, 'Can add inscricaotransporte', 37, 'add_inscricaotransporte'),
(146, 'Can change inscricaotransporte', 37, 'change_inscricaotransporte'),
(147, 'Can delete inscricaotransporte', 37, 'delete_inscricaotransporte'),
(148, 'Can view inscricaotransporte', 37, 'view_inscricaotransporte'),
(149, 'Can add inscricaosessao', 38, 'add_inscricaosessao'),
(150, 'Can change inscricaosessao', 38, 'change_inscricaosessao'),
(151, 'Can delete inscricaosessao', 38, 'delete_inscricaosessao'),
(152, 'Can view inscricaosessao', 38, 'view_inscricaosessao'),
(153, 'Can add inscricaoprato', 39, 'add_inscricaoprato'),
(154, 'Can change inscricaoprato', 39, 'change_inscricaoprato'),
(155, 'Can delete inscricaoprato', 39, 'delete_inscricaoprato'),
(156, 'Can view inscricaoprato', 39, 'view_inscricaoprato'),
(157, 'Can add informacao mensagem', 40, 'add_informacaomensagem'),
(158, 'Can change informacao mensagem', 40, 'change_informacaomensagem'),
(159, 'Can delete informacao mensagem', 40, 'delete_informacaomensagem'),
(160, 'Can view informacao mensagem', 40, 'view_informacaomensagem'),
(161, 'Can add informacao notificacao', 41, 'add_informacaonotificacao'),
(162, 'Can change informacao notificacao', 41, 'change_informacaonotificacao'),
(163, 'Can delete informacao notificacao', 41, 'delete_informacaonotificacao'),
(164, 'Can view informacao notificacao', 41, 'view_informacaonotificacao'),
(165, 'Can add notificacao', 42, 'add_notificacao'),
(166, 'Can change notificacao', 42, 'change_notificacao'),
(167, 'Can delete notificacao', 42, 'delete_notificacao'),
(168, 'Can view notificacao', 42, 'view_notificacao'),
(169, 'Can add mensagem recebida', 43, 'add_mensagemrecebida'),
(170, 'Can change mensagem recebida', 43, 'change_mensagemrecebida'),
(171, 'Can delete mensagem recebida', 43, 'delete_mensagemrecebida'),
(172, 'Can view mensagem recebida', 43, 'view_mensagemrecebida'),
(173, 'Can add mensagem enviada', 44, 'add_mensagemenviada'),
(174, 'Can change mensagem enviada', 44, 'change_mensagemenviada'),
(175, 'Can delete mensagem enviada', 44, 'delete_mensagemenviada'),
(176, 'Can view mensagem enviada', 44, 'view_mensagemenviada'),
(177, 'Can add Opção de Pergunta', 45, 'add_opcaop'),
(178, 'Can change Opção de Pergunta', 45, 'change_opcaop'),
(179, 'Can delete Opção de Pergunta', 45, 'delete_opcaop'),
(180, 'Can view Opção de Pergunta', 45, 'view_opcaop'),
(181, 'Can add Pergunta', 46, 'add_pergunta'),
(182, 'Can change Pergunta', 46, 'change_pergunta'),
(183, 'Can delete Pergunta', 46, 'delete_pergunta'),
(184, 'Can view Pergunta', 46, 'view_pergunta'),
(185, 'Can add questionario', 47, 'add_questionario'),
(186, 'Can change questionario', 47, 'change_questionario'),
(187, 'Can delete questionario', 47, 'delete_questionario'),
(188, 'Can view questionario', 47, 'view_questionario'),
(189, 'Can add estado questionario', 48, 'add_estadoquestionario'),
(190, 'Can change estado questionario', 48, 'change_estadoquestionario'),
(191, 'Can delete estado questionario', 48, 'delete_estadoquestionario'),
(192, 'Can view estado questionario', 48, 'view_estadoquestionario'),
(193, 'Can add resposta', 49, 'add_resposta'),
(194, 'Can change resposta', 49, 'change_resposta'),
(195, 'Can delete resposta', 49, 'delete_resposta'),
(196, 'Can view resposta', 49, 'view_resposta'),
(197, 'Can add resposta_ individual', 50, 'add_resposta_individual'),
(198, 'Can change resposta_ individual', 50, 'change_resposta_individual'),
(199, 'Can delete resposta_ individual', 50, 'delete_resposta_individual'),
(200, 'Can view resposta_ individual', 50, 'view_resposta_individual'),
(201, 'Can add utilizador', 51, 'add_utilizador'),
(202, 'Can change utilizador', 51, 'change_utilizador'),
(203, 'Can delete utilizador', 51, 'delete_utilizador'),
(204, 'Can view utilizador', 51, 'view_utilizador'),
(205, 'Can add administrador', 52, 'add_administrador'),
(206, 'Can change administrador', 52, 'change_administrador'),
(207, 'Can delete administrador', 52, 'delete_administrador'),
(208, 'Can view administrador', 52, 'view_administrador'),
(209, 'Can add participante', 53, 'add_participante'),
(210, 'Can change participante', 53, 'change_participante'),
(211, 'Can delete participante', 53, 'delete_participante'),
(212, 'Can view participante', 53, 'view_participante'),
(213, 'Can add professor universitario', 54, 'add_professoruniversitario'),
(214, 'Can change professor universitario', 54, 'change_professoruniversitario'),
(215, 'Can delete professor universitario', 54, 'delete_professoruniversitario'),
(216, 'Can view professor universitario', 54, 'view_professoruniversitario'),
(217, 'Can add coordenador', 55, 'add_coordenador'),
(218, 'Can change coordenador', 55, 'change_coordenador'),
(219, 'Can delete coordenador', 55, 'delete_coordenador'),
(220, 'Can view coordenador', 55, 'view_coordenador'),
(221, 'Can add colaborador', 56, 'add_colaborador'),
(222, 'Can change colaborador', 56, 'change_colaborador'),
(223, 'Can delete colaborador', 56, 'delete_colaborador'),
(224, 'Can view colaborador', 56, 'view_colaborador'),
(225, 'Can add content type', 57, 'add_contenttype'),
(226, 'Can change content type', 57, 'change_contenttype'),
(227, 'Can delete content type', 57, 'delete_contenttype'),
(228, 'Can view content type', 57, 'view_contenttype'),
(229, 'Can add session', 58, 'add_session'),
(230, 'Can change session', 58, 'change_session'),
(231, 'Can delete session', 58, 'delete_session'),
(232, 'Can view session', 58, 'view_session'),
(233, 'Can add respostas_ usuario', 59, 'add_respostas_usuario'),
(234, 'Can change respostas_ usuario', 59, 'change_respostas_usuario'),
(235, 'Can delete respostas_ usuario', 59, 'delete_respostas_usuario'),
(236, 'Can view respostas_ usuario', 59, 'view_respostas_usuario'),
(237, 'Can add relatorio', 60, 'add_relatorio'),
(238, 'Can change relatorio', 60, 'change_relatorio'),
(239, 'Can delete relatorio', 60, 'delete_relatorio'),
(240, 'Can view relatorio', 60, 'view_relatorio');

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$c947aOpH7a0vcGqt6eBlO5$6zPfUhtkmar6+0oase6PRREOAvlvSHGHwd6qnU0L2tU=', '2024-03-15 10:48:09.528985', 0, 'admin', 'admin', 'admin', '', 0, 1, '2024-03-12 15:28:20.152919'),
(2, 'pbkdf2_sha256$390000$Qv8PUdEUtSbrO23AhTT2dQ$wJqBBfNqRwAZJm2ZgF6LJ0A78gkbhJk74CHmOmleL2M=', '2024-03-13 11:19:53.289274', 0, 'TESTE', 'TESTE', 'TESTE', 'TESTE@teste.com', 0, 1, '2024-03-13 11:16:32.141027'),
(23, 'pbkdf2_sha256$180000$V7gVHaiKyGRP$71/B2Aye/lXWt5t9wz6GPfMwgOMeVQziCZAKCD4JK10=', '2022-03-09 14:58:30.221368', 0, 'isilva@ualg.pt', 'Ivete', 'Silva', 'isilva@ualg.pt', 0, 1, '2022-02-16 10:29:29.616641'),
(25, 'pbkdf2_sha256$180000$k9gGmvn6aEZY$Tm4WrwB7mh3c7ROzJw/pFYpQuMLj8z0l8L2vdk9sY2g=', '2022-03-03 12:06:40.973125', 0, 'abarbosa', 'Ana', 'Barbosa', 'abarbosa@ualg.pt', 0, 1, '2022-02-23 15:57:06.463555'),
(26, 'pbkdf2_sha256$180000$33IEgNRRtfv0$A5AwJGg+FUfZ/ebyyyMCMD96KoL9o4Tv+ngG4ypryNs=', '2023-09-25 11:18:56.017870', 0, 'pventura', 'Paula', 'Ventura Martins', 'pventura@ualg.pt', 0, 1, '2022-02-23 19:00:39.878596'),
(28, 'pbkdf2_sha256$180000$fqAYuNPoBL4u$qty1h/oaPLWcXJF2aABoRdOEn9LlYa0KqEl2Q+vnvms=', NULL, 0, 'Eugénia', 'Eugénia', 'Ferreira', 'ecastela@ualg.pt', 0, 1, '2022-02-26 10:23:20.418581'),
(29, 'pbkdf2_sha256$180000$dFZPfkP56UxB$bZCTVS3OINMUq7cz4i9GRgkWREb6qKFjQWxmOhkaG58=', '2022-03-03 15:55:57.467222', 0, 'pscorreia@ualg.pt', 'Paula', 'Serdeira Azevedo', 'pscorreia@ualg.pt', 0, 1, '2022-02-28 12:24:09.334538'),
(31, 'pbkdf2_sha256$180000$R4VZIEMQbP6M$hXYZqt530bH9fVdA7zpkbenPc66QGkq/HsUDG9jP7gk=', '2023-04-19 09:34:11.521940', 0, 'FCT', 'FCT', 'UAlg', 'pcnvmartins@gmail.com', 0, 1, '2022-02-28 15:54:30.293608'),
(32, 'pbkdf2_sha256$180000$qGXefmH6r9DU$MmiUVWckwy1Rn+PkGnrWEEpgSwVRRNRQsvxl3yawMzo=', NULL, 0, 'pjsantos', 'Paulo Jorge', 'Maia dos Santos', 'pjsantos@ualg.pt', 0, 1, '2022-03-02 16:10:57.022054'),
(33, 'pbkdf2_sha256$180000$SEt79NjESsD1$MRRsCBHI33c0ToSyXaALvicWZT2mxbeVz9fWh1sYn9g=', '2022-03-09 14:16:47.686928', 0, 'Ivete', 'Ivete', 'Silva', 'info@ualg.pt', 0, 1, '2022-03-07 11:32:24.945600'),
(34, 'pbkdf2_sha256$180000$RRLVBkWuaSJj$kuknc9/lrW221MOGy6Ply6fEsS0roBTxcCJAuxhaqkc=', NULL, 0, 'gaborges', 'Gabriela', 'Borges', 'gaborges@ualg.pt', 0, 1, '2022-03-07 12:12:16.893732'),
(35, 'pbkdf2_sha256$180000$49dV51bprvON$qrqCZnbP1mOiwOpmVNHUCTT1c4yWFA/4P8+Yp6FF8LI=', NULL, 0, 'atmartins', 'Ana Teresa', 'Martins', 'atmartins@ualg.pt', 0, 1, '2022-03-15 16:00:46.596487'),
(36, 'pbkdf2_sha256$180000$fXfbGzdLztoR$SPIaAvrm3MUc0JAeKnF1GNf5KLGaWvu8+/mFxRgOFuM=', NULL, 0, 'FCHS_DPCE', 'FCHS_DPCE', 'FCHS_DPCE', 'fcinacio@ualg.pt', 0, 1, '2022-03-15 16:03:54.936310'),
(37, 'pbkdf2_sha256$180000$qMUZDkC7bT74$hO1cuy9aC1uyyNA4z+4VJS07rp/pDMgpRT0Y3iC1Iq0=', '2022-03-15 18:26:46.665722', 0, 'ACValente', 'António', 'Costa Valente', 'amvalente@ualg.pt', 0, 1, '2022-03-15 16:12:53.774834'),
(38, 'pbkdf2_sha256$180000$wAdQrymWmQdU$eyivk8VWwKS/1wvwFSVvFGOGAeWJ6zbF4X/DFjjlPg4=', '2023-04-19 09:39:43.745415', 0, 'pventura2', 'Paula', 'Martins', 'pcnvmartins1@gmail.com', 0, 1, '2022-04-21 14:46:51.545381'),
(39, 'pbkdf2_sha256$180000$5bTnUTTHcrxy$Abzg/VzK41cDJYLsH7awlFw2uURDDhK14Nxbp9KZsI4=', NULL, 0, 'mz', 'Marielba', 'Zacarias', 'mz@ualg.pt', 0, 1, '2023-05-18 16:13:25.030743'),
(40, 'pbkdf2_sha256$180000$wNmJbmhBftQ2$KtzVc0KYrKw3BEL+EUF4mECBrHD7VvOw4AtKKV0eTyQ=', '2023-11-06 12:49:38.293446', 0, 'AMS', 'AMS', 'AMS', 'ams@ualg.pt', 0, 1, '2023-09-25 11:05:59.657572'),
(41, 'pbkdf2_sha256$180000$Wizd2Dhwmuox$bon8ZKilBRYMP43mSizM1wxYwlCETLgGbrMsF8rj6WY=', '2024-04-22 01:48:15.342201', 0, 'gustavopellegrini', 'Gustavo Pellegrini', '9999', 'gustavoplgomes@gmail.com', 1, 1, '2024-03-08 11:58:00.000000'),
(42, 'pbkdf2_sha256$180000$PwNev4fuLke7$ABUi8+L1qDo+zrplpuBbPtydedLRoudBSiD//7TXiwA=', '2024-04-10 13:40:01.289744', 1, 'gustavo', '', '', '', 1, 1, '2024-03-08 12:12:54.437322'),
(43, 'pbkdf2_sha256$180000$SjjFnnxOlNlt$MbxhBESxyA2rzZfdD6ZxLIS00SLtVPDE54AmFeqyJI0=', NULL, 1, 'kartic', '', '', '', 1, 1, '2024-03-12 15:58:14.752803'),
(44, 'pbkdf2_sha256$180000$wL9Y0mmMWDIB$5LIz0eDjvF1vGPKV83m3xdrPMFzHMkWPgy+pVt/Pl6c=', NULL, 0, 'zacarias', 'diogo zacarias', 'didis', 'zacarias@gmail.com', 0, 1, '2024-03-12 16:02:35.594557'),
(45, 'pbkdf2_sha256$180000$d55HUQ922lTj$aUE0uZjm/2jPqJRyVOQvlDQsUuU+IT0kqCbjy5tBfeQ=', '2024-03-12 17:13:31.155110', 1, 'gustavo2', '', '', '', 1, 1, '2024-03-12 16:12:09.114357'),
(46, 'pbkdf2_sha256$180000$3TQnzyTDXCqc$2Kg1h80DocXvOD03tgfwXOZfRD6o83x/XZZmR+akz1E=', '2024-04-15 17:25:29.311520', 0, 'professorjurandir', 'Jurandir', 'Gomes', 'jurandir@gmail.com', 1, 1, '2024-04-08 16:13:35.000000'),
(47, 'pbkdf2_sha256$180000$mDaRAnDDIYKT$0DjdtQSqzPkwRlpxp9FDljtJQRJnVKj7OlZ3HdjEdmI=', '2024-04-22 01:47:28.656133', 0, 'participantebelkis', 'Belkis', 'Leite', 'belkis@gmail.com', 0, 1, '2024-04-16 10:40:51.005124');

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 4),
(23, 23, 4),
(25, 25, 3),
(26, 26, 3),
(28, 28, 1),
(29, 29, 1),
(31, 31, 1),
(32, 32, 1),
(34, 33, 2),
(35, 34, 1),
(36, 35, 3),
(37, 36, 1),
(38, 37, 3),
(39, 38, 2),
(40, 39, 3),
(41, 40, 2),
(42, 41, 4),
(43, 44, 4),
(44, 46, 3),
(45, 47, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `campus`
--

CREATE TABLE `campus` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `campus`
--

INSERT INTO `campus` (`ID`, `Nome`) VALUES
(1, 'Penha'),
(2, 'Gambelas'),
(3, 'Portimao');

-- --------------------------------------------------------

--
-- Estrutura para tabela `colaborador`
--

CREATE TABLE `colaborador` (
  `utilizador_ptr_id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `faculdade_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `colaboradorhorario`
--

CREATE TABLE `colaboradorhorario` (
  `ID` int(11) NOT NULL,
  `dia` date NOT NULL,
  `Inicio` time(6) NOT NULL,
  `Fim` time(6) NOT NULL,
  `ColaboradorUtilizadorID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `coordenador`
--

CREATE TABLE `coordenador` (
  `utilizador_ptr_id` int(11) NOT NULL,
  `Gabinete` varchar(255) NOT NULL,
  `DepartamentoID` int(11) NOT NULL,
  `FaculdadeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `coordenador`
--

INSERT INTO `coordenador` (`utilizador_ptr_id`, `Gabinete`, `DepartamentoID`, `FaculdadeID`) VALUES
(28, '2.55', 18, 7),
(29, '33', 5, 2),
(31, 'Ed. 1 2.69', 21, 6),
(32, 'Direção', 9, 4),
(34, '84', 2, 1),
(36, '1.32', 20, 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `curso`
--

CREATE TABLE `curso` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Sigla` varchar(32) DEFAULT NULL,
  `Unidadeorganica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `curso`
--

INSERT INTO `curso` (`ID`, `Nome`, `Sigla`, `Unidadeorganica`) VALUES
(1, 'Ciências da Comunicação', 'CC', 1),
(2, 'Design de Comunicação', 'DC', 1),
(3, 'Desporto', 'Desporto', 1),
(4, 'Educação Básica', 'EB', 1),
(5, 'Educação Social', 'ES', 1),
(6, 'Imagem Animada', 'IA', 1),
(7, 'Gestão', 'Gestão', 2),
(8, 'Gestão Hoteleira', 'GH', 2),
(9, 'Marketing', 'Marketing', 2),
(10, 'Turismo', 'Turismo', 2),
(11, 'Bioengenharia', 'Bioengenharia', 3),
(12, 'Ciências Biomédicas Laboratoriais', 'CBL', 3),
(13, 'Dietética e Nutrição', 'DN', 3),
(14, 'Enfermagem', 'Enfermagem', 3),
(15, 'Farmácia', 'Farmácia', 3),
(16, 'Imagem Médica e Radioterapia', 'IMR', 3),
(17, 'Ortoprotesia', 'Ortoprotesia', 3),
(18, 'Terapia da Fala', 'TF', 3),
(19, 'Engenharia Alimentar', 'EA', 4),
(20, 'Engenharia Civil', 'EC', 4),
(21, 'Engenharia Elétrica e Eletrónica', 'EEE', 4),
(22, 'Engenharia Mecânica', 'EM', 4),
(23, 'Tecnologia e Segurança Alimentar', 'TSA', 4),
(24, 'Tecnologias de Informação e Comunicação', 'TIC', 4),
(25, 'Artes Visuais', 'AV', 5),
(26, 'Ciências da Educação e da Formação', 'CEF', 5),
(27, 'Línguas e Comunicação', 'LC', 5),
(28, 'Línguas, Literaturas e Culturas', 'LLC', 5),
(29, 'Património Cultural e Arqueologia', 'PCA', 5),
(30, 'Psicologia', 'Psicologia', 5),
(31, 'Agronomia', 'Agronomia', 6),
(32, 'Arquitetura Paisagista', 'AP', 6),
(33, 'Bioengenharia', 'Bioengenharia', 6),
(34, 'Biologia', 'Biologia', 6),
(35, 'Biologia Marinha', 'BM', 6),
(36, 'Bioquímica', 'Bioquímica', 6),
(37, 'Biotecnologia', 'Biotecnologia', 6),
(38, 'Engenharia Informática', 'EI', 6),
(39, 'Gestão Marinha e Costeira', 'GMC', 6),
(40, 'Matemática Aplicada à Economia e à Gestão', 'MAEG', 6),
(41, 'Ciências Farmacêuticas', 'CF', 6),
(42, 'Economia', 'Economia', 7),
(43, 'Gestão de Empresas', 'GE', 7),
(44, 'Sociologia', 'Sociologia', 7),
(45, 'Ciências Biomédicas', 'CB', 8),
(46, 'Medicina', 'Medicina', 8),
(47, 'Oncologia', 'Oncologia', 8);

-- --------------------------------------------------------

--
-- Estrutura para tabela `departamento`
--

CREATE TABLE `departamento` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Sigla` varchar(32) DEFAULT NULL,
  `UnidadeOrganicaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `departamento`
--

INSERT INTO `departamento` (`ID`, `Nome`, `Sigla`, `UnidadeOrganicaID`) VALUES
(1, 'Ciências Sociais e da Educação', 'CSE', 1),
(2, 'Comunicação, Artes e Design', 'CAD', 1),
(3, 'Línguas, Literaturas e Culturas', 'LLC', 1),
(4, 'Ciências Exatas, Naturais e Desporto', 'CNND', 1),
(5, 'Escola Superior de Gestão Hotelaria e Turismo', 'ESGHT', 2),
(6, 'Escola Superior de Saúde', 'ESS', 3),
(7, 'Engenharia Alimentar', 'EA', 4),
(8, 'Engenharia Civil', 'EC', 4),
(9, 'Engenharia Eletrotécnica', 'EE', 4),
(10, 'Engenharia Mecânica', 'EM', 4),
(11, 'Artes e Humanidades', 'AH', 5),
(12, 'Ciências Biológicas e Bioengenharia', 'CBB', 6),
(13, 'Ciências da terra, do mar e do ambiente', 'CTMA', 6),
(14, 'Engenharia Eletrónica e Informática', 'EEI', 6),
(15, 'Física', 'Física', 6),
(16, 'Matemática', 'Matemática', 6),
(17, 'Química e Farmácia', 'QF', 6),
(18, 'Faculdade de Economia', 'FE', 7),
(19, 'Departamento de Ciências Biomédicas e Medicina', 'DCBM', 8),
(20, 'Psicologia e Ciências da Educação', 'PCE', 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `diaaberto`
--

CREATE TABLE `diaaberto` (
  `PrecoAlunos` double NOT NULL,
  `PrecoProfessores` double DEFAULT NULL,
  `ID` int(11) NOT NULL,
  `EnderecoPaginaWeb` varchar(255) NOT NULL,
  `Descricao` longtext NOT NULL,
  `EmailDiaAberto` varchar(255) NOT NULL,
  `Ano` int(11) NOT NULL,
  `DataDiaAbertoInicio` datetime(6) NOT NULL,
  `DataDiaAbertoFim` datetime(6) NOT NULL,
  `DataInscricaoAtividadesInicio` datetime(6) NOT NULL,
  `DataInscricaoAtividadesFim` datetime(6) NOT NULL,
  `DataPropostasAtividadesIncio` datetime(6) NOT NULL,
  `DataPorpostaAtividadesFim` datetime(6) NOT NULL,
  `EscalaSessoes` time(6) NOT NULL,
  `AdministradorUtilizadorID` int(11) DEFAULT NULL,
  `QuestionarioID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `diaaberto`
--

INSERT INTO `diaaberto` (`PrecoAlunos`, `PrecoProfessores`, `ID`, `EnderecoPaginaWeb`, `Descricao`, `EmailDiaAberto`, `Ano`, `DataDiaAbertoInicio`, `DataDiaAbertoFim`, `DataInscricaoAtividadesInicio`, `DataInscricaoAtividadesFim`, `DataPropostasAtividadesIncio`, `DataPorpostaAtividadesFim`, `EscalaSessoes`, `AdministradorUtilizadorID`, `QuestionarioID`) VALUES
(2.85, 4.7, 3, 'Dia Aberto 2022', 'Nos dias 3 e 4 de maio de 2022, a Universidade do Algarve estará de portas abertas para toda a comunidade.\r\n\r\n A iniciativa é destinada a alunos dos 9.º, 10.º, 11.º e 12.º anos e seus professores, bem como a encarregados de educação, outros agentes educativos e demais interessados. \r\n\r\nCom o objetivo de divulgar a oferta formativa para o próximo ano letivo e dar a conhecer o trabalho pedagógico e científico desenvolvido na UAlg, o Dia Aberto 2022 apresenta um programa variado, com iniciativas de carácter informativo, pedagógico, experimental e até lúdico, onde se incluem atividades experimentais, palestras e workshops, visitas guiadas, exposições e atividades desportivas.', 'diaaberto@ualg.pt', 2022, '2022-05-03 08:30:00.000000', '2022-05-04 18:00:00.000000', '2021-03-21 23:55:00.000000', '2022-04-29 23:55:00.000000', '2022-02-15 23:55:00.000000', '2022-03-20 23:55:00.000000', '00:30:00.000000', 23, 42),
(2.9, 4.35, 4, 'https://www.ualg.pt/inscricoes-abertas-para-os-dias-abertos-da-ualg', 'Com o objetivo de divulgar a oferta formativa e dar a conhecer o trabalho pedagógico e científico desenvolvido na Universidade do Algarve, o Dia Aberto apresenta um programa variado com atividades de carácter informativo, pedagógico, experimental e lúdico. ​​​​​​​\r\n\r\nPúblico-Alvo\r\n\r\nA iniciativa é destinada aos alunos dos 9.º, 10.º, 11.º e 12.º anos e aos seus professores, mas também outros agentes educativos, procurando incluir os encarregados de educação e demais cidadãos interessados.\r\n\r\nData\r\n\r\nEm 2023, a iniciativa vai realizar-se nos dias 18 e 19 de abril.\r\n\r\nInscrição\r\n\r\nO formulário de inscrição online está disponível até 31 de março.\r\n\r\nNota: login: escolas | password: escolas\r\n\r\nPrograma\r\n\r\nO programa contempla iniciativas variadas nos 2 campi (Penha e Gambelas), onde se realizarão atividades experimentais, palestras e workshops, visitas guiadas, exposições e atividades desportivas.\r\n\r\n18 de abril disponível aqui\r\n19 de abril disponível aqui\r\nTransportes\r\n\r\nOs grupos visitantes devem organizar o seu transporte até Faro.\r\n\r\nAutocarro camarário/de aluguer Os grupos que se fizerem transportar em autocarro próprio deverão, na chegada, dirigir-se à receção do campus onde se realizará a primeira atividade do seu programa para receber o kit de boas-vindas. Os percursos entre campi deverão ser organizados utilizando os seus autocarros.  \r\nComboio Os grupos que se fizerem transportar de comboio até à estação da CP em Faro utilizarão, a partir daí, os autocarros disponibilizados pela Universidade do Algarve para circularem entre os campi. Prevendo-se um significativo aumento de passageiros neste dia, solicita-se aos grupos que contactem antecipadamente a CP, através do email gruposlc-rg@cp.pt para a reserva de bilhetes. Desta forma, poderão beneficiar de tarifas bonificadas para grupos, com descontos entre 10% e 30% (dependendo da distância percorrida).  \r\nTransporte público rodoviário Os grupos que se fizerem transportar de autocarro público deverão sair na estação terminal, em Faro. Utilizarão, a partir daí, os autocarros disponibilizados pela Universidade do Algarve.  \r\nOutros meios Os grupos que se façam transportar por outros meios (a pé, transporte próprio) deverão, na chegada, dirigir-se à receção do campus onde se realizará a primeira atividade do seu programa para receber o kit de boas-vindas. Os percursos entre campi poderão ser assegurados pelos autocarros disponibilizados pela Universidade do Algarve. Para tal, deverão assinalar, no formulário, que “precisam de “transporte para efetuar as visitas entre os 2 campi”.\r\nRefeições\r\n\r\nOs alunos e professores que desejarem almoçar nas cantinas universitárias devem mencioná-lo no formulário de inscrição.\r\nO preço da refeição é de 2,90 Euros para estudantes e de 4,35 Euros para docentes e acompanhantes e as senhas deverão ser levantadas no dia da visita.', 'diaaberto2021@ualg.pt', 2023, '2023-12-06 09:00:00.000000', '2023-12-07 17:00:00.000000', '2023-11-06 10:36:00.000000', '2023-11-16 23:55:00.000000', '2023-03-06 23:55:00.000000', '2023-04-18 10:35:00.000000', '00:30:00.000000', 1, 43),
(3, 2, 5, 'ssss', 'sdasdas', 's@dsfsd.com', 2024, '2024-05-05 09:00:00.000000', '2024-05-07 17:00:00.000000', '2024-04-04 23:55:00.000000', '2024-04-22 23:55:00.000000', '2024-03-04 23:55:00.000000', '2024-03-24 23:55:00.000000', '00:30:00.000000', 41, 41);

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-03-08 12:16:44.682992', '41', 'gustavopellegrini', 2, '[{\"changed\": {\"fields\": [\"Valido\"]}}]', 45, 42),
(2, '2024-03-12 17:03:24.172238', '41', 'gustavopellegrini', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 44, 42),
(3, '2024-04-08 16:15:34.145969', '46', '999 Faculdade de Ciências e Tecnologia Engenharia Eletrónica e Informática', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 54, 42),
(4, '2024-04-08 16:17:25.656598', '46', '999 Faculdade de Ciências e Tecnologia Engenharia Eletrónica e Informática', 2, '[{\"changed\": {\"fields\": [\"Valido\"]}}]', 54, 42);

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(4, 'admin', 'logentry'),
(5, 'atividades', 'anfiteatro'),
(6, 'atividades', 'arlivre'),
(7, 'atividades', 'atividade'),
(11, 'atividades', 'materiais'),
(10, 'atividades', 'sessao'),
(8, 'atividades', 'tema'),
(9, 'atividades', 'temaq'),
(2, 'auth', 'group'),
(1, 'auth', 'permission'),
(3, 'auth', 'user'),
(14, 'colaboradores', 'colaboradorhorario'),
(12, 'colaboradores', 'preferencia'),
(13, 'colaboradores', 'preferenciaatividade'),
(15, 'configuracao', 'campus'),
(16, 'configuracao', 'curso'),
(17, 'configuracao', 'departamento'),
(18, 'configuracao', 'diaaberto'),
(19, 'configuracao', 'edificio'),
(20, 'configuracao', 'espaco'),
(21, 'configuracao', 'horario'),
(29, 'configuracao', 'idioma'),
(22, 'configuracao', 'menu'),
(28, 'configuracao', 'prato'),
(27, 'configuracao', 'sala'),
(23, 'configuracao', 'transporte'),
(26, 'configuracao', 'transportehorario'),
(24, 'configuracao', 'transporteuniversitario'),
(25, 'configuracao', 'unidadeorganica'),
(57, 'contenttypes', 'contenttype'),
(30, 'coordenadores', 'tarefa'),
(31, 'coordenadores', 'tarefaacompanhar'),
(32, 'coordenadores', 'tarefaauxiliar'),
(33, 'coordenadores', 'tarefaoutra'),
(34, 'inscricoes', 'escola'),
(35, 'inscricoes', 'inscricao'),
(39, 'inscricoes', 'inscricaoprato'),
(38, 'inscricoes', 'inscricaosessao'),
(37, 'inscricoes', 'inscricaotransporte'),
(36, 'inscricoes', 'responsavel'),
(40, 'notificacoes', 'informacaomensagem'),
(41, 'notificacoes', 'informacaonotificacao'),
(44, 'notificacoes', 'mensagemenviada'),
(43, 'notificacoes', 'mensagemrecebida'),
(42, 'notificacoes', 'notificacao'),
(48, 'questionarios', 'estadoquestionario'),
(45, 'questionarios', 'opcaop'),
(46, 'questionarios', 'pergunta'),
(47, 'questionarios', 'questionario'),
(49, 'questionariosPublicados', 'resposta'),
(59, 'questionariosPublicados', 'respostas_usuario'),
(50, 'questionariosPublicados', 'resposta_individual'),
(60, 'relatorios', 'relatorio'),
(58, 'sessions', 'session'),
(52, 'utilizadores', 'administrador'),
(56, 'utilizadores', 'colaborador'),
(55, 'utilizadores', 'coordenador'),
(53, 'utilizadores', 'participante'),
(54, 'utilizadores', 'professoruniversitario'),
(51, 'utilizadores', 'utilizador');

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-04-04 13:05:59.405472'),
(2, 'auth', '0001_initial', '2024-04-04 13:06:00.296759'),
(3, 'admin', '0001_initial', '2024-04-04 13:06:00.495206'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-04-04 13:06:00.512661'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-04-04 13:06:00.537536'),
(6, 'configuracao', '0001_initial', '2024-04-04 13:06:01.957642'),
(7, 'contenttypes', '0002_remove_content_type_name', '2024-04-04 13:06:02.089997'),
(8, 'auth', '0002_alter_permission_name_max_length', '2024-04-04 13:06:02.278526'),
(9, 'auth', '0003_alter_user_email_max_length', '2024-04-04 13:06:02.303210'),
(10, 'auth', '0004_alter_user_username_opts', '2024-04-04 13:06:02.311222'),
(11, 'auth', '0005_alter_user_last_login_null', '2024-04-04 13:06:02.367770'),
(12, 'auth', '0006_require_contenttypes_0002', '2024-04-04 13:06:02.375776'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2024-04-04 13:06:02.391775'),
(14, 'auth', '0008_alter_user_username_max_length', '2024-04-04 13:06:02.415778'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2024-04-04 13:06:02.432245'),
(16, 'auth', '0010_alter_group_name_max_length', '2024-04-04 13:06:02.456488'),
(17, 'auth', '0011_update_proxy_permissions', '2024-04-04 13:06:02.526446'),
(18, 'utilizadores', '0001_initial', '2024-04-04 13:06:03.489159'),
(19, 'atividades', '0001_initial', '2024-04-04 13:06:04.102607'),
(20, 'atividades', '0002_auto_20240315_1711', '2024-04-04 13:06:04.336560'),
(21, 'auth', '0012_alter_user_first_name_max_length', '2024-04-04 13:06:04.377319'),
(22, 'colaboradores', '0001_initial', '2024-04-04 13:06:04.792252'),
(23, 'questionarios', '0001_initial', '2024-04-04 13:06:04.871290'),
(24, 'configuracao', '0002_auto_20240315_1711', '2024-04-04 13:06:05.225859'),
(25, 'configuracao', '0003_auto_20240324_2123', '2024-04-04 13:06:05.249376'),
(26, 'configuracao', '0004_auto_20240403_2334', '2024-04-04 13:06:05.269582'),
(27, 'configuracao', '0005_alter_transportehorario_chegada_and_more', '2024-04-04 13:06:05.285853'),
(28, 'inscricoes', '0001_initial', '2024-04-04 13:06:06.245292'),
(29, 'coordenadores', '0001_initial', '2024-04-04 13:06:06.567197'),
(30, 'coordenadores', '0002_auto_20240315_1711', '2024-04-04 13:06:07.123173'),
(31, 'inscricoes', '0002_auto_20240315_1711', '2024-04-04 13:06:07.331557'),
(32, 'notificacoes', '0001_initial', '2024-04-04 13:06:08.042001'),
(33, 'notificacoes', '0002_auto_20200702_1848', '2024-04-04 13:06:08.513385'),
(34, 'notificacoes', '0003_alter_notificacao_options_and_more', '2024-04-04 13:06:08.813808'),
(35, 'notificacoes', '0004_alter_notificacao_options_and_more', '2024-04-04 13:06:08.996003'),
(36, 'notificacoes', '0005_alter_notificacao_options_and_more', '2024-04-04 13:06:09.254269'),
(37, 'notificacoes', '0006_alter_notificacao_options_and_more', '2024-04-04 13:06:09.454366'),
(38, 'notifications', '0001_initial', '2024-04-04 13:06:09.495618'),
(39, 'notifications', '0002_auto_20150224_1134', '2024-04-04 13:06:09.520338'),
(40, 'notifications', '0003_notification_data', '2024-04-04 13:06:09.544978'),
(41, 'notifications', '0004_auto_20150826_1508', '2024-04-04 13:06:09.569493'),
(42, 'notifications', '0005_auto_20160504_1520', '2024-04-04 13:06:09.594331'),
(43, 'notifications', '0006_indexes', '2024-04-04 13:06:09.635855'),
(44, 'notifications', '0007_add_timestamp_index', '2024-04-04 13:06:09.660386'),
(45, 'notifications', '0008_index_together_recipient_unread', '2024-04-04 13:06:09.677281'),
(46, 'questionarios', '0002_auto_20240315_1711', '2024-04-04 13:06:10.134335'),
(47, 'questionarios', '0003_auto_20240324_2123', '2024-04-04 13:06:10.183577'),
(48, 'questionarios', '0004_auto_20240403_2324', '2024-04-04 13:06:10.459053'),
(49, 'questionarios', '0005_auto_20240403_2334', '2024-04-04 13:06:10.553519'),
(50, 'sessions', '0001_initial', '2024-04-04 13:06:10.642472'),
(51, 'configuracao', '0005_auto_20240404_1420', '2024-04-04 14:28:10.105796'),
(52, 'configuracao', '0006_auto_20240404_1428', '2024-04-04 14:28:10.114688'),
(53, 'configuracao', '0007_auto_20240404_1505', '2024-04-04 15:05:43.502452'),
(54, 'configuracao', '0008_auto_20240404_1840', '2024-04-04 18:40:17.011247'),
(55, 'configuracao', '0009_auto_20240408_1444', '2024-04-08 14:44:52.649305'),
(56, 'questionariosPublicados', '0001_initial', '2024-04-08 14:47:30.360038'),
(57, 'questionariosPublicados', '0002_resposta_individual_pergunta_id', '2024-04-09 16:41:40.809550'),
(58, 'questionariosPublicados', '0003_rename_pergunta_id_resposta_individual_pergunta', '2024-04-09 16:41:40.902656'),
(59, 'configuracao', '0010_auto_20240412_1838', '2024-04-12 18:38:14.368982'),
(60, 'questionarios', '0006_questionario_estado_anterior', '2024-04-12 18:38:14.423334'),
(61, 'configuracao', '0011_auto_20240412_1918', '2024-04-12 19:18:29.467004'),
(62, 'configuracao', '0012_auto_20240414_0359', '2024-04-14 03:59:33.108561'),
(63, 'questionariosPublicados', '0004_auto_20240416_1016', '2024-04-16 10:17:40.316002'),
(64, 'configuracao', '0013_auto_20240416_1539', '2024-04-16 15:39:51.914576'),
(65, 'relatorios', '0001_initial', '2024-04-16 15:39:51.966775'),
(66, 'questionariosPublicados', '0005_delete_respostas_usuario', '2024-04-19 16:37:52.544788');

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0s28k1k8i9fyg90cod172nxfkct6zkov', 'YmY5YmMwYTExNjU3NzcwYTU0MTAwMmUzODRlNWJkZWU0M2U5NjJhZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZjZmMjU1NDZkYTg4ZjI5NGRhNDkzYzRiMzNhNGJjNjliYmQ4Y2JlIn0=', '2020-07-23 10:44:55.754762'),
('1wjujp1m9u5n9u3ph3ligby4pvjoilvu', '.eJxVjEEOwiAQRe_C2hBgaAGX7j0DgWFGqoYmpV0Z765NutDtf-_9l4hpW2vcOi1xKuIstDj9bjnhg9oOyj212yxxbusyZbkr8qBdXudCz8vh_h3U1Ou3BgDlNWvldCFLXisOjhALIQOP44A5MxuvAhowNmfLJjir0uDB-GTF-wPjtzfO:1rk44p:J2DQ1V7ep4JkAnVfB4iAVx00ZVmyhTBI61LIUK1Owpo', '2024-03-26 15:30:03.114667'),
('1xglglp1jugerfp3ifp2vv2cjt2jff2p', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-29 17:15:37.464737'),
('21wzk5ym52xf2lngjm38m701zxr5sjdv', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2023-11-27 11:52:41.774626'),
('2p80bj4mumjtbx11wiwf013wkxpjrtcr', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-29 17:24:59.727235'),
('3gwz8nnknz84cxby8wc9xd7cmiq02byu', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-04-24 13:36:38.275500'),
('49dw8l5xess7s8jws3mbk4bqiypr5vek', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-05-06 01:48:15.343227'),
('4jhm6nu3zb1nl53h4jsn42n9ozzjdrb2', 'MzM5ODllNDZiNGYzYjVjZjQ4MjQ3YzMzNDJlMDczMWMxMjM4NDc1Mzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ZmViMzg1M2VhYzliZjkwN2Q0MDRiODQ1ZmFiNWM0MjExMDQyOCJ9', '2024-03-26 16:15:19.248995'),
('4ql2uq975u011vc2gtgd4g1pmy1fjcti', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2022-02-22 15:36:04.859925'),
('599m86ourma7s4dx9doexp6dkq1ru5ck', 'ODFiYWJmZDJlMjdmYTRmYTYwOWExYzU5NmZiODhlNDc4OTQ0YTBmODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3IiwiY29uc3VsdGFyX3V0aWxpemFkb3JlcyI6Imh0dHA6Ly8xMC40LjAuOTg6ODU4NS91dGlsaXphZG9yZXMvY29uc3VsdGFydXRpbGl6YWRvcmVzP3BhZ2U9MiJ9', '2021-05-28 14:02:14.438656'),
('5jfswg6ro2vh9q9uzhgphpwst0fxjzuu', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2021-05-13 09:47:28.870244'),
('5wfu21fsfl7x0jhep2mo9xwd3ky3q0dc', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2022-03-09 19:08:29.598267'),
('5y9r7hw1e6zhwsbtwisi209yveigjd10', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2022-05-27 16:08:07.698278'),
('6ug1try18for6g9ko7hm29mezlh928zr', 'MzM5ODllNDZiNGYzYjVjZjQ4MjQ3YzMzNDJlMDczMWMxMjM4NDc1Mzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ZmViMzg1M2VhYzliZjkwN2Q0MDRiODQ1ZmFiNWM0MjExMDQyOCJ9', '2024-03-26 16:53:45.085412'),
('6xwh2n4wshlwbret020ecl1fa1evdbrj', 'NWQ2MDA3MWI3NzZhMWY1NmM0MjViZjBkNzZlZTZjZWQzOTU0MzUzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3IiwiY29uc3VsdGFyX3V0aWxpemFkb3JlcyI6Imh0dHA6Ly8xMC40LjAuOTg6ODU4NS91dGlsaXphZG9yZXMvY29uc3VsdGFydXRpbGl6YWRvcmVzIn0=', '2021-06-25 14:55:27.979532'),
('8ltbebz375o79pd44ykqv65ibossmhfo', 'MzM5ODllNDZiNGYzYjVjZjQ4MjQ3YzMzNDJlMDczMWMxMjM4NDc1Mzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ZmViMzg1M2VhYzliZjkwN2Q0MDRiODQ1ZmFiNWM0MjExMDQyOCJ9', '2024-03-26 16:34:32.635385'),
('911ch58uymzr6fa0cf0ilfbxkrzheuo7', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-03-26 17:19:16.093033'),
('9b5dvf3bufslbv9l5m1uzb53x9c5t205', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2022-04-04 15:27:06.901349'),
('9exuci7qb3uqlwlrvqupecovmbgk5khl', 'ODFiYjc2ZmI3NTYzYjYxM2E5NGYzMTAyZjMzNzBjMWJmNWUyZTE0YTp7Il9hdXRoX3VzZXJfaWQiOiIyNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiM2MxMmNlZjk0NGFiZTFkZTI4NTA4YWQ5MWJkNmJlNTQ1NjM0MjM1NyJ9', '2022-03-14 16:26:27.679442'),
('9smt9jj9uorijk4jw9aeyxf6nbth9teb', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2023-03-16 17:26:59.898890'),
('a5nvbb8plwez3fpjrn840ctp4qr2qqym', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-04-24 13:40:01.292581'),
('adczwm1c6k4cr715e78yztc03n7ukmpk', '.eJxVjEEOwiAQRe_C2hBgaAGX7j0DgWFGqoYmpV0Z765NutDtf-_9l4hpW2vcOi1xKuIstDj9bjnhg9oOyj212yxxbusyZbkr8qBdXudCz8vh_h3U1Ou3BgDlNWvldCFLXisOjhALIQOP44A5MxuvAhowNmfLJjir0uDB-GTF-wPjtzfO:1rl56f:UVihMqF81NFVIxy9bNzn-5-4_BWUaENchFDnt-Jyt6I', '2024-03-29 10:48:09.636808'),
('byhigg58b9jy0cl7jvjrb64kwo3at4gl', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2021-06-09 13:39:17.694431'),
('cozakjzrrjsj3xbxv5nbwd0uobc9qsuq', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-03-26 16:44:21.529977'),
('doadp7hfvlm766toscguymzczmdlti9j', 'YmY5YmMwYTExNjU3NzcwYTU0MTAwMmUzODRlNWJkZWU0M2U5NjJhZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZjZmMjU1NDZkYTg4ZjI5NGRhNDkzYzRiMzNhNGJjNjliYmQ4Y2JlIn0=', '2021-03-12 01:14:54.938284'),
('f38aw91n0jyqjkhiuliha8k4b1indtau', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-03-26 17:00:10.893064'),
('fbmkogsg6tlrrxdcm8tu38xvrt3dlchx', 'MmUzMTA3OTZiYTQ3NTUwMmQ1YWM3Y2I5YjFkYjI4NWQzODNiZTcyYTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODhlMGNkNWM2YmQ0OTNhMTY1YzAyNzUyOTg0NTRhOGQyODM3NWM0NyJ9', '2024-03-26 17:04:06.408345'),
('fhkfe4zpv803deh44qzmstr36nphox6c', 'ZjgwZjEwMDc1OGU4YWRmODA1Y2JiMGFiZDJjZWY1OTRmMjNjZjcwODp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MWY4NTZkMjI1YWM5YjBkMGU0YmE5NDY2NTJjMDljZDNkZjY3M2RhIn0=', '2020-07-16 18:30:40.901947'),
('hdb62lhez22lzj251ui4cv4e3zshlee0', 'ODFiYWJmZDJlMjdmYTRmYTYwOWExYzU5NmZiODhlNDc4OTQ0YTBmODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3IiwiY29uc3VsdGFyX3V0aWxpemFkb3JlcyI6Imh0dHA6Ly8xMC40LjAuOTg6ODU4NS91dGlsaXphZG9yZXMvY29uc3VsdGFydXRpbGl6YWRvcmVzP3BhZ2U9MiJ9', '2023-06-01 16:14:10.763154'),
('jpzflu59iw00mlzkzbf9883nquqivk7i', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-03-29 12:16:08.080926'),
('k7wyjzbjimv7y8t2nje2de1xluylbu5k', 'YzNkZTRmNTljMGZmODQ2MWY1ZjczZGFhM2E0MDkzYWQwOWY2MmViYjp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSIsIl9tZXNzYWdlcyI6IltbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7UERGJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMSw0MCxcIjx1bCBjbGFzcz1cXFwiZXJyb3JsaXN0XFxcIj48bGk+SlxcdTAwZTEgZXhpc3RlIHVtIHJlbGF0XFx1MDBmM3JpbyBjb20gbyB0ZW1hICYjeDI3O0FsbW9jbyYjeDI3OywgdGlwbyAmI3gyNztQREYmI3gyNzsgcGFyYSBvIERpYSBBYmVydG8gYXNzb2NpYWRvIHBvciBlc3RlIGF1dG9yLjwvbGk+PC91bD5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwxLDQwLFwiPHVsIGNsYXNzPVxcXCJlcnJvcmxpc3RcXFwiPjxsaT5KXFx1MDBlMSBleGlzdGUgdW0gcmVsYXRcXHUwMGYzcmlvIGNvbSBvIHRlbWEgJiN4Mjc7QWxtb2NvJiN4Mjc7LCB0aXBvICYjeDI3O1BERiYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7UERGJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMSw0MCxcIjx1bCBjbGFzcz1cXFwiZXJyb3JsaXN0XFxcIj48bGk+SlxcdTAwZTEgZXhpc3RlIHVtIHJlbGF0XFx1MDBmM3JpbyBjb20gbyB0ZW1hICYjeDI3O0FsbW9jbyYjeDI3OywgdGlwbyAmI3gyNztQREYmI3gyNzsgcGFyYSBvIERpYSBBYmVydG8gYXNzb2NpYWRvIHBvciBlc3RlIGF1dG9yLjwvbGk+PC91bD5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwxLDQwLFwiPHVsIGNsYXNzPVxcXCJlcnJvcmxpc3RcXFwiPjxsaT5KXFx1MDBlMSBleGlzdGUgdW0gcmVsYXRcXHUwMGYzcmlvIGNvbSBvIHRlbWEgJiN4Mjc7QWxtb2NvJiN4Mjc7LCB0aXBvICYjeDI3O1BERiYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7UERGJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMSw0MCxcIjx1bCBjbGFzcz1cXFwiZXJyb3JsaXN0XFxcIj48bGk+SlxcdTAwZTEgZXhpc3RlIHVtIHJlbGF0XFx1MDBmM3JpbyBjb20gbyB0ZW1hICYjeDI3O0FsbW9jbyYjeDI3OywgdGlwbyAmI3gyNztQREYmI3gyNzsgcGFyYSBvIERpYSBBYmVydG8gYXNzb2NpYWRvIHBvciBlc3RlIGF1dG9yLjwvbGk+PC91bD5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwxLDQwLFwiPHVsIGNsYXNzPVxcXCJlcnJvcmxpc3RcXFwiPjxsaT5KXFx1MDBlMSBleGlzdGUgdW0gcmVsYXRcXHUwMGYzcmlvIGNvbSBvIHRlbWEgJiN4Mjc7QWxtb2NvJiN4Mjc7LCB0aXBvICYjeDI3O1BERiYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7UERGJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMSw0MCxcIjx1bCBjbGFzcz1cXFwiZXJyb3JsaXN0XFxcIj48bGk+SlxcdTAwZTEgZXhpc3RlIHVtIHJlbGF0XFx1MDBmM3JpbyBjb20gbyB0ZW1hICYjeDI3O0FsbW9jbyYjeDI3OywgdGlwbyAmI3gyNztQREYmI3gyNzsgcGFyYSBvIERpYSBBYmVydG8gYXNzb2NpYWRvIHBvciBlc3RlIGF1dG9yLjwvbGk+PC91bD5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwxLDQwLFwiPHVsIGNsYXNzPVxcXCJlcnJvcmxpc3RcXFwiPjxsaT5KXFx1MDBlMSBleGlzdGUgdW0gcmVsYXRcXHUwMGYzcmlvIGNvbSBvIHRlbWEgJiN4Mjc7QWxtb2NvJiN4Mjc7LCB0aXBvICYjeDI3O1BERiYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7UERGJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlJlbGF0XFx1MDBmM3JpbyBDU1YgY3JpYWRvIGNvbSBzdWNlc3NvIVwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztUcmFuc3BvcnRlJiN4Mjc7LCB0aXBvICYjeDI3O0NTViYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7Q1NWJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMSw0MCxcIjx1bCBjbGFzcz1cXFwiZXJyb3JsaXN0XFxcIj48bGk+SlxcdTAwZTEgZXhpc3RlIHVtIHJlbGF0XFx1MDBmM3JpbyBjb20gbyB0ZW1hICYjeDI3O0FsbW9jbyYjeDI3OywgdGlwbyAmI3gyNztDU1YmI3gyNzsgcGFyYSBvIERpYSBBYmVydG8gYXNzb2NpYWRvIHBvciBlc3RlIGF1dG9yLjwvbGk+PC91bD5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwxLDQwLFwiPHVsIGNsYXNzPVxcXCJlcnJvcmxpc3RcXFwiPjxsaT5KXFx1MDBlMSBleGlzdGUgdW0gcmVsYXRcXHUwMGYzcmlvIGNvbSBvIHRlbWEgJiN4Mjc7QWxtb2NvJiN4Mjc7LCB0aXBvICYjeDI3O0NTViYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDEsNDAsXCI8dWwgY2xhc3M9XFxcImVycm9ybGlzdFxcXCI+PGxpPkpcXHUwMGUxIGV4aXN0ZSB1bSByZWxhdFxcdTAwZjNyaW8gY29tIG8gdGVtYSAmI3gyNztBbG1vY28mI3gyNzssIHRpcG8gJiN4Mjc7Q1NWJiN4Mjc7IHBhcmEgbyBEaWEgQWJlcnRvIGFzc29jaWFkbyBwb3IgZXN0ZSBhdXRvci48L2xpPjwvdWw+XCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMSw0MCxcIjx1bCBjbGFzcz1cXFwiZXJyb3JsaXN0XFxcIj48bGk+SlxcdTAwZTEgZXhpc3RlIHVtIHJlbGF0XFx1MDBmM3JpbyBjb20gbyB0ZW1hICYjeDI3O0FsbW9jbyYjeDI3OywgdGlwbyAmI3gyNztDU1YmI3gyNzsgcGFyYSBvIERpYSBBYmVydG8gYXNzb2NpYWRvIHBvciBlc3RlIGF1dG9yLjwvbGk+PC91bD5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwxLDQwLFwiPHVsIGNsYXNzPVxcXCJlcnJvcmxpc3RcXFwiPjxsaT5KXFx1MDBlMSBleGlzdGUgdW0gcmVsYXRcXHUwMGYzcmlvIGNvbSBvIHRlbWEgJiN4Mjc7QWxtb2NvJiN4Mjc7LCB0aXBvICYjeDI3O0NTViYjeDI3OyBwYXJhIG8gRGlhIEFiZXJ0byBhc3NvY2lhZG8gcG9yIGVzdGUgYXV0b3IuPC9saT48L3VsPlwiXV0ifQ==', '2024-04-30 18:34:29.757949'),
('k9jr3q0w5p0l0yeqhasxgp3mgcnoa4xl', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-29 17:19:12.180961'),
('llwh7pjpxg2fs49stogi4ox4y7cpqkru', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-29 17:21:04.829102'),
('m2v4h3u6c758ebuucddqjyqgl14y3x9x', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-29 17:18:36.799663'),
('p1i1fwomaqpwhmg83aug4n28hay83jw8', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2023-11-01 10:16:56.766680'),
('p7djq2zbxria1ouq32xvcjjis65y3cd1', 'NTNiZDQ0NDFkYmI0MDkyZDRjMTViNWZlNzMzYzhjZDk3MGIzYWRiYTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDcxYjg5Y2UxYmZlZTJmMWFlZmIxNzM3YTNkMDg5NGRmYmVkN2FjNyJ9', '2024-04-24 13:38:55.640808'),
('pcm9l156d1eocrhii51jyda508ygw3em', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2023-04-17 16:34:41.734953'),
('q0sgymm07dxeq13rwpir9synzu4a3c8o', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2023-05-04 13:56:34.371770'),
('qgvl6vrzbm8m20ye1emc7y6p8deoibq1', '.eJxVjEEOwiAQRe_C2hBgaAGX7j0DgWFGqoYmpV0Z765NutDtf-_9l4hpW2vcOi1xKuIstDj9bjnhg9oOyj212yxxbusyZbkr8qBdXudCz8vh_h3U1Ou3BgDlNWvldCFLXisOjhALIQOP44A5MxuvAhowNmfLJjir0uDB-GTF-wPjtzfO:1rkRwC:VF0pEVKfohwLHe-7da-vErmizU6uLxRQFvMXHxKjb6o', '2024-03-27 16:58:44.712516'),
('qxq4kdxtu18i3tm8f5cyqzhg7i1j61ab', 'MzM5ODllNDZiNGYzYjVjZjQ4MjQ3YzMzNDJlMDczMWMxMjM4NDc1Mzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ZmViMzg1M2VhYzliZjkwN2Q0MDRiODQ1ZmFiNWM0MjExMDQyOCJ9', '2024-03-26 17:13:31.156148'),
('rdxi43aa30z2nl8zhxi26o9pjdy0oe3l', 'YmY5YmMwYTExNjU3NzcwYTU0MTAwMmUzODRlNWJkZWU0M2U5NjJhZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZjZmMjU1NDZkYTg4ZjI5NGRhNDkzYzRiMzNhNGJjNjliYmQ4Y2JlIn0=', '2020-07-23 09:47:31.544377'),
('rhpjhoayrot9g5n3bausr9wmm311jgr7', 'NDA0YTAzZDg4Mzg4YzBkOThlNjIzNmM5NzQ5YmU3MmE1ZGRkNmVhMDp7Il9hdXRoX3VzZXJfaWQiOiIxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzFlMTg0ODFmYzlhODY0ZTUxMjkwYmIxNmRjZTdiNTcxZTRiMzFmMCIsIndpemFyZF9jcmlhcl9pbnNjcmljYW8iOnsic3RlcCI6ImluZm8iLCJzdGVwX2RhdGEiOnt9LCJzdGVwX2ZpbGVzIjp7fSwiZXh0cmFfZGF0YSI6e319fQ==', '2021-05-19 14:14:36.647300'),
('sh0y6x2yn7hrxftz5288s9m6x3ufoawy', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-29 17:20:41.990636'),
('so14fnqckknmvdtnofrc6zu7gdsp6zbd', 'NTFiZjg5MjY4ZTU3ZWEzNjg4ZTg1NDA0YzEyMjNkM2IxZTBjNDBkYTp7Il9hdXRoX3VzZXJfaWQiOiIzNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMGUwNjAzNDUwNmEwYjNhMTAyMmYyOGI4NjYwYjU4MzEzZTljMmIxNyJ9', '2022-03-29 16:22:10.544734'),
('sqtsv7pd5lm8orml9abdp1bgjk9v8qx1', 'MmUzMTA3OTZiYTQ3NTUwMmQ1YWM3Y2I5YjFkYjI4NWQzODNiZTcyYTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODhlMGNkNWM2YmQ0OTNhMTY1YzAyNzUyOTg0NTRhOGQyODM3NWM0NyJ9', '2024-03-29 12:16:44.592858'),
('uynj3dngzdjh0mul353fsmujd6z3c3zy', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2022-05-13 16:12:24.610675'),
('wekq299jz9rrl6ttrd50o5dgtbpd2wro', 'YmY5YmMwYTExNjU3NzcwYTU0MTAwMmUzODRlNWJkZWU0M2U5NjJhZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZjZmMjU1NDZkYTg4ZjI5NGRhNDkzYzRiMzNhNGJjNjliYmQ4Y2JlIn0=', '2021-03-15 16:04:23.332253'),
('wr2vzm4panz54k78pbzdd7vi8ef8eg8e', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2021-05-19 13:46:49.474672'),
('ximypcdxw9htmcl5y2re1nil45c7gtmy', '.eJxVjMEOwiAQRP-FsyELpSgevfsNzcLuStVAUtqT8d-VpAe9zGHem3mpCbc1T1vjZZpJnZUz6vBbRkwPLp3QHcut6lTLusxRd0XvtOlrJX5edvfvIGPLfU0eIB0JgxmFEjCyjw6tRcCQTEB3YrGjNULoPHgYophvgAwCLoJ6fwArWTiR:1rsNGZ:X-RwlNuYjyAnQMu67_sjw4rTFzvyecTyse1yUeI4Cc4', '2024-04-18 13:36:31.718224'),
('xogklv1cyuprdm9l58obaifhx0l97n4c', 'Mzk1NmYxMTdhNGU1NjI0NGJkZTZkZTkzNTQyMWMzNjU1YmMzNWUwOTp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjFkZjNjNGFmOTZhNjMxZTVmYTAyNzYwN2M3ZThhNjQ0MGM2N2U2MSJ9', '2024-04-28 16:46:25.365165'),
('xup647lftm29lhmdye872rhb1ctfs6et', 'MzM5ODllNDZiNGYzYjVjZjQ4MjQ3YzMzNDJlMDczMWMxMjM4NDc1Mzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ZmViMzg1M2VhYzliZjkwN2Q0MDRiODQ1ZmFiNWM0MjExMDQyOCJ9', '2024-03-26 16:26:57.491397'),
('y0ve9utm7tupoitj7mm7md0vthkzpvja', 'ZmEyYWE5YjI0ZWQyMzY4OWExMGFhOTk5MGE5MWE5ZTBkY2QxY2JhMjp7Il9hdXRoX3VzZXJfaWQiOiIyOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzNjNmRlOGE1MTU4NmJhZGMyOGRkMjNhNTc1ZDMwYzRmMDAxMzExNCJ9', '2022-03-17 15:55:57.467222'),
('y9mlx4x3p7qewmn6qse1v2abimjoxhu2', 'ZWZhMDgyNDhlYzRjNzFjMjczNjZlMmY2NGFkZmViYjA1NThiZTdkYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZDhkNDM0NzNiZTkzMzM5NjQzMDBlZTA1ODc4MGJlOWQyNDEyNmU3In0=', '2023-11-27 12:06:43.192626'),
('zf23c691bbp1f7mtfuuju0hcy2dzj2ro', 'MzM5ODllNDZiNGYzYjVjZjQ4MjQ3YzMzNDJlMDczMWMxMjM4NDc1Mzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ZmViMzg1M2VhYzliZjkwN2Q0MDRiODQ1ZmFiNWM0MjExMDQyOCJ9', '2024-03-26 16:40:52.055889');

-- --------------------------------------------------------

--
-- Estrutura para tabela `edificio`
--

CREATE TABLE `edificio` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(64) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `Campus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `edificio`
--

INSERT INTO `edificio` (`ID`, `Nome`, `image`, `Campus`) VALUES
(3, 'Escola Superior de Educação e Comunicação', '', 1),
(4, 'Edifício 8', '', 2),
(5, 'Edificio 2', '', 2),
(6, 'Edifício 7', '', 2),
(7, 'HORTO', '', 2),
(8, 'Edificio 1', '', 2),
(9, 'Exterior', '', 2),
(10, 'Edifício 1', '', 2),
(11, 'Edifício 4 - CP', '', 2),
(12, 'Artes Visuais', '', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `escola`
--

CREATE TABLE `escola` (
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `local` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `escola`
--

INSERT INTO `escola` (`id`, `nome`, `local`) VALUES
(1, 'ww', 'Faro'),
(2, '33', 'Faro'),
(3, 'teste', 'Faro'),
(4, 'Faro', 'Faro');

-- --------------------------------------------------------

--
-- Estrutura para tabela `espaco`
--

CREATE TABLE `espaco` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Andar` varchar(255) NOT NULL,
  `Descricao` varchar(255) DEFAULT NULL,
  `Edificio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `espaco`
--

INSERT INTO `espaco` (`ID`, `Nome`, `Andar`, `Descricao`, `Edificio`) VALUES
(6, 'Sala 31', '0', NULL, 3),
(7, 'Sala 40', '', NULL, 3),
(8, 'Corredor da sala', '', NULL, 3),
(9, 'Hall da sala 40', '', NULL, 3),
(10, 'Sala 41', '', NULL, 3),
(11, 'Sala 62', '', NULL, 3),
(12, 'Sala 63', '', NULL, 3),
(13, 'Sala 63A', '', NULL, 3),
(14, 'Sala 95', '', NULL, 3),
(15, 'Sala 96', '', NULL, 3),
(16, 'Sala 97', '', NULL, 3),
(17, 'Sala 98', '', NULL, 3),
(18, 'Sala 99', '', NULL, 3),
(19, 'Átrio (98/99)', '', NULL, 3),
(20, 'Sala 105', '', NULL, 3),
(21, 'Sala UP', '', NULL, 3),
(22, 'Átrio 1.º andar', '', NULL, 3),
(23, 'Corredor 1º and', '', NULL, 3),
(24, 'Lab. C. Desporto', '', 'Laboratório de Ciências do Desporto', 3),
(25, 'Ginásio', '', NULL, 3),
(26, 'Espaço Mostra', '', NULL, 3),
(27, 'Auditório', '', 'Auditório Paulo Freire', 3),
(28, 'Sala 22', '', NULL, 3),
(29, 'Hall de entrada', '1', 'Entrada', 4),
(30, 'Hall de entrada', '0', 'Perto da estátua em frente da escadaria. Em frente da biblioteca', 5),
(31, 'Hall de entrada norte', '1', 'Entrada', 6),
(32, 'Entrada', '0', 'Entrada', 7),
(33, '1.53', '1', 'Sala de Informática', 8),
(34, 'Exterior do Edificio 7', '1', 'Junto à entrada norte', 9),
(35, 'Sala 0.20', '-1', NULL, 10),
(36, 'Sala 0.21', '', NULL, 10),
(37, 'Sala 0.22', '', NULL, 10),
(38, 'Sala 0.23', '', NULL, 10),
(39, 'Sala 0.35', '', NULL, 10),
(40, 'Sala 1.1', '', NULL, 10),
(41, 'Sala 1.2', '', NULL, 10),
(42, 'Sala 1.36', '', NULL, 10),
(43, 'Sala 1.37', '', NULL, 10),
(44, 'Sala 1.56', '', NULL, 10),
(45, 'Sala 1.6', '', NULL, 10),
(46, 'Sala 1.7', '', NULL, 10),
(47, 'Sala 1.8', '', NULL, 10),
(48, 'Sala 2.1', '', NULL, 10),
(49, 'Sala 2.2', '', NULL, 10),
(50, 'Sala 2.37', '', NULL, 10),
(51, 'Sala 2.4', '', NULL, 10),
(52, 'Sala 2.5', '', NULL, 10),
(53, 'Sala 2.6', '', NULL, 10),
(54, 'Sala 2.7', '', NULL, 10),
(55, 'Sala 2.8', '', NULL, 10),
(56, 'Lab. Arqueologia', '', NULL, 10),
(57, 'Sala de Espelhos', '', NULL, 10),
(58, 'Anfiteatro A', '1', NULL, 11),
(59, 'Anfiteatro B', '', NULL, 11),
(60, 'Anfiteatro C', '', NULL, 11),
(61, 'Anfiteatro D', '', NULL, 11),
(62, 'Anfiteatro E', '', NULL, 11),
(63, 'Anfiteatro F', '', NULL, 11),
(64, 'Edifício das Oficinas (ST)', '0', NULL, 12),
(65, 'Sala 1.4', '', NULL, 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `estado_questionario`
--

CREATE TABLE `estado_questionario` (
  `id` varchar(3) NOT NULL,
  `nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `estado_questionario`
--

INSERT INTO `estado_questionario` (`id`, `nome`) VALUES
('arq', 'arquivado'),
('dis', 'disponivel'),
('ind', 'indisponivel'),
('pen', 'pendente'),
('pub', 'publicado');

-- --------------------------------------------------------

--
-- Estrutura para tabela `horario`
--

CREATE TABLE `horario` (
  `ID` int(11) NOT NULL,
  `Inicio` time(6) NOT NULL,
  `Fim` time(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `horario`
--

INSERT INTO `horario` (`ID`, `Inicio`, `Fim`) VALUES
(1, '12:00:00.000000', '14:00:00.000000'),
(2, '09:30:00.000000', '09:50:00.000000'),
(3, '10:30:00.000000', '10:50:00.000000'),
(4, '11:30:00.000000', '11:50:00.000000'),
(5, '14:30:00.000000', '14:50:00.000000'),
(6, '16:30:00.000000', '16:50:00.000000'),
(7, '09:00:00.000000', '09:05:00.000000'),
(8, '15:00:00.000000', '15:05:00.000000'),
(9, '09:10:00.000000', '09:15:00.000000'),
(10, '09:20:00.000000', '09:25:00.000000'),
(11, '09:30:00.000000', '09:35:00.000000'),
(12, '10:00:00.000000', '10:05:00.000000'),
(13, '11:00:00.000000', '11:05:00.000000'),
(14, '10:00:00.000000', '11:00:00.000000'),
(15, '14:00:00.000000', '14:05:00.000000'),
(16, '14:00:00.000000', '15:00:00.000000'),
(17, '14:00:00.000000', '20:00:00.000000'),
(18, '10:00:00.000000', '16:00:00.000000'),
(19, '10:00:00.000000', '13:00:00.000000'),
(20, '14:30:00.000000', '17:30:00.000000'),
(21, '10:00:00.000000', '12:30:00.000000'),
(22, '14:30:00.000000', '17:00:00.000000'),
(23, '10:00:00.000000', '12:00:00.000000'),
(24, '14:30:00.000000', '16:00:00.000000'),
(25, '17:30:00.000000', '18:00:00.000000'),
(26, '15:30:00.000000', '16:00:00.000000'),
(27, '11:00:00.000000', '13:30:00.000000'),
(28, '14:30:00.000000', '15:00:00.000000'),
(29, '14:30:00.000000', '15:30:00.000000');

-- --------------------------------------------------------

--
-- Estrutura para tabela `idioma`
--

CREATE TABLE `idioma` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `Sigla` varchar(255) DEFAULT NULL,
  `DiaAbertoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `informacaomensagem`
--

CREATE TABLE `informacaomensagem` (
  `id` int(11) NOT NULL,
  `data` datetime(6) NOT NULL,
  `pendente` tinyint(1) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `lido` tinyint(1) NOT NULL,
  `emissorid` int(11) DEFAULT NULL,
  `recetorid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `informacaomensagem`
--

INSERT INTO `informacaomensagem` (`id`, `data`, `pendente`, `titulo`, `descricao`, `tipo`, `lido`, `emissorid`, `recetorid`) VALUES
(11, '2022-04-29 14:51:21.897893', 0, 'ver email', 'dia aberto', 'Individual', 1, 1, 26),
(12, '2023-04-20 14:22:07.225906', 1, 'fe', 'fdefdef', 'Grupo de administradores do dia aberto', 0, 1, 1),
(13, '2023-04-20 14:22:07.304034', 1, 'fe', 'fdefdef', 'Grupo de administradores do dia aberto', 0, 1, 23),
(14, '2023-04-20 14:24:19.405685', 1, 'aa', 'aa', 'Grupo de administradores do dia aberto', 0, 1, 1),
(15, '2023-04-20 14:24:19.421295', 1, 'aa', 'aa', 'Grupo de administradores do dia aberto', 0, 1, 23);

-- --------------------------------------------------------

--
-- Estrutura para tabela `informacaonotificacao`
--

CREATE TABLE `informacaonotificacao` (
  `id` int(11) NOT NULL,
  `data` datetime(6) NOT NULL,
  `pendente` tinyint(1) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `lido` tinyint(1) NOT NULL,
  `emissorid` int(11) DEFAULT NULL,
  `recetorid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `informacaonotificacao`
--

INSERT INTO `informacaonotificacao` (`id`, `data`, `pendente`, `titulo`, `descricao`, `tipo`, `lido`, `emissorid`, `recetorid`) VALUES
(46, '2022-03-03 10:23:20.762274', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 28', 0, 28, 28),
(62, '2022-03-07 16:10:57.568869', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 32', 0, 32, 32),
(74, '2022-03-12 12:12:17.096803', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 34', 0, 34, 34),
(79, '2022-03-20 16:03:55.139438', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 36', 0, 36, 36),
(82, '2022-03-20 16:12:53.977966', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 37', 0, 37, 36),
(83, '2022-03-20 18:29:03.772965', 1, 'Existem atividades por validar', 'Foram criadas propostas de atividades que têm de ser validadas.', 'atividade 21', 0, 37, 36),
(86, '2023-05-23 16:13:25.640111', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 39', 0, 39, 23),
(87, '2023-05-23 16:13:25.671367', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 39', 0, 39, 31),
(88, '2024-03-13 11:58:00.379129', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 41', 0, 41, 1),
(89, '2024-03-13 11:58:00.382859', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 41', 0, 41, 23),
(91, '2024-03-17 16:02:35.760045', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 44', 0, 44, 1),
(92, '2024-03-17 16:02:35.762496', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 44', 0, 44, 23),
(94, '2024-03-17 16:02:35.765734', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 44', 0, 44, 44),
(95, '2024-04-13 16:13:36.151911', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 46', 0, 46, 23),
(97, '2024-04-13 16:13:36.157825', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 46', 0, 46, 44),
(98, '2024-04-13 16:13:36.171810', 1, 'Validação de registos de utilizadores pendentes', 'Foram feitos registos de utilizadores na plataforma que necessitam de ser validados.', 'register 46', 0, 46, 31);

-- --------------------------------------------------------

--
-- Estrutura para tabela `inscricao`
--

CREATE TABLE `inscricao` (
  `id` int(11) NOT NULL,
  `individual` tinyint(1) NOT NULL,
  `nalunos` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `turma` varchar(1) DEFAULT NULL,
  `areacientifica` varchar(64) DEFAULT NULL,
  `dia` date NOT NULL,
  `meio_transporte` varchar(40) NOT NULL,
  `hora_chegada` time(6) DEFAULT NULL,
  `local_chegada` varchar(200) DEFAULT NULL,
  `entrecampi` tinyint(1) NOT NULL,
  `diaaberto_id` int(11) NOT NULL,
  `escola_id` int(11) NOT NULL,
  `participante_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inscricao`
--

INSERT INTO `inscricao` (`id`, `individual`, `nalunos`, `ano`, `turma`, `areacientifica`, `dia`, `meio_transporte`, `hora_chegada`, `local_chegada`, `entrecampi`, `diaaberto_id`, `escola_id`, `participante_id`) VALUES
(3, 0, 30, 9, 'g', 'geral', '2022-05-03', 'comboio', '09:00:00.000000', 'Terminal', 1, 3, 3, 33),
(4, 0, 18, 11, 'h', 'geral', '2022-05-03', 'comboio', '10:00:00.000000', 'Estação de Comboios de Faro', 1, 3, 4, 33),
(6, 0, 2, 11, 'h', 'geral', '2022-05-03', 'comboio', '10:00:00.000000', 'Estação de Comboios de Faro', 1, 5, 4, 33);

-- --------------------------------------------------------

--
-- Estrutura para tabela `inscricaoprato`
--

CREATE TABLE `inscricaoprato` (
  `id` int(11) NOT NULL,
  `npratosalunos` int(11) NOT NULL,
  `npratosdocentes` int(11) NOT NULL,
  `campus_id` int(11) NOT NULL,
  `inscricao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inscricaoprato`
--

INSERT INTO `inscricaoprato` (`id`, `npratosalunos`, `npratosdocentes`, `campus_id`, `inscricao_id`) VALUES
(1, 6, 1, 1, 3),
(2, 4, 1, 2, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `inscricaosessao`
--

CREATE TABLE `inscricaosessao` (
  `id` int(11) NOT NULL,
  `nparticipantes` int(11) NOT NULL,
  `inscricao_id` int(11) NOT NULL,
  `sessao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inscricaosessao`
--

INSERT INTO `inscricaosessao` (`id`, `nparticipantes`, `inscricao_id`, `sessao_id`) VALUES
(4, 4, 3, 19),
(5, 4, 3, 32),
(6, 1, 4, 34);

-- --------------------------------------------------------

--
-- Estrutura para tabela `inscricaotransporte`
--

CREATE TABLE `inscricaotransporte` (
  `id` int(11) NOT NULL,
  `npassageiros` int(11) NOT NULL,
  `inscricao_id` int(11) NOT NULL,
  `transporte_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `inscricaotransporte`
--

INSERT INTO `inscricaotransporte` (`id`, `npassageiros`, `inscricao_id`, `transporte_id`) VALUES
(1, 30, 3, 10),
(2, 30, 3, 24);

-- --------------------------------------------------------

--
-- Estrutura para tabela `materiais`
--

CREATE TABLE `materiais` (
  `ID` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `AtividadeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `materiais`
--

INSERT INTO `materiais` (`ID`, `nome`, `AtividadeID`) VALUES
(7, NULL, 7),
(8, NULL, 8),
(10, 'Projetor, 16 telemóveis', 10),
(11, 'Projetores', 11),
(12, 'Projetores', 12),
(13, NULL, 13),
(14, NULL, 14),
(15, NULL, 15),
(16, NULL, 16),
(17, NULL, 17),
(18, NULL, 18),
(19, NULL, 19),
(21, NULL, 21),
(22, NULL, 22);

-- --------------------------------------------------------

--
-- Estrutura para tabela `mensagemenviada`
--

CREATE TABLE `mensagemenviada` (
  `id` int(11) NOT NULL,
  `mensagem_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mensagemenviada`
--

INSERT INTO `mensagemenviada` (`id`, `mensagem_id`) VALUES
(5, 11),
(6, 13),
(7, 15);

-- --------------------------------------------------------

--
-- Estrutura para tabela `mensagemrecebida`
--

CREATE TABLE `mensagemrecebida` (
  `id` int(11) NOT NULL,
  `mensagem_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mensagemrecebida`
--

INSERT INTO `mensagemrecebida` (`id`, `mensagem_id`) VALUES
(11, 11),
(12, 13),
(13, 15);

-- --------------------------------------------------------

--
-- Estrutura para tabela `menu`
--

CREATE TABLE `menu` (
  `ID` int(11) NOT NULL,
  `Dia` date NOT NULL,
  `Campus` int(11) NOT NULL,
  `diaAberto` int(11) NOT NULL,
  `HorarioID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `menu`
--

INSERT INTO `menu` (`ID`, `Dia`, `Campus`, `diaAberto`, `HorarioID`) VALUES
(1, '2022-05-03', 1, 3, 1),
(2, '2022-05-04', 1, 3, 1),
(3, '2022-05-03', 2, 3, 1),
(4, '2022-05-04', 2, 3, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `notificacao`
--

CREATE TABLE `notificacao` (
  `id` int(11) NOT NULL,
  `level` varchar(20) NOT NULL,
  `unread` tinyint(1) NOT NULL,
  `actor_object_id` varchar(255) NOT NULL,
  `verb` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `target_object_id` varchar(255) DEFAULT NULL,
  `action_object_object_id` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `public` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `emailed` tinyint(1) NOT NULL,
  `data` longtext DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `action_object_content_type_id` int(11) DEFAULT NULL,
  `actor_content_type_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `target_content_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `notificacao`
--

INSERT INTO `notificacao` (`id`, `level`, `unread`, `actor_object_id`, `verb`, `description`, `target_object_id`, `action_object_object_id`, `timestamp`, `public`, `deleted`, `emailed`, `data`, `titulo`, `descricao`, `tipo`, `action_object_content_type_id`, `actor_content_type_id`, `recipient_id`, `target_content_type_id`) VALUES
(18, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Desafios nos Laboratórios de Química e Ciências Farmacêuticas\"', 'Foi alterada uma atividade', '8', NULL, '2022-02-28 15:57:55.004061', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(19, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Desafios nos Laboratórios de Química e Ciências Farmacêuticas\"', 'Foi alterada uma atividade', '8', NULL, '2022-02-28 16:36:59.327451', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(20, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Desafios nos Laboratórios de Química e Ciências Farmacêuticas\"', 'Foi alterada uma atividade', '8', NULL, '2022-03-01 22:55:56.018713', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(21, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Desafios nos Laboratórios de Química e Ciências Farmacêuticas\"', 'Foi alterada uma atividade', '8', NULL, '2022-03-01 23:04:53.438530', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(22, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:12:29.854447', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(23, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:17:26.150974', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(24, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:17:40.339523', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(25, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"As 20 000 léguas subterrâneas\"', 'Foi alterada uma atividade', '15', NULL, '2022-03-03 11:28:55.054810', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(26, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:29:13.676012', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(27, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:29:50.905650', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(28, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:44:39.808962', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(29, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Ciências do Mar: organismos, ambientes e investigadores\"', 'Foi alterada uma atividade', '17', NULL, '2022-03-03 11:44:54.803485', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(30, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 11:57:02.822864', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(31, 'success', 0, '31', 'A sua proposta de atividade \"Tecnologia na nossa vida\" foi aceite.', 'Confirmação da atividade proposta', '10', NULL, '2022-03-03 12:02:03.306142', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(32, 'success', 0, '31', 'A sua proposta de atividade \"Matemática para sempre\" foi aceite.', 'Confirmação da atividade proposta', '11', NULL, '2022-03-03 12:02:11.137080', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(33, 'success', 0, '31', 'A sua proposta de atividade \"Física e Matemática, ontem e hoje\" foi aceite.', 'Confirmação da atividade proposta', '12', NULL, '2022-03-03 12:02:16.881882', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(34, 'success', 0, '31', 'A sua proposta de atividade \"Desafios nos Laboratórios de Química e Ciências Farmacêuticas\" foi aceite.', 'Confirmação da atividade proposta', '8', NULL, '2022-03-03 12:02:27.096099', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(35, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Da célula aos implantes artificiais: ciências e tecnologias\"', 'Foi alterada uma atividade', '19', NULL, '2022-03-03 12:07:23.638074', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(36, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Fases do ciclo de vida de animais marinhos\"', 'Foi alterada uma atividade', '18', NULL, '2022-03-03 12:07:47.566053', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(37, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Ciências do Mar: organismos, ambientes e investigadores\"', 'Foi alterada uma atividade', '17', NULL, '2022-03-03 12:08:18.091626', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(38, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Métodos em Ciências do Mar\"', 'Foi alterada uma atividade', '16', NULL, '2022-03-03 12:08:38.004596', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(39, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"As 20 000 léguas subterrâneas\"', 'Foi alterada uma atividade', '15', NULL, '2022-03-03 12:09:10.083593', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(40, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"O cultivo das plantas: the sky is the limit!\"', 'Foi alterada uma atividade', '14', NULL, '2022-03-03 12:09:36.818104', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(41, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"SOS URBAN: espaços verdes sustentáveis\"', 'Foi alterada uma atividade', '13', NULL, '2022-03-03 12:10:04.309304', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(42, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 12:10:30.972505', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(43, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Ciências do Mar: organismos, ambientes e investigadores\"', 'Foi alterada uma atividade', '17', NULL, '2022-03-03 12:10:48.698634', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(44, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 12:11:37.934701', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(45, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"SOS URBAN: espaços verdes sustentáveis\"', 'Foi alterada uma atividade', '13', NULL, '2022-03-03 12:12:07.782495', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(46, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"O cultivo das plantas: the sky is the limit!\"', 'Foi alterada uma atividade', '14', NULL, '2022-03-03 12:12:32.739852', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(47, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Métodos em Ciências do Mar\"', 'Foi alterada uma atividade', '16', NULL, '2022-03-03 12:13:05.269911', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(48, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Recursos Naturais e Biotecnologia\"', 'Foi alterada uma atividade', '7', NULL, '2022-03-03 12:13:25.050100', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(49, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"O cultivo das plantas: the sky is the limit!\"', 'Foi alterada uma atividade', '14', NULL, '2022-03-03 12:13:49.795646', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(50, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Métodos em Ciências do Mar\"', 'Foi alterada uma atividade', '16', NULL, '2022-03-03 12:14:03.077212', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(51, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Ciências do Mar: organismos, ambientes e investigadores\"', 'Foi alterada uma atividade', '17', NULL, '2022-03-03 12:14:27.896320', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(52, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Fases do ciclo de vida de animais marinhos\"', 'Foi alterada uma atividade', '18', NULL, '2022-03-03 12:14:43.247827', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(53, 'warning', 1, '25', 'Foi feita uma alteração na atividade \"Da célula aos implantes artificiais: ciências e tecnologias\"', 'Foi alterada uma atividade', '19', NULL, '2022-03-03 12:14:57.522582', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(54, 'success', 1, '31', 'A sua proposta de atividade \"Da célula aos implantes artificiais: ciências e tecnologias\" foi aceite.', 'Confirmação da atividade proposta', '19', NULL, '2022-03-03 12:18:12.782010', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(55, 'success', 1, '31', 'A sua proposta de atividade \"Fases do ciclo de vida de animais marinhos\" foi aceite.', 'Confirmação da atividade proposta', '18', NULL, '2022-03-03 12:18:19.172414', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(56, 'success', 1, '31', 'A sua proposta de atividade \"Ciências do Mar: organismos, ambientes e investigadores\" foi aceite.', 'Confirmação da atividade proposta', '17', NULL, '2022-03-03 12:18:26.961240', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(57, 'success', 1, '31', 'A sua proposta de atividade \"Métodos em Ciências do Mar\" foi aceite.', 'Confirmação da atividade proposta', '16', NULL, '2022-03-03 12:18:32.858560', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(58, 'success', 1, '31', 'A sua proposta de atividade \"As 20 000 léguas subterrâneas\" foi aceite.', 'Confirmação da atividade proposta', '15', NULL, '2022-03-03 12:18:40.041332', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(59, 'success', 1, '31', 'A sua proposta de atividade \"O cultivo das plantas: the sky is the limit!\" foi aceite.', 'Confirmação da atividade proposta', '14', NULL, '2022-03-03 12:18:49.915707', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(60, 'success', 1, '31', 'A sua proposta de atividade \"SOS URBAN: espaços verdes sustentáveis\" foi aceite.', 'Confirmação da atividade proposta', '13', NULL, '2022-03-03 12:18:57.127518', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(61, 'success', 1, '31', 'A sua proposta de atividade \"Recursos Naturais e Biotecnologia\" foi aceite.', 'Confirmação da atividade proposta', '7', NULL, '2022-03-03 12:19:50.159759', 0, 0, 0, NULL, '', '', '', NULL, 3, 25, 7),
(62, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Matemática para sempre\"', 'Foi alterada uma atividade', '11', NULL, '2022-03-10 18:52:37.829934', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(63, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Física e Matemática, ontem e hoje\"', 'Foi alterada uma atividade', '12', NULL, '2022-03-10 18:55:15.674924', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(64, 'success', 0, '31', 'A sua proposta de atividade \"Física e Matemática, ontem e hoje\" foi aceite.', 'Confirmação da atividade proposta', '12', NULL, '2022-03-10 18:55:55.243019', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(65, 'success', 0, '31', 'A sua proposta de atividade \"Matemática para sempre\" foi aceite.', 'Confirmação da atividade proposta', '11', NULL, '2022-03-10 18:56:02.216542', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(66, 'success', 0, '31', 'A sua proposta de atividade \"Física e Matemática, ontem e hoje\" foi aceite.', 'Confirmação da atividade proposta', '12', NULL, '2022-03-15 15:54:42.573222', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(67, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Física e Matemática, ontem e hoje\"', 'Foi alterada uma atividade', '12', NULL, '2022-03-15 16:15:16.534485', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(68, 'success', 0, '31', 'A sua proposta de atividade \"Física e Matemática, ontem e hoje\" foi aceite.', 'Confirmação da atividade proposta', '12', NULL, '2022-03-15 16:16:44.564607', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(69, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Física e Matemática, ontem e hoje\"', 'Foi alterada uma atividade', '12', NULL, '2023-04-19 09:19:06.230056', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(70, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Tecnologia na nossa vida\"', 'Foi alterada uma atividade', '10', NULL, '2023-04-19 09:20:51.437348', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(71, 'success', 1, '31', 'A sua proposta de atividade \"Física e Matemática, ontem e hoje\" foi aceite.', 'Confirmação da atividade proposta', '12', NULL, '2023-04-19 09:21:19.078054', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(72, 'success', 1, '31', 'A sua proposta de atividade \"Tecnologia na nossa vida\" foi aceite.', 'Confirmação da atividade proposta', '10', NULL, '2023-04-19 09:21:27.867533', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(73, 'error', 1, '31', 'A sua proposta de atividade Teste foi rejeitada.', 'Rejeição da atividade proposta', '22', NULL, '2023-04-19 09:32:41.044468', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(74, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Tecnologia na nossa vida\"', 'Foi alterada uma atividade', '10', NULL, '2023-04-19 09:33:50.083782', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(75, 'warning', 1, '26', 'Foi feita uma alteração na atividade \"Teste\"', 'Foi alterada uma atividade', '22', NULL, '2023-04-19 09:34:00.825063', 0, 0, 0, NULL, '', '', '', NULL, 3, 31, 7),
(76, 'success', 1, '31', 'A sua proposta de atividade \"Teste\" foi aceite.', 'Confirmação da atividade proposta', '22', NULL, '2023-04-19 09:34:20.952367', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7),
(77, 'success', 1, '31', 'A sua proposta de atividade \"Tecnologia na nossa vida\" foi aceite.', 'Confirmação da atividade proposta', '10', NULL, '2023-04-19 09:34:31.772402', 0, 0, 0, NULL, '', '', '', NULL, 3, 26, 7);

-- --------------------------------------------------------

--
-- Estrutura para tabela `opcoes_pergunta`
--

CREATE TABLE `opcoes_pergunta` (
  `id` int(11) NOT NULL,
  `texto_opcao` varchar(255) NOT NULL,
  `pergunta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `opcoes_pergunta`
--

INSERT INTO `opcoes_pergunta` (`id`, `texto_opcao`, `pergunta_id`) VALUES
(1, '1', 2),
(2, '2', 2),
(3, '3', 2),
(4, '4', 2),
(9, '10', 6),
(10, '20', 6),
(11, '30', 6),
(16, 'carne', 11),
(17, 'peixe', 11),
(18, 'vegetariano', 11),
(89, 'sim', 50),
(90, ' nao', 50),
(91, '1', 51),
(92, '2', 51),
(93, 'sim', 52),
(94, 'nao', 52),
(95, 'sim', 54),
(96, 'nao', 54),
(97, 'talvez', 54),
(98, 'sim, foi', 55),
(99, 'nao, nao foi necessario', 55),
(100, 'nao sei', 55),
(101, 'sim', 56),
(102, 'nao', 56),
(103, 'talvez', 56),
(104, 'sim, chegou', 57),
(105, 'nao, demorou', 57),
(106, 'nao sei responder', 57),
(107, 'sumo', 58),
(108, 'agua', 58),
(109, 'vodka', 58),
(110, 'misto quente', 59),
(111, 'arroz', 59),
(112, 'bife', 59),
(113, '1', 60),
(114, '2', 60),
(115, '3', 60),
(116, 'sumo', 62),
(117, 'agua', 62),
(118, 'vodka', 62);

-- --------------------------------------------------------

--
-- Estrutura para tabela `participante`
--

CREATE TABLE `participante` (
  `utilizador_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `participante`
--

INSERT INTO `participante` (`utilizador_ptr_id`) VALUES
(33),
(38),
(40),
(47);

-- --------------------------------------------------------

--
-- Estrutura para tabela `perguntas`
--

CREATE TABLE `perguntas` (
  `id` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `tipo_resposta` varchar(20) NOT NULL,
  `questionario_id` int(11) NOT NULL,
  `tema_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `perguntas`
--

INSERT INTO `perguntas` (`id`, `texto`, `tipo_resposta`, `questionario_id`, `tema_id`) VALUES
(1, 'TTTTTTTTT', 'texto_livre', 1, 1),
(2, 'Qnts bananas comeu?', 'multipla_escolha', 1, 1),
(5, 'Quantos almocos por dia?', 'inteiro', 3, 1),
(6, 'Quais os horarios que passam o autocarro?', 'multipla_escolha', 3, 2),
(9, 'Quantos almocos por dia?', 'texto_livre', 5, 1),
(10, 'Quantos transportes por dia?', 'texto_livre', 5, 2),
(11, 'quais sao os almocos hj??', 'multipla_escolha', 6, 1),
(12, 'oque é almoco?', 'texto_livre', 6, 1),
(50, 'o sumo é bom?', 'multipla_escolha', 35, 1),
(51, 'I1JI1J1', 'multipla_escolha', 36, 1),
(52, 'O almoço tava bom??', 'multipla_escolha', 37, 1),
(53, 'kp foda', 'texto_livre', 38, 1),
(54, 'O almoco estava bom?', 'multipla_escolha', 39, 1),
(55, 'O transporte foi necessario?', 'multipla_escolha', 39, 2),
(56, 'O almoco estava bom?', 'multipla_escolha', 40, 1),
(57, 'o transporte chegou rapido?', 'multipla_escolha', 40, 2),
(58, 'Qual foi a bebida de hoje?', 'multipla_escolha', 41, 1),
(59, 'Qual foi a comida de hoje?', 'multipla_escolha', 41, 1),
(60, 'Quantas pessoas almoçaram hoje??', 'multipla_escolha', 42, 1),
(61, 'Como estava o almoço?', 'texto_livre', 42, 1),
(62, 'Qual era a bebida da almoço??', 'multipla_escolha', 42, 1),
(63, 'almoco', 'texto_livre', 43, 1),
(64, 'transporte', 'texto_livre', 43, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `prato`
--

CREATE TABLE `prato` (
  `ID` int(11) NOT NULL,
  `Prato` varchar(255) NOT NULL,
  `Tipo` varchar(255) NOT NULL,
  `NrPratosDisponiveis` int(11) NOT NULL,
  `MenuID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `prato`
--

INSERT INTO `prato` (`ID`, `Prato`, `Tipo`, `NrPratosDisponiveis`, `MenuID`) VALUES
(1, 'Refeição completa (prato de carne)', 'Carne', 1000, 1),
(2, 'Refeição completa (prato de peixe)', 'Peixe', 1000, 1),
(3, 'Refeição completa (vegetariana)', 'Vegetariano', 1000, 1),
(4, 'Refeição completa (prato de carne)', 'Carne', 1000, 2),
(5, 'Refeição completa (prato de peixe)', 'Peixe', 1000, 2),
(6, 'Refeição completa (vegetariana)', 'Vegetariano', 1000, 2),
(7, 'Refeição completa (prato de carne)', 'Carne', 1000, 3),
(8, 'Refeição completa (prato de peixe)', 'Peixe', 1000, 3),
(9, 'Refeição completa (vegetariana)', 'Vegetariano', 1000, 3),
(10, 'Refeição completa (prato de carne)', 'Carne', 1000, 4),
(11, 'Refeição completa (prato de peixe)', 'Peixe', 1000, 4),
(12, 'Refeição completa (vegetariana)', 'Vegetariano', 1000, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `preferencia`
--

CREATE TABLE `preferencia` (
  `ID` int(11) NOT NULL,
  `Tipo` varchar(64) NOT NULL,
  `ColaboradorUtilizadorID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `preferenciaatividade`
--

CREATE TABLE `preferenciaatividade` (
  `ID` int(11) NOT NULL,
  `Atividade` int(11) DEFAULT NULL,
  `PreferenciaID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `professoruniversitario`
--

CREATE TABLE `professoruniversitario` (
  `utilizador_ptr_id` int(11) NOT NULL,
  `Gabinete` varchar(255) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `faculdade_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `professoruniversitario`
--

INSERT INTO `professoruniversitario` (`utilizador_ptr_id`, `Gabinete`, `departamento_id`, `faculdade_id`) VALUES
(25, '3.8', 21, 6),
(26, '2.69', 21, 6),
(35, '1.32', 20, 5),
(37, 'Sala 1.46', 11, 5),
(39, '2.69', 14, 6),
(46, '999', 14, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `questionarios`
--

CREATE TABLE `questionarios` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `estado_id` varchar(3) DEFAULT NULL,
  `autor_id` int(11) NOT NULL,
  `data_publicada` date DEFAULT NULL,
  `estado_anterior_id` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `questionarios`
--

INSERT INTO `questionarios` (`ID`, `Nome`, `estado_id`, `autor_id`, `data_publicada`, `estado_anterior_id`) VALUES
(41, 'teste atual 2024', 'pub', 41, '2024-04-26', NULL),
(42, 'Validação Les', 'dis', 41, '2024-04-29', NULL),
(43, 'atividades', 'ind', 41, '2024-04-24', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `relatorios`
--

CREATE TABLE `relatorios` (
  `id` int(11) NOT NULL,
  `tema` varchar(255) NOT NULL,
  `data_exportado` date DEFAULT NULL,
  `export_type` varchar(100) NOT NULL,
  `autor_id` int(11) NOT NULL,
  `dia_aberto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `relatorios`
--

INSERT INTO `relatorios` (`id`, `tema`, `data_exportado`, `export_type`, `autor_id`, `dia_aberto_id`) VALUES
(1, 'Almoco', '2024-04-16', 'PDF', 41, 3),
(2, 'Transporte', '2024-04-16', 'CSV', 41, 3),
(3, 'Almoco', '2024-04-16', 'CSV', 41, 3),
(4, 'Transporte', '2024-04-17', 'CSV', 41, 3),
(5, 'Almoco', '2024-04-17', 'CSV', 41, 3),
(6, 'Almoco', '2024-04-17', 'PDF', 41, 3),
(7, 'Almoco', '2024-04-18', 'PDF', 41, 3),
(8, 'Almoco', '2024-04-19', 'PDF', 41, 3),
(9, 'Almoco', '2024-04-20', 'PDF', 41, 3),
(10, 'Almoco', '2024-04-21', 'PDF', 41, 3),
(11, 'Almoco', '2024-04-22', 'PDF', 41, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `responsavel`
--

CREATE TABLE `responsavel` (
  `id` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `tel` varchar(128) NOT NULL,
  `inscricao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `responsavel`
--

INSERT INTO `responsavel` (`id`, `nome`, `email`, `tel`, `inscricao_id`) VALUES
(3, 'Ivete Silva', 'info@ualg.pt', '+351963107359', 3),
(4, 'Ivete Silva', 'info@ualg.pt', '+351963107359', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `respostas`
--

CREATE TABLE `respostas` (
  `id` int(11) NOT NULL,
  `data` datetime(6) DEFAULT NULL,
  `questionario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `respostas`
--

INSERT INTO `respostas` (`id`, `data`, `questionario_id`) VALUES
(43, '2024-04-22 01:47:45.246933', 41),
(44, '2024-04-22 01:47:58.936200', 41);

-- --------------------------------------------------------

--
-- Estrutura para tabela `respostas_individuais`
--

CREATE TABLE `respostas_individuais` (
  `id` int(11) NOT NULL,
  `tipo_pergunta` varchar(20) NOT NULL,
  `resposta_texto` longtext NOT NULL,
  `resposta_id` int(11) NOT NULL,
  `pergunta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `respostas_individuais`
--

INSERT INTO `respostas_individuais` (`id`, `tipo_pergunta`, `resposta_texto`, `resposta_id`, `pergunta_id`) VALUES
(78, 'multipla_escolha', '109', 43, 58),
(79, 'multipla_escolha', '112', 43, 59),
(80, 'multipla_escolha', '107', 44, 58),
(81, 'multipla_escolha', '110', 44, 59);

-- --------------------------------------------------------

--
-- Estrutura para tabela `sala`
--

CREATE TABLE `sala` (
  `id` int(11) NOT NULL,
  `EspacoEdificio` varchar(255) NOT NULL,
  `EspacoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sessao`
--

CREATE TABLE `sessao` (
  `ID` int(11) NOT NULL,
  `NInscritos` int(11) NOT NULL,
  `Vagas` int(11) NOT NULL,
  `Dia` date DEFAULT NULL,
  `AtividadeID` int(11) NOT NULL,
  `HorarioID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sessao`
--

INSERT INTO `sessao` (`ID`, `NInscritos`, `Vagas`, `Dia`, `AtividadeID`, `HorarioID`) VALUES
(19, 0, 41, '2022-05-03', 7, 19),
(24, 0, 45, '2022-05-03', 8, 19),
(26, 0, 45, '2022-05-03', 8, 20),
(29, 0, 45, '2022-05-04', 11, 19),
(30, 0, 45, '2022-05-03', 11, 19),
(32, 0, 26, '2022-05-03', 13, 22),
(33, 0, 45, '2022-05-04', 14, 20),
(34, 0, 29, '2022-05-03', 15, 21),
(35, 0, 30, '2022-05-04', 15, 21),
(36, 0, 45, '2022-05-03', 16, 20),
(37, 0, 45, '2022-05-04', 17, 19),
(38, 0, 45, '2022-05-04', 18, 20),
(39, 0, 45, '2022-05-03', 19, 19),
(40, 0, 45, '2022-05-04', 19, 19),
(45, 0, 20, '2022-05-04', 21, 28),
(46, 0, 45, '2023-06-18', 12, 14),
(47, 0, 45, '2023-06-19', 12, 29),
(50, 0, 45, '2023-06-18', 22, 14),
(51, 0, 45, '2023-06-18', 22, 29),
(52, 0, 45, '2023-06-19', 10, 21);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tarefa`
--

CREATE TABLE `tarefa` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `estado` varchar(64) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `dia` date NOT NULL,
  `horario` time(6) NOT NULL,
  `ColaboradorUtilizadorID` int(11) DEFAULT NULL,
  `CoordenadorUtilizadorID` int(11) DEFAULT NULL,
  `Diaaberto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tarefaacompanhar`
--

CREATE TABLE `tarefaacompanhar` (
  `tarefaid` int(11) NOT NULL,
  `origem` varchar(255) NOT NULL,
  `destino` varchar(255) NOT NULL,
  `inscricao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tarefaauxiliar`
--

CREATE TABLE `tarefaauxiliar` (
  `tarefaid` int(11) NOT NULL,
  `sessao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tarefaoutra`
--

CREATE TABLE `tarefaoutra` (
  `tarefaid` int(11) NOT NULL,
  `descricao` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tema`
--

CREATE TABLE `tema` (
  `ID` int(11) NOT NULL,
  `Tema` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tema`
--

INSERT INTO `tema` (`ID`, `Tema`) VALUES
(4, 'Área: Artes, Comunicação e Património'),
(5, 'Área: Ciências Sociais e da Educação'),
(6, 'Área: Ciências Exatas e Naturais'),
(7, 'Área: Ciências e Tecnologias da Saúde'),
(8, 'Área: Engenharias e Tecnologias'),
(9, 'Área: Economia, Gestão e Turismo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `temaq`
--

CREATE TABLE `temaq` (
  `ID` int(11) NOT NULL,
  `Tema` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `temaq`
--

INSERT INTO `temaq` (`ID`, `Tema`) VALUES
(1, 'Almoço\r\n'),
(2, 'Transportes\r\n');

-- --------------------------------------------------------

--
-- Estrutura para tabela `transporte`
--

CREATE TABLE `transporte` (
  `ID` int(11) NOT NULL,
  `Identificador` varchar(32) NOT NULL,
  `Dia` date NOT NULL,
  `diaAberto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `transporte`
--

INSERT INTO `transporte` (`ID`, `Identificador`, `Dia`, `diaAberto`) VALUES
(2, 'Autocarro 1', '2023-12-06', 4),
(3, 'Autocarro 2', '2023-12-06', 4),
(4, 'Autocarro 3', '2022-05-03', 3),
(5, 'Autocarro 4', '2022-05-03', 3),
(6, 'Autocarro 5', '2022-05-03', 3),
(7, 'Autocarro 6', '2022-05-03', 3),
(8, 'Autocarro 14', '2022-05-03', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `transportehorario`
--

CREATE TABLE `transportehorario` (
  `ID` int(11) NOT NULL,
  `Origem` varchar(32) NOT NULL,
  `Chegada` varchar(32) NOT NULL,
  `HoraPartida` time(6) NOT NULL,
  `HoraChegada` time(6) NOT NULL,
  `Transporte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `transportehorario`
--

INSERT INTO `transportehorario` (`ID`, `Origem`, `Chegada`, `HoraPartida`, `HoraChegada`, `Transporte`) VALUES
(3, 'Terminal', 'Penha', '08:25:00.000000', '08:50:00.000000', 2),
(5, 'Terminal', 'Penha', '08:25:00.000000', '08:50:00.000000', 3),
(6, 'Terminal', 'Gambelas', '08:25:00.000000', '08:50:00.000000', 4),
(7, 'Terminal', 'Gambelas', '08:25:00.000000', '08:50:00.000000', 5),
(8, 'Terminal', 'Penha', '08:45:00.000000', '09:05:00.000000', 6),
(9, 'Terminal', 'Gambelas', '08:45:00.000000', '09:05:00.000000', 7),
(10, 'Terminal', 'Gambelas', '09:00:00.000000', '09:20:00.000000', 2),
(11, 'Terminal', 'Gambelas', '09:00:00.000000', '09:20:00.000000', 3),
(12, 'Terminal', 'Penha', '09:00:00.000000', '09:20:00.000000', 4),
(13, 'Terminal', 'Penha', '09:00:00.000000', '09:20:00.000000', 5),
(14, 'Terminal', 'Gambelas', '09:15:00.000000', '09:30:00.000000', 6),
(15, 'Terminal', 'Penha', '09:15:00.000000', '09:25:00.000000', 7),
(16, 'Terminal', 'Penha', '09:45:00.000000', '10:00:00.000000', 2),
(17, 'Terminal', 'Penha', '09:45:00.000000', '10:00:00.000000', 3),
(18, 'Terminal', 'Gambelas', '06:45:00.000000', '10:00:00.000000', 4),
(19, 'Terminal', 'Gambelas', '09:45:00.000000', '10:00:00.000000', 5),
(20, 'Terminal', 'Penha', '10:25:00.000000', '10:40:00.000000', 6),
(21, 'Terminal', 'Gambelas', '10:25:00.000000', '10:40:00.000000', 7),
(22, 'Terminal', 'Gambelas', '12:25:00.000000', '12:40:00.000000', 2),
(23, 'Terminal', 'Penha', '12:25:00.000000', '12:40:00.000000', 3),
(24, 'Gambelas', 'Terminal', '17:26:00.000000', '18:29:00.000000', 8),
(25, 'Terminal', 'Gambelas', '08:25:00.000000', '08:50:00.000000', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `transporteuniversitario`
--

CREATE TABLE `transporteuniversitario` (
  `Transporte` int(11) NOT NULL,
  `Capacidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `transporteuniversitario`
--

INSERT INTO `transporteuniversitario` (`Transporte`, `Capacidade`) VALUES
(2, 50),
(3, 50),
(4, 50),
(5, 50),
(6, 50),
(7, 50),
(8, 50);

-- --------------------------------------------------------

--
-- Estrutura para tabela `unidadeorganica`
--

CREATE TABLE `unidadeorganica` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Sigla` varchar(255) NOT NULL,
  `CampusID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `unidadeorganica`
--

INSERT INTO `unidadeorganica` (`ID`, `Nome`, `Sigla`, `CampusID`) VALUES
(1, 'Escola Superior de Educação e Comunicação', 'ESEC', 1),
(2, 'Escola Superior de Gestão Hotelaria e Turismo', 'ESGHT', 3),
(3, 'Escola Superior de Saúde', 'ESS', 2),
(4, 'Instituto Superior de Engenharia', 'ISE', 1),
(5, 'Faculdade de Ciências Humanas e Sociais', 'FCHS', 2),
(6, 'Faculdade de Ciências e Tecnologia', 'FCT', 2),
(7, 'Faculdade de Economia', 'FE', 2),
(8, 'Faculdade de Medicina e Ciências Biomédicas', 'FMCB', 2),
(9, 'Desporto AAUAlg', 'GDAAUAlg', 1),
(10, 'Desporto AAUAlg', 'GDAAUAlg', 2),
(11, 'Biblioteca', 'BibPenha', 1),
(12, 'Biblioteca', 'BibGambelas', 2),
(13, 'Gabinete de Comunicação e Protocolo', 'GCP', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `utilizador`
--

CREATE TABLE `utilizador` (
  `user_ptr_id` int(11) NOT NULL,
  `contacto` varchar(20) NOT NULL,
  `valido` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `utilizador`
--

INSERT INTO `utilizador` (`user_ptr_id`, `contacto`, `valido`) VALUES
(1, '', 'True'),
(23, '+351963107359', 'True'),
(25, '+351919910008', 'True'),
(26, '+351919048144', 'True'),
(28, '+351936362302', 'True'),
(29, '+351917502181', 'True'),
(31, '+351919048144', 'True'),
(32, '+351914176692', 'True'),
(33, '+351963107359', 'True'),
(34, '+351961384454', 'True'),
(35, '+351914815430', 'True'),
(36, '+351914815430', 'True'),
(37, '+351966934582', 'True'),
(38, '+351919999999', 'True'),
(39, '+351919999999', 'Rejeitado'),
(40, '+351919191919', 'True'),
(41, '+351912156997', 'True'),
(44, '+351912156998', 'False'),
(46, '+351912156997', 'True'),
(47, '+351912156997', 'True');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`utilizador_ptr_id`);

--
-- Índices de tabela `anfiteatro`
--
ALTER TABLE `anfiteatro`
  ADD PRIMARY KEY (`EspacoID`);

--
-- Índices de tabela `arlivre`
--
ALTER TABLE `arlivre`
  ADD PRIMARY KEY (`EspacoID`);

--
-- Índices de tabela `atividade`
--
ALTER TABLE `atividade`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Atividade_diaAbertoID_7b531386_fk_DiaAberto_ID` (`diaAbertoID`),
  ADD KEY `Atividade_EspacoID_131bf78a_fk_Espaco_ID` (`EspacoID`),
  ADD KEY `Atividade_ProfessorUniversitar_dc191844_fk_Professor` (`ProfessorUniversitarioUtilizadorID`),
  ADD KEY `Atividade_Tema_ab8f2b29_fk_Tema_ID` (`Tema`);

--
-- Índices de tabela `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Índices de tabela `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Índices de tabela `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices de tabela `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Índices de tabela `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Índices de tabela `campus`
--
ALTER TABLE `campus`
  ADD PRIMARY KEY (`ID`);

--
-- Índices de tabela `colaborador`
--
ALTER TABLE `colaborador`
  ADD PRIMARY KEY (`utilizador_ptr_id`),
  ADD KEY `Colaborador_curso_id_31076750_fk_Curso_ID` (`curso_id`),
  ADD KEY `Colaborador_departamento_id_029b91e9_fk_Departamento_ID` (`departamento_id`),
  ADD KEY `Colaborador_faculdade_id_f4b0ed52_fk_UnidadeOrganica_ID` (`faculdade_id`);

--
-- Índices de tabela `colaboradorhorario`
--
ALTER TABLE `colaboradorhorario`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ColaboradorHorario_ColaboradorUtilizado_c2215826_fk_Colaborad` (`ColaboradorUtilizadorID`);

--
-- Índices de tabela `coordenador`
--
ALTER TABLE `coordenador`
  ADD PRIMARY KEY (`utilizador_ptr_id`),
  ADD KEY `Coordenador_DepartamentoID_77f7eb1c_fk_Departamento_ID` (`DepartamentoID`),
  ADD KEY `Coordenador_FaculdadeID_49668228_fk_UnidadeOrganica_ID` (`FaculdadeID`);

--
-- Índices de tabela `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Curso_Unidadeorganica_48c855bd_fk_UnidadeOrganica_ID` (`Unidadeorganica`);

--
-- Índices de tabela `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Departamento_UnidadeOrganicaID_8b27b79e_fk_UnidadeOrganica_ID` (`UnidadeOrganicaID`);

--
-- Índices de tabela `diaaberto`
--
ALTER TABLE `diaaberto`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `DiaAberto_AdministradorUtiliza_6d32149b_fk_Administr` (`AdministradorUtilizadorID`),
  ADD KEY `DiaAberto_QuestionarioID_7a73104e_fk_questionarios_ID` (`QuestionarioID`);

--
-- Índices de tabela `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Índices de tabela `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Índices de tabela `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Índices de tabela `edificio`
--
ALTER TABLE `edificio`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Edificio_Campus_91396335_fk_Campus_ID` (`Campus`);

--
-- Índices de tabela `escola`
--
ALTER TABLE `escola`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `espaco`
--
ALTER TABLE `espaco`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Espaco_Edificio_2d36e7bd_fk_Edificio_ID` (`Edificio`);

--
-- Índices de tabela `estado_questionario`
--
ALTER TABLE `estado_questionario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`ID`);

--
-- Índices de tabela `idioma`
--
ALTER TABLE `idioma`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Idioma_DiaAbertoID_05e90160_fk_DiaAberto_ID` (`DiaAbertoID`);

--
-- Índices de tabela `informacaomensagem`
--
ALTER TABLE `informacaomensagem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `InformacaoMensagem_data_b36b7c63` (`data`),
  ADD KEY `InformacaoMensagem_emissorid_a39368ba_fk_Utilizador_user_ptr_id` (`emissorid`),
  ADD KEY `InformacaoMensagem_recetorid_90645bfe_fk_Utilizador_user_ptr_id` (`recetorid`);

--
-- Índices de tabela `informacaonotificacao`
--
ALTER TABLE `informacaonotificacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `InformacaoNotificacao_data_52dada64` (`data`),
  ADD KEY `InformacaoNotificaca_emissorid_45bdccef_fk_Utilizado` (`emissorid`),
  ADD KEY `InformacaoNotificaca_recetorid_343e36f0_fk_Utilizado` (`recetorid`);

--
-- Índices de tabela `inscricao`
--
ALTER TABLE `inscricao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Inscricao_diaaberto_id_4be8f9d7_fk_DiaAberto_ID` (`diaaberto_id`),
  ADD KEY `Inscricao_escola_id_ea15d710_fk_Escola_id` (`escola_id`),
  ADD KEY `Inscricao_participante_id_1d4e1894_fk_Participa` (`participante_id`);

--
-- Índices de tabela `inscricaoprato`
--
ALTER TABLE `inscricaoprato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `InscricaoPrato_campus_id_a9d69a78_fk_Campus_ID` (`campus_id`),
  ADD KEY `InscricaoPrato_inscricao_id_287b42e4_fk_Inscricao_id` (`inscricao_id`);

--
-- Índices de tabela `inscricaosessao`
--
ALTER TABLE `inscricaosessao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `InscricaoSessao_inscricao_id_sessao_id_113816db_uniq` (`inscricao_id`,`sessao_id`),
  ADD KEY `InscricaoSessao_sessao_id_f35a89a7_fk_Sessao_ID` (`sessao_id`);

--
-- Índices de tabela `inscricaotransporte`
--
ALTER TABLE `inscricaotransporte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `InscricaoTransporte_inscricao_id_transporte_id_0271b0c8_uniq` (`inscricao_id`,`transporte_id`),
  ADD KEY `InscricaoTransporte_transporte_id_c07ff887_fk_Transport` (`transporte_id`);

--
-- Índices de tabela `materiais`
--
ALTER TABLE `materiais`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Materiais_AtividadeID_8a288a96_fk_Atividade_ID` (`AtividadeID`);

--
-- Índices de tabela `mensagemenviada`
--
ALTER TABLE `mensagemenviada`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MensagemEnviada_mensagem_id_650a9228_fk_InformacaoMensagem_id` (`mensagem_id`);

--
-- Índices de tabela `mensagemrecebida`
--
ALTER TABLE `mensagemrecebida`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MensagemRecebida_mensagem_id_929cdaa9_fk_InformacaoMensagem_id` (`mensagem_id`);

--
-- Índices de tabela `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Menu_Campus_diaAberto_Dia_a69897bd_uniq` (`Campus`,`diaAberto`,`Dia`),
  ADD KEY `Menu_diaAberto_ad0e738c_fk_DiaAberto_ID` (`diaAberto`),
  ADD KEY `Menu_HorarioID_c27c1815_fk_Horario_ID` (`HorarioID`);

--
-- Índices de tabela `notificacao`
--
ALTER TABLE `notificacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Notificacao_action_object_conten_5bed7a4d_fk_django_co` (`action_object_content_type_id`),
  ADD KEY `Notificacao_actor_content_type_i_247a4ff9_fk_django_co` (`actor_content_type_id`),
  ADD KEY `Notificacao_target_content_type__eb8c11a8_fk_django_co` (`target_content_type_id`),
  ADD KEY `Notificacao_unread_5c525732` (`unread`),
  ADD KEY `Notificacao_timestamp_b0c7de17` (`timestamp`),
  ADD KEY `Notificacao_public_e83b3bfc` (`public`),
  ADD KEY `Notificacao_deleted_5e8a8468` (`deleted`),
  ADD KEY `Notificacao_emailed_a50d3d89` (`emailed`),
  ADD KEY `Notificacao_recipient_id_unread_4902da17_idx` (`recipient_id`,`unread`);

--
-- Índices de tabela `opcoes_pergunta`
--
ALTER TABLE `opcoes_pergunta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `opcoes_pergunta_pergunta_id_471348ac_fk_perguntas_id` (`pergunta_id`);

--
-- Índices de tabela `participante`
--
ALTER TABLE `participante`
  ADD PRIMARY KEY (`utilizador_ptr_id`);

--
-- Índices de tabela `perguntas`
--
ALTER TABLE `perguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `perguntas_questionario_id_8b5fdf2f_fk_questionarios_ID` (`questionario_id`),
  ADD KEY `perguntas_tema_id_f5202034_fk_TemaQ_ID` (`tema_id`);

--
-- Índices de tabela `prato`
--
ALTER TABLE `prato`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Prato_MenuID_c8d51dba_fk_Menu_ID` (`MenuID`);

--
-- Índices de tabela `preferencia`
--
ALTER TABLE `preferencia`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Preferencia_ColaboradorUtilizado_5d7e095c_fk_Colaborad` (`ColaboradorUtilizadorID`);

--
-- Índices de tabela `preferenciaatividade`
--
ALTER TABLE `preferenciaatividade`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `PreferenciaAtividade_Atividade_8a2c1f3d_fk_Atividade_ID` (`Atividade`),
  ADD KEY `PreferenciaAtividade_PreferenciaID_8e4d7536_fk_Preferencia_ID` (`PreferenciaID`);

--
-- Índices de tabela `professoruniversitario`
--
ALTER TABLE `professoruniversitario`
  ADD PRIMARY KEY (`utilizador_ptr_id`),
  ADD KEY `ProfessorUniversitar_departamento_id_bae8bcc3_fk_Departame` (`departamento_id`),
  ADD KEY `ProfessorUniversitar_faculdade_id_21325caa_fk_UnidadeOr` (`faculdade_id`);

--
-- Índices de tabela `questionarios`
--
ALTER TABLE `questionarios`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `questionarios_autor_id_374394ec_fk_Administr` (`autor_id`),
  ADD KEY `questionarios_estado_id_35ca777d` (`estado_id`),
  ADD KEY `questionarios_estado_anterior_id_d2e40cd5_fk_estado_qu` (`estado_anterior_id`);

--
-- Índices de tabela `relatorios`
--
ALTER TABLE `relatorios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `relatorios_autor_id_a5ba17b1_fk_Administrador_utilizador_ptr_id` (`autor_id`),
  ADD KEY `relatorios_dia_aberto_id_5ea658a7_fk_DiaAberto_ID` (`dia_aberto_id`);

--
-- Índices de tabela `responsavel`
--
ALTER TABLE `responsavel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Responsavel_inscricao_id_62b18f0c_fk_Inscricao_id` (`inscricao_id`);

--
-- Índices de tabela `respostas`
--
ALTER TABLE `respostas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `respostas_questionario_id_e229792f_fk_questionarios_ID` (`questionario_id`);

--
-- Índices de tabela `respostas_individuais`
--
ALTER TABLE `respostas_individuais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `respostas_individuais_resposta_id_672d756b_fk_respostas_id` (`resposta_id`),
  ADD KEY `respostas_individuais_pergunta_id_66765b87_fk_perguntas_id` (`pergunta_id`);

--
-- Índices de tabela `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Sala_EspacoID_c91a0491_fk_Espaco_ID` (`EspacoID`);

--
-- Índices de tabela `sessao`
--
ALTER TABLE `sessao`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Sessao_AtividadeID_0931b4e1_fk_Atividade_ID` (`AtividadeID`),
  ADD KEY `Sessao_HorarioID_beea39cb_fk_Horario_ID` (`HorarioID`);

--
-- Índices de tabela `tarefa`
--
ALTER TABLE `tarefa`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Tarefa_ColaboradorUtilizado_82eab2cc_fk_Colaborad` (`ColaboradorUtilizadorID`),
  ADD KEY `Tarefa_CoordenadorUtilizado_9e97a908_fk_Coordenad` (`CoordenadorUtilizadorID`),
  ADD KEY `Tarefa_Diaaberto_8188b58c_fk_DiaAberto_ID` (`Diaaberto`);

--
-- Índices de tabela `tarefaacompanhar`
--
ALTER TABLE `tarefaacompanhar`
  ADD PRIMARY KEY (`tarefaid`),
  ADD KEY `TarefaAcompanhar_inscricao_caba3aa9_fk_Inscricao_id` (`inscricao`);

--
-- Índices de tabela `tarefaauxiliar`
--
ALTER TABLE `tarefaauxiliar`
  ADD PRIMARY KEY (`tarefaid`),
  ADD KEY `TarefaAuxiliar_sessao_585ae447_fk_Sessao_ID` (`sessao`);

--
-- Índices de tabela `tarefaoutra`
--
ALTER TABLE `tarefaoutra`
  ADD PRIMARY KEY (`tarefaid`);

--
-- Índices de tabela `tema`
--
ALTER TABLE `tema`
  ADD PRIMARY KEY (`ID`);

--
-- Índices de tabela `temaq`
--
ALTER TABLE `temaq`
  ADD PRIMARY KEY (`ID`);

--
-- Índices de tabela `transporte`
--
ALTER TABLE `transporte`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Transporte_diaAberto_d2f61ae1_fk_DiaAberto_ID` (`diaAberto`);

--
-- Índices de tabela `transportehorario`
--
ALTER TABLE `transportehorario`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `TransporteHorario_Transporte_18a4877f_fk_Transporte_ID` (`Transporte`);

--
-- Índices de tabela `transporteuniversitario`
--
ALTER TABLE `transporteuniversitario`
  ADD PRIMARY KEY (`Transporte`);

--
-- Índices de tabela `unidadeorganica`
--
ALTER TABLE `unidadeorganica`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UnidadeOrganica_CampusID_2e2e86da_fk_Campus_ID` (`CampusID`);

--
-- Índices de tabela `utilizador`
--
ALTER TABLE `utilizador`
  ADD PRIMARY KEY (`user_ptr_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `atividade`
--
ALTER TABLE `atividade`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- AUTO_INCREMENT de tabela `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de tabela `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de tabela `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `campus`
--
ALTER TABLE `campus`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `colaboradorhorario`
--
ALTER TABLE `colaboradorhorario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `curso`
--
ALTER TABLE `curso`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de tabela `departamento`
--
ALTER TABLE `departamento`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `diaaberto`
--
ALTER TABLE `diaaberto`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de tabela `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de tabela `edificio`
--
ALTER TABLE `edificio`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `escola`
--
ALTER TABLE `escola`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `espaco`
--
ALTER TABLE `espaco`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de tabela `horario`
--
ALTER TABLE `horario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `idioma`
--
ALTER TABLE `idioma`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `informacaomensagem`
--
ALTER TABLE `informacaomensagem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `informacaonotificacao`
--
ALTER TABLE `informacaonotificacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT de tabela `inscricao`
--
ALTER TABLE `inscricao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `inscricaoprato`
--
ALTER TABLE `inscricaoprato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `inscricaosessao`
--
ALTER TABLE `inscricaosessao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `inscricaotransporte`
--
ALTER TABLE `inscricaotransporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `materiais`
--
ALTER TABLE `materiais`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `mensagemenviada`
--
ALTER TABLE `mensagemenviada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `mensagemrecebida`
--
ALTER TABLE `mensagemrecebida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `menu`
--
ALTER TABLE `menu`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `notificacao`
--
ALTER TABLE `notificacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de tabela `opcoes_pergunta`
--
ALTER TABLE `opcoes_pergunta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de tabela `perguntas`
--
ALTER TABLE `perguntas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de tabela `prato`
--
ALTER TABLE `prato`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `preferencia`
--
ALTER TABLE `preferencia`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `preferenciaatividade`
--
ALTER TABLE `preferenciaatividade`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `questionarios`
--
ALTER TABLE `questionarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de tabela `relatorios`
--
ALTER TABLE `relatorios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `responsavel`
--
ALTER TABLE `responsavel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `respostas`
--
ALTER TABLE `respostas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `respostas_individuais`
--
ALTER TABLE `respostas_individuais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de tabela `sala`
--
ALTER TABLE `sala`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sessao`
--
ALTER TABLE `sessao`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de tabela `tarefa`
--
ALTER TABLE `tarefa`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tema`
--
ALTER TABLE `tema`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `temaq`
--
ALTER TABLE `temaq`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `transporte`
--
ALTER TABLE `transporte`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `transportehorario`
--
ALTER TABLE `transportehorario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `unidadeorganica`
--
ALTER TABLE `unidadeorganica`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `Administrador_utilizador_ptr_id_117564dc_fk_Utilizado` FOREIGN KEY (`utilizador_ptr_id`) REFERENCES `utilizador` (`user_ptr_id`);

--
-- Restrições para tabelas `anfiteatro`
--
ALTER TABLE `anfiteatro`
  ADD CONSTRAINT `Anfiteatro_EspacoID_ab742067_fk_Espaco_ID` FOREIGN KEY (`EspacoID`) REFERENCES `espaco` (`ID`);

--
-- Restrições para tabelas `arlivre`
--
ALTER TABLE `arlivre`
  ADD CONSTRAINT `ArLivre_EspacoID_209d84bf_fk_Espaco_ID` FOREIGN KEY (`EspacoID`) REFERENCES `espaco` (`ID`);

--
-- Restrições para tabelas `atividade`
--
ALTER TABLE `atividade`
  ADD CONSTRAINT `Atividade_EspacoID_131bf78a_fk_Espaco_ID` FOREIGN KEY (`EspacoID`) REFERENCES `espaco` (`ID`),
  ADD CONSTRAINT `Atividade_ProfessorUniversitar_dc191844_fk_Professor` FOREIGN KEY (`ProfessorUniversitarioUtilizadorID`) REFERENCES `professoruniversitario` (`utilizador_ptr_id`),
  ADD CONSTRAINT `Atividade_Tema_ab8f2b29_fk_Tema_ID` FOREIGN KEY (`Tema`) REFERENCES `tema` (`ID`),
  ADD CONSTRAINT `Atividade_diaAbertoID_7b531386_fk_DiaAberto_ID` FOREIGN KEY (`diaAbertoID`) REFERENCES `diaaberto` (`ID`);

--
-- Restrições para tabelas `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Restrições para tabelas `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Restrições para tabelas `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrições para tabelas `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrições para tabelas `colaborador`
--
ALTER TABLE `colaborador`
  ADD CONSTRAINT `Colaborador_curso_id_31076750_fk_Curso_ID` FOREIGN KEY (`curso_id`) REFERENCES `curso` (`ID`),
  ADD CONSTRAINT `Colaborador_departamento_id_029b91e9_fk_Departamento_ID` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`ID`),
  ADD CONSTRAINT `Colaborador_faculdade_id_f4b0ed52_fk_UnidadeOrganica_ID` FOREIGN KEY (`faculdade_id`) REFERENCES `unidadeorganica` (`ID`),
  ADD CONSTRAINT `Colaborador_utilizador_ptr_id_dbd95f69_fk_Utilizador_user_ptr_id` FOREIGN KEY (`utilizador_ptr_id`) REFERENCES `utilizador` (`user_ptr_id`);

--
-- Restrições para tabelas `colaboradorhorario`
--
ALTER TABLE `colaboradorhorario`
  ADD CONSTRAINT `ColaboradorHorario_ColaboradorUtilizado_c2215826_fk_Colaborad` FOREIGN KEY (`ColaboradorUtilizadorID`) REFERENCES `colaborador` (`utilizador_ptr_id`);

--
-- Restrições para tabelas `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `Curso_Unidadeorganica_48c855bd_fk_UnidadeOrganica_ID` FOREIGN KEY (`Unidadeorganica`) REFERENCES `unidadeorganica` (`ID`);

--
-- Restrições para tabelas `questionarios`
--
ALTER TABLE `questionarios`
  ADD CONSTRAINT `questionarios_estado_anterior_id_d2e40cd5_fk_estado_qu` FOREIGN KEY (`estado_anterior_id`) REFERENCES `estado_questionario` (`id`);

--
-- Restrições para tabelas `relatorios`
--
ALTER TABLE `relatorios`
  ADD CONSTRAINT `relatorios_autor_id_a5ba17b1_fk_Administrador_utilizador_ptr_id` FOREIGN KEY (`autor_id`) REFERENCES `Administrador` (`utilizador_ptr_id`),
  ADD CONSTRAINT `relatorios_dia_aberto_id_5ea658a7_fk_DiaAberto_ID` FOREIGN KEY (`dia_aberto_id`) REFERENCES `DiaAberto` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
