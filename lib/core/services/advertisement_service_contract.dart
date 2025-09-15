import '../../domain/entities/advertisement.dart';

/// Abstract service for advertisement management operations
/// Following Single Responsibility Principle - focused only on advertisement functionality
abstract class AdvertisementService {
  /// Retrieves all active advertisements
  /// Returns a list of currently active advertisements
  Future<List<Advertisement>> getActiveAdvertisements();

  /// Retrieves all advertisements (active and inactive)
  /// Returns a list of all advertisements
  Future<List<Advertisement>> getAllAdvertisements();

  /// Creates a new advertisement
  /// Validates the advertisement data before creation
  /// Returns the created advertisement
  Future<Advertisement> createAdvertisement(Advertisement advertisement);

  /// Updates an existing advertisement
  /// Validates the updated data
  /// Returns the updated advertisement
  Future<Advertisement> updateAdvertisement(Advertisement advertisement);

  /// Deletes an advertisement by name
  /// Performs any necessary cleanup operations
  Future<void> deleteAdvertisement(String name);

  /// Activates an advertisement
  /// Returns the activated advertisement
  Future<Advertisement> activateAdvertisement(String name);

  /// Deactivates an advertisement
  /// Returns the deactivated advertisement
  Future<Advertisement> deactivateAdvertisement(String name);

  /// Validates advertisement data according to business rules
  /// Returns true if valid, throws exception if invalid
  Future<bool> validateAdvertisementData(Advertisement advertisement);

  /// Gets expired advertisements
  /// Returns a list of advertisements that have passed their end date
  Future<List<Advertisement>> getExpiredAdvertisements();

  /// Gets advertisements that are expiring soon
  /// Returns a list of advertisements expiring within the specified days
  Future<List<Advertisement>> getExpiringSoonAdvertisements({int days = 7});

  /// Cleans up expired advertisements
  /// Automatically deactivates advertisements that have expired
  Future<int> cleanupExpiredAdvertisements();
}
