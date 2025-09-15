import '../entities/talent.dart';

/// Abstract repository for talent-related operations
/// Following Interface Segregation Principle - focused on talent operations only
abstract class TalentRepository {
  /// Retrieves all talents from the data source
  /// Returns a Future containing a list of talents
  Future<List<Talent>> getAllTalents();

  /// Retrieves a talent by their unique name
  /// Returns a Future containing the talent or null if not found
  Future<Talent?> getTalentByName(String name);

  /// Searches talents by habilidades (skills)
  /// Returns a Future containing a filtered list of talents
  Future<List<Talent>> searchTalentsBySkills(List<String> skills);

  /// Searches talents by location (city and/or state)
  /// Returns a Future containing a filtered list of talents
  Future<List<Talent>> searchTalentsByLocation({String? city, String? state});

  /// Searches talents by name (partial match)
  /// Returns a Future containing a filtered list of talents
  Future<List<Talent>> searchTalentsByName(String query);

  /// Adds a new talent to the repository
  /// Returns a Future containing the created talent
  Future<Talent> createTalent(Talent talent);

  /// Updates an existing talent
  /// Returns a Future containing the updated talent
  Future<Talent> updateTalent(Talent talent);

  /// Deletes a talent by name
  /// Returns a Future indicating success
  Future<void> deleteTalent(String name);

  /// Adds a rating to a talent
  /// Returns a Future containing the updated talent
  Future<Talent> addRatingToTalent(String talentName, Rating rating);
}
