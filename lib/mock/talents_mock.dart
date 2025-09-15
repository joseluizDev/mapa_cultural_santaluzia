import '../domain/entities/talent.dart';

// Cache for mock talents to avoid recreating the list every time
List<Talent>? _cachedTalents;

/// Retorna uma lista de talentos mockados para testes
List<Talent> getMockTalents() {
  // Return cached talents if already created
  if (_cachedTalents != null) {
    return _cachedTalents!;
  }

  _cachedTalents = [
    Talent(
      nome: 'Patricia Almeida',
      cidade: 'Santa Luzia',
      estado: 'PB',
      descricao:
          'Tradutora especializada em idiomas estrangeiros com 10 anos de experiência. Fluente em inglês, espanhol e francês. Especialista em tradução juramentada, literária e técnica. Trabalha com empresas multinacionais, escritores e instituições educacionais. Formada em Letras e pós-graduada em Tradução Especializada. Apaixonada por promover o intercâmbio cultural através da língua e da tradução de alta qualidade.',
      imagemUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&h=150&fit=crop&crop=face',
      habilidades: [
        'Inglês',
        'Espanhol',
        'Francês',
        'Tradução Juramentada',
      ],
      instagram: '@patricia_tradutora',
      whatsapp: '+55 71 98888-5678',
      rating: 4.9,
      totalRatings: 18,
      ratings: [
        Rating(
          userId: '4',
          userName: 'Pedro Oliveira',
          rating: 5.0,
          comment: 'Tradução impecável! Recomendo para qualquer projeto.',
          date: DateTime(2024, 8, 20),
        ),
        Rating(
          userId: '5',
          userName: 'Carla Mendes',
          rating: 4.5,
          comment: 'Profissional excelente e muito pontual.',
          date: DateTime(2024, 7, 15),
        ),
      ],
    ),
    Talent(
      nome: 'Ana Silva',
      cidade: 'São Paulo',
      estado: 'SP',
      descricao:
          'Designer gráfica com 8 anos de experiência em branding e identidade visual. Especialista em criação de logotipos, identidade corporativa e design de interfaces digitais. Trabalha com Adobe Creative Suite (Photoshop, Illustrator, InDesign) e ferramentas de design UX/UI. Já desenvolveu projetos para startups, empresas estabelecidas e instituições públicas. Apaixonada por design sustentável e minimalista, sempre buscando soluções criativas que conectem marcas com seu público-alvo de forma autêntica e memorável.',
      imagemUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      habilidades: [
        'Design Gráfico',
        'Branding',
        'Adobe Creative Suite',
        'UI/UX',
      ],
      instagram: '@ana_silva_design',
      whatsapp: '+55 11 97777-9012',
      rating: 4.7,
      totalRatings: 31,
      ratings: [
        Rating(
          userId: '6',
          userName: 'Roberto Lima',
          rating: 5.0,
          comment: 'Design incrível! Superou todas as expectativas.',
          date: DateTime(2024, 9, 1),
        ),
        Rating(
          userId: '7',
          userName: 'Juliana Costa',
          rating: 4.0,
          comment: 'Muito criativa e profissional.',
          date: DateTime(2024, 8, 5),
        ),
        Rating(
          userId: '8',
          userName: 'Marcos Silva',
          rating: 5.0,
          comment: 'Trabalho excepcional! Recomendo.',
          date: DateTime(2024, 7, 12),
        ),
      ],
    ),
    Talent(
      nome: 'Roberto Alves',
      cidade: 'Porto Alegre',
      estado: 'RS',
      descricao:
          'Fotógrafo profissional especializado em eventos corporativos, casamentos e publicidade. Mais de 12 anos de experiência em fotografia comercial e artística. Trabalha com equipamentos profissionais Canon e Nikon, possuindo expertise em iluminação, composição e edição digital. Já fotografou eventos para empresas como Google, Microsoft e diversos eventos culturais. Também oferece serviços de edição de imagem, gerenciamento de mídias sociais e consultoria em marketing visual para pequenos negócios.',
      imagemUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      habilidades: ['Fotografia', 'Edição de Imagem', 'Google Ads'],
      instagram: '@roberto_alves_foto',
      whatsapp: '+55 51 96666-3456',
      rating: 4.6,
      totalRatings: 27,
      ratings: [
        Rating(
          userId: '9',
          userName: 'Amanda Santos',
          rating: 5.0,
          comment: 'Fotos maravilhosas do meu casamento!',
          date: DateTime(2024, 8, 25),
        ),
        Rating(
          userId: '10',
          userName: 'Lucas Pereira',
          rating: 4.0,
          comment: 'Bom trabalho, entrega no prazo.',
          date: DateTime(2024, 7, 30),
        ),
      ],
    ),
    Talent(
      nome: 'Fernanda Lima',
      cidade: 'Belo Horizonte',
      estado: 'MG',
      descricao:
          'Especialista em Marketing Digital e SEO com foco em resultados mensuráveis. 6 anos de experiência em estratégias de crescimento online, otimização de mecanismos de busca e marketing de conteúdo. Trabalha com Google Ads, Facebook Ads, SEO técnico e analítica web. Já ajudou mais de 50 empresas a aumentarem sua presença online e gerar mais leads qualificados. Especialista em e-commerce, SaaS e empresas de serviços. Comprometida com a educação continuada e sempre atualizada com as últimas tendências do marketing digital.',
      imagemUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
      habilidades: ['Marketing Digital', 'SEO'],
      instagram: '@fernanda_marketing',
      whatsapp: '+55 31 95555-7890',
      rating: 4.8,
      totalRatings: 35,
      ratings: [
        Rating(
          userId: '11',
          userName: 'Thiago Alves',
          rating: 5.0,
          comment: 'Aumentou minhas vendas em 300%!',
          date: DateTime(2024, 9, 5),
        ),
        Rating(
          userId: '12',
          userName: 'Beatriz Rocha',
          rating: 4.5,
          comment: 'Estratégias muito eficazes.',
          date: DateTime(2024, 8, 18),
        ),
        Rating(
          userId: '13',
          userName: 'Fernando Gomes',
          rating: 5.0,
          comment: 'Profissional excepcional!',
          date: DateTime(2024, 7, 25),
        ),
      ],
    ),
    Talent(
      nome: 'Carlos Santos',
      cidade: 'Rio de Janeiro',
      estado: 'RJ',
      descricao:
          'Desenvolvedor Full Stack com 7 anos de experiência em desenvolvimento web e mobile. Especialista em React, Node.js, TypeScript e MongoDB. Trabalha com metodologias ágeis (Scrum/Kanban) e possui experiência em arquitetura de microsserviços e DevOps. Já desenvolveu aplicações para startups, empresas de tecnologia e instituições financeiras. Apaixonado por clean code, testes automatizados e desenvolvimento de produtos escaláveis. Também oferece mentoria para desenvolvedores iniciantes e palestras sobre tecnologia.',
      imagemUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
      habilidades: [
        'Desenvolvimento Web',
        'React',
        'Node.js',
        'TypeScript',
        'MongoDB'
      ],
      instagram: '@carlos_dev',
      whatsapp: '+55 21 94444-1234',
      rating: 4.9,
      totalRatings: 42,
      ratings: [
        Rating(
          userId: '14',
          userName: 'Marina Ribeiro',
          rating: 5.0,
          comment:
              'Desenvolveu um sistema incrível para minha empresa. Super recomendo!',
          date: DateTime(2024, 9, 10),
        ),
        Rating(
          userId: '15',
          userName: 'Alexandre Costa',
          rating: 4.8,
          comment: 'Excelente profissional, código limpo e entrega no prazo.',
          date: DateTime(2024, 8, 22),
        ),
        Rating(
          userId: '16',
          userName: 'Juliana Mendes',
          rating: 5.0,
          comment: 'Mentoria transformadora. Recomendo para iniciantes!',
          date: DateTime(2024, 7, 15),
        ),
      ],
    ),
    Talent(
      nome: 'Mariana Costa',
      cidade: 'Santa Luzia',
      estado: 'PB',
      descricao:
          'Chef de cozinha especializada em gastronomia local e fusão de sabores. 8 anos de experiência em restaurantes de alta gastronomia e catering para eventos especiais. Formada em Gastronomia pela Universidade Federal da Paraíba, com especialização em Cozinha Brasileira Contemporânea. Expert em utilizar ingredientes locais e regionais para criar pratos únicos que valorizam a cultura local. Oferece consultoria gastronômica, aulas particulares de culinária e catering personalizado para eventos. Apaixonada por promover a rica culinária da Paraíba.',
      imagemUrl:
          'https://images.unsplash.com/photo-1567532939604-b6b5b0e1607d?w=150&h=150&fit=crop&crop=face',
      habilidades: [
        'Gastronomia Local',
        'Cozinha Brasileira',
        'Catering',
        'Consultoria Gastronômica',
      ],
      instagram: '@mariana_chef',
      whatsapp: '+55 83 93333-5678',
      rating: 5.0,
      totalRatings: 29,
      ratings: [
        Rating(
          userId: '17',
          userName: 'Roberto Almeida',
          rating: 5.0,
          comment:
              'Buffet do casamento foi sensacional! Cada prato uma delícia.',
          date: DateTime(2024, 9, 8),
        ),
        Rating(
          userId: '18',
          userName: 'Sofia Oliveira',
          rating: 5.0,
          comment: 'Aulas maravilhosas! Aprendi muito sobre a culinária local.',
          date: DateTime(2024, 8, 17),
        ),
      ],
    ),
  ];
  
  return _cachedTalents!;
}