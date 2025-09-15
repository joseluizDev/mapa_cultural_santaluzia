import '../../domain/entities/talent.dart';
import '../../domain/repositories/talent_repository_contract.dart';
import '../utils/exceptions.dart';
import 'talent_search_service_contract.dart';

/// Concrete implementation of TalentSearchService
/// Follows dependency injection and single responsibility principles
class TalentSearchServiceImpl implements TalentSearchService {
  final TalentRepository _talentRepository;

  const TalentSearchServiceImpl(this._talentRepository);

  @override
  Future<List<Talent>> searchTalents({
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  }) async {
    try {
      List<Talent> results = [];

      // If no search criteria provided, return all talents
      if (_isEmptySearchCriteria(query, skills, city, state)) {
        return await _talentRepository.getAllTalents();
      }

      // Start with all talents
      results = await _talentRepository.getAllTalents();

      // Filter by name if query provided
      if (query != null && query.trim().isNotEmpty) {
        final nameResults = await _talentRepository.searchTalentsByName(query);
        results = _intersectTalentLists(results, nameResults);
      }

      // Filter by skills if provided
      if (skills != null && skills.isNotEmpty) {
        final skillResults = await _talentRepository.searchTalentsBySkills(
          skills,
        );
        results = _intersectTalentLists(results, skillResults);
      }

      // Filter by location if provided
      if (city != null || state != null) {
        final locationResults = await _talentRepository.searchTalentsByLocation(
          city: city,
          state: state,
        );
        results = _intersectTalentLists(results, locationResults);
      }

      return results;
    } catch (e) {
      if (e is RepositoryException) {
        throw ServiceException(
          message: 'Search operation failed: ${e.message}',
          code: 'SEARCH_FAILED',
        );
      }

      throw ServiceException.operationFailed('talent search');
    }
  }

  @override
  Future<List<Talent>> searchByName(String query) async {
    try {
      if (query.trim().isEmpty) {
        return [];
      }

      return await _talentRepository.searchTalentsByName(query);
    } catch (e) {
      throw ServiceException.operationFailed('name search');
    }
  }

  @override
  Future<List<Talent>> searchBySkills(List<String> skills) async {
    try {
      if (skills.isEmpty) {
        return [];
      }

      return await _talentRepository.searchTalentsBySkills(skills);
    } catch (e) {
      throw ServiceException.operationFailed('skills search');
    }
  }

  @override
  Future<List<Talent>> searchByLocation({String? city, String? state}) async {
    try {
      return await _talentRepository.searchTalentsByLocation(
        city: city,
        state: state,
      );
    } catch (e) {
      throw ServiceException.operationFailed('location search');
    }
  }

  @override
  Future<List<String>> getNameSuggestions(String query) async {
    try {
      if (query.trim().isEmpty) {
        return [];
      }

      final talents = await _talentRepository.searchTalentsByName(query);
      return talents.map((talent) => talent.nome).toList();
    } catch (e) {
      throw ServiceException.operationFailed('name suggestions');
    }
  }

  @override
  Future<List<String>> getAllAvailableSkills() async {
    try {
      final talents = await _talentRepository.getAllTalents();
      final allSkills = <String>{};

      for (final talent in talents) {
        allSkills.addAll(talent.habilidades);
      }

      final skillsList = allSkills.toList()..sort();
      return skillsList;
    } catch (e) {
      throw ServiceException.operationFailed('get available skills');
    }
  }

  @override
  Future<Map<String, List<String>>> getAllAvailableLocations() async {
    try {
      final talents = await _talentRepository.getAllTalents();
      final locationMap = <String, Set<String>>{};

      for (final talent in talents) {
        final state = talent.estado;
        if (!locationMap.containsKey(state)) {
          locationMap[state] = <String>{};
        }
        locationMap[state]!.add(talent.cidade);
      }

      // Convert sets to sorted lists
      final result = <String, List<String>>{};
      for (final entry in locationMap.entries) {
        result[entry.key] = entry.value.toList()..sort();
      }

      return result;
    } catch (e) {
      throw ServiceException.operationFailed('get available locations');
    }
  }

  /// Helper method to check if search criteria is empty
  bool _isEmptySearchCriteria(
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  ) {
    return (query == null || query.trim().isEmpty) &&
        (skills == null || skills.isEmpty) &&
        city == null &&
        state == null;
  }

  /// Helper method to intersect two talent lists
  List<Talent> _intersectTalentLists(List<Talent> list1, List<Talent> list2) {
    return list1
        .where(
          (talent1) => list2.any((talent2) => talent1.nome == talent2.nome),
        )
        .toList();
  }
}
