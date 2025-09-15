# Clean Architecture Implementation - Mapa Cultural Santa Luzia

## 📋 Visão Geral

Este projeto implementa uma arquitetura limpa (Clean Architecture) seguindo os princípios SOLID e Object Calisthenics. A arquitetura garante separação de responsabilidades, testabilidade e manutenibilidade do código.

## 🏗️ Estrutura da Arquitetura

### Camadas da Aplicação

```
lib/
├── core/                    # Infraestrutura e utilitários
│   ├── di/                  # Injeção de dependência
│   ├── services/            # Contratos e implementações de serviços
│   └── utils/              # Utilitários (exceções, etc.)
├── data/                   # Camada de dados
│   └── repositories/       # Implementações concretas dos repositórios
├── domain/                 # Camada de domínio (regras de negócio)
│   ├── entities/           # Entidades do domínio
│   ├── repositories/       # Contratos dos repositórios
│   └── usecases/          # Casos de uso
└── presentation/          # Camada de apresentação (UI)
    ├── pages/             # Páginas da aplicação
    └── widgets/           # Widgets reutilizáveis
```

## 🎯 Princípios SOLID Implementados

### 1. Single Responsibility Principle (SRP)

- **Repositórios**: Cada repositório tem responsabilidade única (TalentRepository, AdvertisementRepository)
- **Serviços**: Separados por funcionalidade (TalentSearchService, TalentManagementService, RatingService)
- **Use Cases**: Cada use case encapsula uma única operação de negócio

### 2. Open/Closed Principle (OCP)

- **Interfaces/Contratos**: Abstrações abertas para extensão, fechadas para modificação
- **Implementações**: Novas implementações podem ser adicionadas sem modificar código existente

### 3. Liskov Substitution Principle (LSP)

- **Repositórios**: MockTalentRepository pode ser substituído por FirebaseTalentRepository sem quebrar o código
- **Serviços**: Implementações podem ser trocadas transparentemente

### 4. Interface Segregation Principle (ISP)

- **Contratos Específicos**: Interfaces pequenas e focadas (TalentSearchService vs TalentManagementService)
- **Dependências Mínimas**: Classes dependem apenas das interfaces que realmente usam

### 5. Dependency Inversion Principle (DIP)

- **Inversão de Controle**: Classes de alto nível não dependem de implementações concretas
- **Injeção de Dependência**: Uso do GetIt para gerenciar dependências

## 🔧 Object Calisthenics Aplicados

### 1. One Level of Indentation per Method

- Métodos com apenas um nível de indentação
- Uso de métodos auxiliares para reduzir complexidade

### 2. Don't Use the ELSE Keyword

- Uso de early returns
- Estruturas condicionais simplificadas

### 3. Wrap All Primitives and Strings

- Entidades encapsulam dados primitivos
- Validações centralizadas nas entidades

### 4. First Class Collections

- Uso de classes específicas para coleções quando apropriado
- Métodos de manipulação encapsulados

### 5. One Dot per Line

- Evita method chaining excessivo
- Melhora legibilidade do código

### 6. Don't Abbreviate

- Nomes descritivos e completos
- Clareza sobre abreviações

### 7. Keep All Entities Small

- Classes focadas e coesas
- Responsabilidades bem definidas

### 8. No Classes with More Than Two Instance Variables

- Aplicado onde possível
- Favorece composição sobre herança

### 9. No Getters/Setters/Properties

- Métodos com comportamento ao invés de getters/setters simples
- Encapsulamento adequado

## 📁 Componentes Implementados

### Domain Layer

#### Entities

- ✅ `Talent` - Entidade principal representando um talento
- ✅ `Rating` - Entidade para avaliações
- ✅ `Advertisement` - Entidade para propagandas

#### Repository Contracts

- ✅ `TalentRepository` - Contrato para operações com talentos
- ✅ `AdvertisementRepository` - Contrato para operações com propagandas

#### Use Cases

- ✅ `GetAllTalentsUseCase` - Buscar todos os talentos
- ✅ `GetTalentDetailsUseCase` - Buscar detalhes de um talento
- ✅ `SearchTalentsUseCase` - Pesquisar talentos com filtros
- ✅ `CreateTalentUseCase` - Criar novo talento

### Data Layer

#### Repository Implementations

- ✅ `MockTalentRepository` - Implementação com dados mock
- ✅ `MockAdvertisementRepository` - Implementação com dados mock

### Core Layer

#### Services

- ✅ `TalentSearchService` - Serviço de busca de talentos
- ✅ `TalentManagementService` - Serviço de gerenciamento de talentos
- ✅ `RatingService` - Serviço de avaliações
- ✅ `AdvertisementService` - Serviço de propagandas

#### Dependency Injection

- ✅ `ServiceLocator` - Configuração do GetIt
- ✅ Registro de dependências
- ✅ Type-safe getters

#### Exception Handling

- ✅ `AppException` - Classe base para exceções
- ✅ `RepositoryException` - Exceções da camada de dados
- ✅ `ServiceException` - Exceções da camada de serviços
- ✅ `UseCaseException` - Exceções da camada de casos de uso
- ✅ `NetworkException` - Exceções de rede
- ✅ `AuthException` - Exceções de autenticação

### Presentation Layer

#### Example Implementation

- ✅ `CleanArchitectureExamplePage` - Exemplo de uso da arquitetura

## 🚀 Como Usar

### 1. Inicialização da Aplicação

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar injeção de dependência
  await configureDependencies();

  runApp(const MapaCulturalApp());
}
```

### 2. Usando Use Cases em uma Page/Widget

```dart
class ExamplePage extends StatefulWidget {
  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late final GetAllTalentsUseCase _getAllTalentsUseCase;

  @override
  void initState() {
    super.initState();
    // Injetar use case via service locator
    _getAllTalentsUseCase = getAllTalentsUseCase;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Usar o use case
      final talents = await _getAllTalentsUseCase.execute();
      // Atualizar UI
    } catch (e) {
      // Tratar erros
    }
  }
}
```

### 3. Busca com Filtros

```dart
Future<void> _searchTalents() async {
  try {
    final results = await searchTalentsUseCase.execute(
      query: 'João',
      skills: ['Fotografia', 'Design'],
      city: 'Santa Luzia',
      state: 'PB',
    );
    // Processar resultados
  } catch (e) {
    // Tratar erros
  }
}
```

## 🔄 Fluxo de Dados

```
UI → Use Case → Service → Repository → Data Source
↓                                              ↑
Exception Handling ← ← ← ← ← ← ← ← ← ← ← ← ← ← ←
```

### Exemplo de Fluxo:

1. **UI** chama um Use Case
2. **Use Case** aplica regras de negócio e chama Service
3. **Service** processa e chama Repository
4. **Repository** acessa fonte de dados (mock, API, etc.)
5. **Dados** retornam pela mesma cadeia
6. **Exceções** são tratadas em cada camada

## 🧪 Testabilidade

A arquitetura implementada facilita testes:

### Unit Tests

- **Use Cases**: Testáveis isoladamente com mocks dos services
- **Services**: Testáveis com mocks dos repositories
- **Repositories**: Testáveis com mocks das fontes de dados

### Integration Tests

- **Fluxo completo**: Da UI até os dados
- **Injeção de dependência**: Permite substituir componentes para teste

## 📈 Benefícios da Implementação

### Manutenibilidade

- ✅ Código organizado em camadas bem definidas
- ✅ Responsabilidades claras
- ✅ Fácil localização de bugs

### Testabilidade

- ✅ Componentes isolados e testáveis
- ✅ Mocks fáceis de implementar
- ✅ Cobertura de testes facilitada

### Escalabilidade

- ✅ Fácil adição de novas funcionalidades
- ✅ Substituição de implementações
- ✅ Extensão sem modificação

### Reutilização

- ✅ Use Cases reutilizáveis
- ✅ Services compartilháveis
- ✅ Repositories intercambiáveis

## 🔄 Próximos Passos

### Implementações Futuras

1. **Firebase Integration**: Substituir MockRepositories por FirebaseRepositories
2. **API Integration**: Implementar repositories para APIs REST
3. **State Management**: Integrar com BLoC/Provider para gerenciamento de estado
4. **Caching**: Implementar cache local para melhor performance
5. **Offline Support**: Adicionar suporte offline com sincronização

### Testes

1. **Unit Tests**: Implementar testes para todos os use cases e services
2. **Integration Tests**: Testes end-to-end
3. **Widget Tests**: Testes da camada de apresentação

## 📚 Recursos Adicionais

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Object Calisthenics](https://williamdurand.fr/2013/06/03/object-calisthenics/)
- [Flutter Clean Architecture](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)

---

**Desenvolvido seguindo as melhores práticas de Clean Architecture, SOLID e Object Calisthenics** 🚀
