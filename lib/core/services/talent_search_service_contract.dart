import '../../domain/entities/talent.dart';

/// Abstract service for talent search operations
/// Following Single Responsibility Principle - focused only on search functionality
abstract class TalentSearchService {
  /// Performs a comprehensive search across all talent attributes
  /// Returns talents that match the query in name, skills, or location
  Future<List<Talent>> searchTalents({
    String? query,
    List<String>? skills,
    String? city,
    String? state,
  });

  /// Performs a fuzzy search by talent name
  /// Returns talents with names similar to the query
  Future<List<Talent>> searchByName(String query);

  /// Searches talents by specific skills/habilidades
  /// Returns talents that have any of the specified skills
  Future<List<Talent>> searchBySkills(List<String> skills);

  /// Searches talents by location
  /// Returns talents from the specified city and/or state
  Future<List<Talent>> searchByLocation({String? city, String? state});

  /// Gets suggestions for autocomplete based on talent names
  /// Returns a list of talent names that start with the query
  Future<List<String>> getNameSuggestions(String query);

  /// Gets all unique skills/habilidades available
  /// Returns a list of all skills from all talents
  Future<List<String>> getAllAvailableSkills();

  /// Gets all unique locations available
  /// Returns a list of cities and states from all talents
  Future<Map<String, List<String>>> getAllAvailableLocations();
}
