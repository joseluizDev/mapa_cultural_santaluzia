import '../entities/advertisement.dart';

/// Abstract repository for advertisement-related operations
/// Following Interface Segregation Principle - focused on advertisement operations only
abstract class AdvertisementRepository {
  /// Retrieves all active advertisements
  /// Returns a Future containing a list of active advertisements
  Future<List<Advertisement>> getActiveAdvertisements();

  /// Retrieves all advertisements (active and inactive)
  /// Returns a Future containing a list of all advertisements
  Future<List<Advertisement>> getAllAdvertisements();

  /// Retrieves an advertisement by its unique name
  /// Returns a Future containing the advertisement or null if not found
  Future<Advertisement?> getAdvertisementByName(String name);

  /// Creates a new advertisement
  /// Returns a Future containing the created advertisement
  Future<Advertisement> createAdvertisement(Advertisement advertisement);

  /// Updates an existing advertisement
  /// Returns a Future containing the updated advertisement
  Future<Advertisement> updateAdvertisement(Advertisement advertisement);

  /// Deletes an advertisement by name
  /// Returns a Future indicating success
  Future<void> deleteAdvertisement(String name);

  /// Activates an advertisement
  /// Returns a Future containing the updated advertisement
  Future<Advertisement> activateAdvertisement(String name);

  /// Deactivates an advertisement
  /// Returns a Future containing the updated advertisement
  Future<Advertisement> deactivateAdvertisement(String name);
}
