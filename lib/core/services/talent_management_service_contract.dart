import '../../domain/entities/talent.dart';

/// Abstract service for talent management operations
/// Following Single Responsibility Principle - focused only on CRUD operations
abstract class TalentManagementService {
  /// Retrieves all talents
  /// Returns a list of all available talents
  Future<List<Talent>> getAllTalents();

  /// Retrieves a specific talent by name
  /// Returns the talent if found, null otherwise
  Future<Talent?> getTalentByName(String name);

  /// Creates a new talent
  /// Validates the talent data before creation
  /// Returns the created talent
  Future<Talent> createTalent(Talent talent);

  /// Updates an existing talent
  /// Validates the updated data
  /// Returns the updated talent
  Future<Talent> updateTalent(Talent talent);

  /// Deletes a talent by name
  /// Performs any necessary cleanup operations
  Future<void> deleteTalent(String name);

  /// Validates talent data according to business rules
  /// Returns true if valid, throws exception if invalid
  Future<bool> validateTalentData(Talent talent);

  /// Checks if a talent name is available (not taken)
  /// Returns true if available, false if taken
  Future<bool> isTalentNameAvailable(String name);

  /// Gets talent statistics
  /// Returns a map with various statistics about talents
  Future<Map<String, dynamic>> getTalentStatistics();
}
