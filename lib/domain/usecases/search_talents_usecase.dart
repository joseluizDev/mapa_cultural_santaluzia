import '../../core/services/talent_search_service_contract.dart';
import '../../core/utils/exceptions.dart';
import '../entities/talent.dart';

/// Use case for searching talents
/// Encapsulates the business logic for talent search operations
class SearchTalentsUseCase {
  final TalentSearchService _searchService;

  const SearchTalentsUseCase(this._searchService);

  /// Executes comprehensive talent search
  ///
  /// Parameters:
  /// - [query]: General search query (optional)
  /// - [skills]: List of skills to filter by (optional)
  /// - [city]: City to filter by (optional)
  /// - [state]: State to filter by (optional)
  ///
  /// Returns a list of talents matching the search criteria
  Future<List<Talent>> execute({
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  }) async {
    try {
      // Validate and sanitize input
      final sanitizedQuery = query?.trim();
      final sanitizedSkills = skills
          ?.where((s) => s.trim().isNotEmpty)
          .toList();
      final sanitizedCity = city?.trim();
      final sanitizedState = state?.trim();

      // Business rule: At least one search criterion must be provided
      if (_isEmptySearch(
        sanitizedQuery,
        sanitizedSkills,
        sanitizedCity,
        sanitizedState,
      )) {
        // If no criteria, return all talents (business decision)
        return await _searchService.searchTalents();
      }

      // Execute search
      final results = await _searchService.searchTalents(
        query: sanitizedQuery,
        skills: sanitizedSkills,
        city: sanitizedCity,
        state: sanitizedState,
      );

      // Business rule: Sort results by rating (highest first)
      results.sort((a, b) => b.rating.compareTo(a.rating));

      return results;
    } catch (e) {
      if (e is ServiceException) {
        throw UseCaseException(
          message: 'Failed to search talents: ${e.message}',
          code: 'SEARCH_TALENTS_FAILED',
        );
      }

      throw UseCaseException.businessRuleViolation('Talent search operation');
    }
  }

  /// Helper method to check if search criteria is empty
  bool _isEmptySearch(
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  ) {
    return (query == null || query.isEmpty) &&
        (skills == null || skills.isEmpty) &&
        (city == null || city.isEmpty) &&
        (state == null || state.isEmpty);
  }
}
