import '../../core/di/service_locator.dart';
import '../../core/state/base_store.dart';
import '../../domain/entities/talent.dart';
import '../../domain/usecases/get_all_talents_usecase.dart';
import '../../domain/usecases/get_talent_details_usecase.dart';
import '../../domain/usecases/search_talents_usecase.dart';

/// Store for managing talent-related state
/// Follows Single Responsibility Principle - manages only talent state
class TalentStore extends BaseStore<List<Talent>> {
  // Use cases injected via service locator
  final GetAllTalentsUseCase _getAllTalentsUseCase;
  final SearchTalentsUseCase _searchTalentsUseCase;
  final GetTalentDetailsUseCase _getTalentDetailsUseCase;

  TalentStore()
    : _getAllTalentsUseCase = getAllTalentsUseCase,
      _searchTalentsUseCase = searchTalentsUseCase,
      _getTalentDetailsUseCase = getTalentDetailsUseCase;

  /// Loads all talents
  Future<void> loadAllTalents() async {
    await executeWithState(() => _getAllTalentsUseCase.execute());
  }

  /// Searches talents with filters
  Future<void> searchTalents({
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  }) async {
    await executeWithState(
      () => _searchTalentsUseCase.execute(
        query: query,
        skills: skills,
        city: city,
        state: state,
      ),
    );
  }

  /// Searches talents by name only
  Future<void> searchByName(String query) async {
    if (query.trim().isEmpty) {
      await loadAllTalents();
      return;
    }

    await executeWithState(() => _searchTalentsUseCase.execute(query: query));
  }

  /// Searches talents by skills only
  Future<void> searchBySkills(List<String> skills) async {
    if (skills.isEmpty) {
      await loadAllTalents();
      return;
    }

    await executeWithState(() => _searchTalentsUseCase.execute(skills: skills));
  }

  /// Searches talents by location only
  Future<void> searchByLocation({String? city, String? state}) async {
    if (city == null && state == null) {
      await loadAllTalents();
      return;
    }

    await executeWithState(
      () => _searchTalentsUseCase.execute(city: city, state: state),
    );
  }

  /// Clears search and reloads all talents
  Future<void> clearSearch() async {
    await loadAllTalents();
  }

  /// Gets the current list of talents (convenience getter)
  List<Talent> get talents => data ?? [];

  /// Checks if talents list is empty
  bool get hasTalents => talents.isNotEmpty;

  /// Gets talent count
  int get talentCount => talents.length;
}

/// Store for managing individual talent details
/// Separated for better organization and performance
class TalentDetailsStore extends BaseStore<Talent> {
  final GetTalentDetailsUseCase _getTalentDetailsUseCase;

  TalentDetailsStore() : _getTalentDetailsUseCase = getTalentDetailsUseCase;

  /// Loads talent details by name
  Future<void> loadTalentDetails(String name) async {
    if (name.trim().isEmpty) {
      setError('Talent name cannot be empty');
      return;
    }

    await executeWithState(() => _getTalentDetailsUseCase.execute(name));
  }

  /// Gets the current talent (convenience getter)
  Talent? get talent => data;

  /// Checks if talent is loaded
  bool get hasTalent => talent != null;
}
