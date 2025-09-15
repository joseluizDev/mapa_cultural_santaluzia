import '../../core/utils/exceptions.dart';
import '../../domain/entities/advertisement.dart';
import '../../domain/repositories/advertisement_repository_contract.dart';

/// Concrete implementation of AdvertisementRepository for mock data
/// Follows Dependency Inversion Principle by implementing the abstract contract
class MockAdvertisementRepository implements AdvertisementRepository {
  final List<Advertisement> _advertisements = [
    Advertisement(
      nome: 'Festivais Culturais 2024',
      imagemUrl: 'https://example.com/festival-image.jpg',
      dataInicio: DateTime.now(),
      dataFim: DateTime.now().add(const Duration(days: 30)),
      ativa: true,
    ),
    Advertisement(
      nome: 'Curso de Artesanato',
      imagemUrl: 'https://example.com/artesanato-image.jpg',
      dataInicio: DateTime.now().subtract(const Duration(days: 5)),
      dataFim: DateTime.now().add(const Duration(days: 15)),
      ativa: true,
    ),
    Advertisement(
      nome: 'Evento Passado',
      imagemUrl: 'https://example.com/evento-passado.jpg',
      dataInicio: DateTime.now().subtract(const Duration(days: 45)),
      dataFim: DateTime.now().subtract(const Duration(days: 15)),
      ativa: false,
    ),
  ];

  @override
  Future<List<Advertisement>> getActiveAdvertisements() async {
    try {
      final activeAds = _advertisements
          .where((ad) => ad.ativa && ad.dataFim.isAfter(DateTime.now()))
          .toList();

      return activeAds;
    } catch (e) {
      throw RepositoryException(
        message: 'Failed to retrieve active advertisements: ${e.toString()}',
        code: 'GET_ACTIVE_ADS_FAILED',
      );
    }
  }

  @override
  Future<List<Advertisement>> getAllAdvertisements() async {
    try {
      return List.from(_advertisements);
    } catch (e) {
      throw RepositoryException(
        message: 'Failed to retrieve all advertisements: ${e.toString()}',
        code: 'GET_ALL_ADS_FAILED',
      );
    }
  }

  @override
  Future<Advertisement?> getAdvertisementByName(String name) async {
    try {
      if (name.isEmpty) {
        throw RepositoryException(
          message: 'Advertisement name cannot be empty',
          code: 'INVALID_NAME',
        );
      }

      final advertisement = _advertisements
          .where((ad) => ad.nome.toLowerCase() == name.toLowerCase())
          .firstOrNull;

      return advertisement;
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to retrieve advertisement by name: ${e.toString()}',
        code: 'GET_AD_BY_NAME_FAILED',
      );
    }
  }

  @override
  Future<Advertisement> createAdvertisement(Advertisement advertisement) async {
    try {
      // Check if advertisement with same name already exists
      final existingAd = await getAdvertisementByName(advertisement.nome);
      if (existingAd != null) {
        throw RepositoryException(
          message:
              'Advertisement with name "${advertisement.nome}" already exists',
          code: 'ADVERTISEMENT_ALREADY_EXISTS',
        );
      }

      _advertisements.add(advertisement);
      return advertisement;
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to create advertisement: ${e.toString()}',
        code: 'CREATE_AD_FAILED',
      );
    }
  }

  @override
  Future<Advertisement> updateAdvertisement(Advertisement advertisement) async {
    try {
      final index = _advertisements.indexWhere(
        (ad) => ad.nome == advertisement.nome,
      );
      if (index == -1) {
        throw RepositoryException.dataNotFound(
          'Advertisement "${advertisement.nome}"',
        );
      }

      _advertisements[index] = advertisement;
      return advertisement;
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to update advertisement: ${e.toString()}',
        code: 'UPDATE_AD_FAILED',
      );
    }
  }

  @override
  Future<void> deleteAdvertisement(String name) async {
    try {
      final index = _advertisements.indexWhere((ad) => ad.nome == name);
      if (index == -1) {
        throw RepositoryException.dataNotFound('Advertisement "$name"');
      }

      _advertisements.removeAt(index);
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to delete advertisement: ${e.toString()}',
        code: 'DELETE_AD_FAILED',
      );
    }
  }

  @override
  Future<Advertisement> activateAdvertisement(String name) async {
    try {
      final advertisement = await getAdvertisementByName(name);
      if (advertisement == null) {
        throw RepositoryException.dataNotFound('Advertisement "$name"');
      }

      final updatedAd = Advertisement(
        nome: advertisement.nome,
        imagemUrl: advertisement.imagemUrl,
        dataInicio: advertisement.dataInicio,
        dataFim: advertisement.dataFim,
        ativa: true,
      );

      return await updateAdvertisement(updatedAd);
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to activate advertisement: ${e.toString()}',
        code: 'ACTIVATE_AD_FAILED',
      );
    }
  }

  @override
  Future<Advertisement> deactivateAdvertisement(String name) async {
    try {
      final advertisement = await getAdvertisementByName(name);
      if (advertisement == null) {
        throw RepositoryException.dataNotFound('Advertisement "$name"');
      }

      final updatedAd = Advertisement(
        nome: advertisement.nome,
        imagemUrl: advertisement.imagemUrl,
        dataInicio: advertisement.dataInicio,
        dataFim: advertisement.dataFim,
        ativa: false,
      );

      return await updateAdvertisement(updatedAd);
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to deactivate advertisement: ${e.toString()}',
        code: 'DEACTIVATE_AD_FAILED',
      );
    }
  }
}
