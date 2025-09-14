import '../domain/entities/talent.dart';

/// Retorna lista de talentos mocados para desenvolvimento
List<Talent> getMockTalents() {
  return [
    Talent(
      nome: 'Lucas Mendes',
      cidade: 'Curitiba',
      estado: 'PR',
      descricao:
          'Consultor financeiro com mais de 8 anos de experiência em investimentos e planejamento patrimonial. Especialista em análise de risco, gestão de carteiras e consultoria para empresas e pessoas físicas. Possui certificações CFA e CFP, com atuação em diversos segmentos do mercado financeiro. Ajuda empreendedores e profissionais a tomarem decisões estratégicas sobre seus investimentos, sempre priorizando a segurança e o crescimento sustentável do patrimônio.',
      imagemUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      habilidades: [
        'Consultoria Financeira',
        'Investimentos',
        'Análise de Risco',
        'Planejamento',
      ],
      instagram: '@lucas_mendes_financeiro',
      whatsapp: '+55 41 99999-1234',
      rating: 4.8,
      totalRatings: 23,
      ratings: [
        Rating(
          userId: '1',
          userName: 'Maria Silva',
          rating: 5.0,
          comment:
              'Excelente consultor! Me ajudou muito com meus investimentos.',
          date: DateTime(2024, 8, 15),
        ),
        Rating(
          userId: '2',
          userName: 'João Santos',
          rating: 4.5,
          comment: 'Muito profissional e competente.',
          date: DateTime(2024, 7, 22),
        ),
        Rating(
          userId: '3',
          userName: 'Ana Costa',
          rating: 5.0,
          comment: 'Recomendo fortemente! Resultados acima das expectativas.',
          date: DateTime(2024, 6, 10),
        ),
      ],
    ),
    Talent(
      nome: 'Patricia Costa',
      cidade: 'Salvador',
      estado: 'BA',
      descricao:
          'Tradutora e intérprete profissional com fluência nativa em português e fluência avançada em 5 idiomas: inglês, espanhol, francês, alemão e italiano. Mais de 10 anos de experiência em tradução técnica, jurídica e literária. Trabalha com empresas multinacionais, órgãos governamentais e eventos internacionais. Especialista em localização de software, tradução de documentos legais e interpretação simultânea em conferências. Comprometida com a precisão cultural e terminológica em todos os seus trabalhos.',
      imagemUrl:
          'https://images.unsplash.com/photo-1494790108755-2616b612b6c8?w=150&h=150&fit=crop&crop=face',
      habilidades: ['Tradução', 'Inglês', 'Espanhol', 'Francês', 'Alemão'],
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
      habilidades: ['React', 'Node.js', 'TypeScript', 'MongoDB'],
      instagram: '@carlos_dev_fullstack',
      whatsapp: '+55 21 94444-2345',
      rating: 4.9,
      totalRatings: 42,
      ratings: [
        Rating(
          userId: '14',
          userName: 'Gabriela Torres',
          rating: 5.0,
          comment: 'Sistema perfeito! Zero bugs.',
          date: DateTime(2024, 9, 10),
        ),
        Rating(
          userId: '15',
          userName: 'Rafael Souza',
          rating: 4.5,
          comment: 'Código limpo e bem documentado.',
          date: DateTime(2024, 8, 22),
        ),
        Rating(
          userId: '16',
          userName: 'Mariana Lima',
          rating: 5.0,
          comment: 'Excelente desenvolvedor!',
          date: DateTime(2024, 7, 28),
        ),
        Rating(
          userId: '17',
          userName: 'Diego Santos',
          rating: 5.0,
          comment: 'Superou todas as expectativas.',
          date: DateTime(2024, 6, 15),
        ),
      ],
    ),
  ];
}
