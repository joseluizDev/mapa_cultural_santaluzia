import '../../domain/entities/talent.dart';

/// Abstract service for rating and review operations
/// Following Single Responsibility Principle - focused only on rating functionality
abstract class RatingService {
  /// Adds a rating to a talent
  /// Validates the rating data and updates the talent's average rating
  /// Returns the updated talent
  Future<Talent> addRating(String talentName, Rating rating);

  /// Gets all ratings for a specific talent
  /// Returns a list of ratings for the talent
  Future<List<Rating>> getRatingsForTalent(String talentName);

  /// Calculates the average rating for a talent
  /// Returns the average rating value
  Future<double> calculateAverageRating(String talentName);

  /// Validates rating data according to business rules
  /// Returns true if valid, throws exception if invalid
  Future<bool> validateRating(Rating rating);

  /// Gets top-rated talents
  /// Returns a list of talents sorted by rating (highest first)
  Future<List<Talent>> getTopRatedTalents({int limit = 10});

  /// Gets recent ratings across all talents
  /// Returns the most recent ratings with talent information
  Future<List<Map<String, dynamic>>> getRecentRatings({int limit = 20});

  /// Checks if a user has already rated a talent
  /// Returns true if user has already rated, false otherwise
  Future<bool> hasUserRatedTalent(String userId, String talentName);

  /// Gets rating statistics
  /// Returns statistics about ratings (average, distribution, etc.)
  Future<Map<String, dynamic>> getRatingStatistics();
}
