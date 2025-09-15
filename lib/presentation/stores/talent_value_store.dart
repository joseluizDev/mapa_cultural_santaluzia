import '../../core/state/value_store.dart';
import '../../domain/entities/talent.dart';
import '../../domain/usecases/get_all_talents_usecase.dart';
import '../../domain/usecases/search_talents_usecase.dart';

/// Talent store using ValueNotifier pattern
/// Follows clear separation between functions and state management
class TalentValueStore extends Store<List<Talent>> {
  // Use cases (business logic)
  final GetAllTalentsUseCase _getAllTalentsUseCase;
  final SearchTalentsUseCase _searchTalentsUseCase;

  TalentValueStore({
    required GetAllTalentsUseCase getAllTalentsUseCase,
    required SearchTalentsUseCase searchTalentsUseCase,
  }) : _getAllTalentsUseCase = getAllTalentsUseCase,
       _searchTalentsUseCase = searchTalentsUseCase;

  /// Load all talents with automatic state handling
  Future<void> loadAllTalents() async {
    await execute(() => _getAllTalentsUseCase.execute());
  }

  /// Search talents with filters
  Future<void> searchTalents({
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  }) async {
    await execute(
      () => _searchTalentsUseCase.execute(
        query: query,
        skills: skills,
        city: city,
        state: state,
      ),
    );
  }

  /// Search by name only
  Future<void> searchByName(String query) async {
    if (query.trim().isEmpty) {
      await loadAllTalents();
      return;
    }

    await execute(() => _searchTalentsUseCase.execute(query: query));
  }

  /// Search by skills only
  Future<void> searchBySkills(List<String> skills) async {
    if (skills.isEmpty) {
      await loadAllTalents();
      return;
    }

    await execute(() => _searchTalentsUseCase.execute(skills: skills));
  }

  /// Search by location only
  Future<void> searchByLocation({String? city, String? state}) async {
    if (city == null && state == null) {
      await loadAllTalents();
      return;
    }

    await execute(
      () => _searchTalentsUseCase.execute(city: city, state: state),
    );
  }

  /// Clear search and reload all talents
  Future<void> clearSearch() async {
    await loadAllTalents();
  }

  /// Convenience getters
  List<Talent> get talents => data ?? [];
  bool get hasTalents => talents.isNotEmpty;
  int get talentCount => talents.length;
}
