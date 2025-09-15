import 'package:get_it/get_it.dart';

import '../../data/repositories/mock_advertisement_repository.dart';
// Data layer imports
import '../../data/repositories/mock_talent_repository.dart';
import '../../domain/repositories/advertisement_repository_contract.dart';
// Domain layer imports
import '../../domain/repositories/talent_repository_contract.dart';
import '../../domain/usecases/create_talent_usecase.dart';
import '../../domain/usecases/get_all_talents_usecase.dart';
import '../../domain/usecases/get_talent_details_usecase.dart';
import '../../domain/usecases/search_talents_usecase.dart';
import '../services/talent_management_service_contract.dart';
import '../services/talent_management_service_impl.dart';
// Service layer imports
import '../services/talent_search_service_contract.dart';
import '../services/talent_search_service_impl.dart';

/// Service locator for dependency injection
/// Follows Inversion of Control and Dependency Injection principles
final GetIt serviceLocator = GetIt.instance;

/// Configures all dependencies using GetIt
/// This should be called once at app startup
Future<void> configureDependencies() async {
  // Register repositories as singletons
  // Using singletons to maintain state consistency across the app
  serviceLocator.registerSingleton<TalentRepository>(MockTalentRepository());

  serviceLocator.registerSingleton<AdvertisementRepository>(
    MockAdvertisementRepository(),
  );

  // Register services as singletons
  // Services depend on repositories
  serviceLocator.registerSingleton<TalentSearchService>(
    TalentSearchServiceImpl(serviceLocator<TalentRepository>()),
  );

  serviceLocator.registerSingleton<TalentManagementService>(
    TalentManagementServiceImpl(serviceLocator<TalentRepository>()),
  );

  // Register use cases as factories
  // Use cases are lightweight and can be created on demand
  serviceLocator.registerFactory<GetAllTalentsUseCase>(
    () => GetAllTalentsUseCase(serviceLocator<TalentManagementService>()),
  );

  serviceLocator.registerFactory<GetTalentDetailsUseCase>(
    () => GetTalentDetailsUseCase(serviceLocator<TalentManagementService>()),
  );

  serviceLocator.registerFactory<SearchTalentsUseCase>(
    () => SearchTalentsUseCase(serviceLocator<TalentSearchService>()),
  );

  serviceLocator.registerFactory<CreateTalentUseCase>(
    () => CreateTalentUseCase(serviceLocator<TalentManagementService>()),
  );
}

/// Resets all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await serviceLocator.reset();
}

/// Type-safe getters for commonly used dependencies
/// These provide a clean API for accessing dependencies

// Repositories
TalentRepository get talentRepository => serviceLocator<TalentRepository>();
AdvertisementRepository get advertisementRepository =>
    serviceLocator<AdvertisementRepository>();

// Services
TalentSearchService get talentSearchService =>
    serviceLocator<TalentSearchService>();
TalentManagementService get talentManagementService =>
    serviceLocator<TalentManagementService>();

// Use Cases
GetAllTalentsUseCase get getAllTalentsUseCase =>
    serviceLocator<GetAllTalentsUseCase>();
GetTalentDetailsUseCase get getTalentDetailsUseCase =>
    serviceLocator<GetTalentDetailsUseCase>();
SearchTalentsUseCase get searchTalentsUseCase =>
    serviceLocator<SearchTalentsUseCase>();
CreateTalentUseCase get createTalentUseCase =>
    serviceLocator<CreateTalentUseCase>();
