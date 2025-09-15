import '../../core/utils/exceptions.dart';
import '../../domain/entities/talent.dart';
import '../../domain/repositories/talent_repository_contract.dart';
import '../../mock/talents_mock.dart';

/// Concrete implementation of TalentRepository for mock data
/// Follows Dependency Inversion Principle by implementing the abstract contract
class MockTalentRepository implements TalentRepository {
  final List<Talent> _talents = [];
  bool _isInitialized = false;

  /// Initialize repository with mock data
  void _initializeIfNeeded() {
    if (!_isInitialized) {
      _talents.addAll(getMockTalents());
      _isInitialized = true;
    }
  }

  @override
  Future<List<Talent>> getAllTalents() async {
    try {
      _initializeIfNeeded();
      return List.from(_talents);
    } catch (e) {
      throw RepositoryException(
        message: 'Failed to retrieve all talents: ${e.toString()}',
        code: 'GET_ALL_TALENTS_FAILED',
      );
    }
  }

  @override
  Future<Talent?> getTalentByName(String name) async {
    try {
      _initializeIfNeeded();

      if (name.isEmpty) {
        throw RepositoryException(
          message: 'Talent name cannot be empty',
          code: 'INVALID_NAME',
        );
      }

      final talent = _talents
          .where((t) => t.nome.toLowerCase() == name.toLowerCase())
          .firstOrNull;

      return talent;
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to retrieve talent by name: ${e.toString()}',
        code: 'GET_TALENT_BY_NAME_FAILED',
      );
    }
  }

  @override
  Future<List<Talent>> searchTalentsBySkills(List<String> skills) async {
    try {
      _initializeIfNeeded();

      if (skills.isEmpty) {
        return [];
      }

      final normalizedSkills = skills
          .map((skill) => skill.toLowerCase().trim())
          .toList();

      final filteredTalents = _talents.where((talent) {
        return talent.habilidades.any(
          (habilidade) => normalizedSkills.any(
            (skill) => habilidade.toLowerCase().contains(skill),
          ),
        );
      }).toList();

      return filteredTalents;
    } catch (e) {
      throw RepositoryException(
        message: 'Failed to search talents by skills: ${e.toString()}',
        code: 'SEARCH_BY_SKILLS_FAILED',
      );
    }
  }

  @override
  Future<List<Talent>> searchTalentsByLocation({
    String? city,
    String? state,
  }) async {
    try {
      _initializeIfNeeded();

      if (city == null && state == null) {
        return await getAllTalents();
      }

      final filteredTalents = _talents.where((talent) {
        final cityMatch =
            city == null ||
            talent.cidade.toLowerCase().contains(city.toLowerCase());
        final stateMatch =
            state == null ||
            talent.estado.toLowerCase().contains(state.toLowerCase());

        return cityMatch && stateMatch;
      }).toList();

      return filteredTalents;
    } catch (e) {
      throw RepositoryException(
        message: 'Failed to search talents by location: ${e.toString()}',
        code: 'SEARCH_BY_LOCATION_FAILED',
      );
    }
  }

  @override
  Future<List<Talent>> searchTalentsByName(String query) async {
    try {
      _initializeIfNeeded();

      if (query.isEmpty) {
        return await getAllTalents();
      }

      final normalizedQuery = query.toLowerCase().trim();

      final filteredTalents = _talents
          .where(
            (talent) => talent.nome.toLowerCase().contains(normalizedQuery),
          )
          .toList();

      return filteredTalents;
    } catch (e) {
      throw RepositoryException(
        message: 'Failed to search talents by name: ${e.toString()}',
        code: 'SEARCH_BY_NAME_FAILED',
      );
    }
  }

  @override
  Future<Talent> createTalent(Talent talent) async {
    try {
      _initializeIfNeeded();

      // Check if talent with same name already exists
      final existingTalent = await getTalentByName(talent.nome);
      if (existingTalent != null) {
        throw RepositoryException(
          message: 'Talent with name "${talent.nome}" already exists',
          code: 'TALENT_ALREADY_EXISTS',
        );
      }

      _talents.add(talent);
      return talent;
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to create talent: ${e.toString()}',
        code: 'CREATE_TALENT_FAILED',
      );
    }
  }

  @override
  Future<Talent> updateTalent(Talent talent) async {
    try {
      _initializeIfNeeded();

      final index = _talents.indexWhere((t) => t.nome == talent.nome);
      if (index == -1) {
        throw RepositoryException.dataNotFound('Talent "${talent.nome}"');
      }

      _talents[index] = talent;
      return talent;
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to update talent: ${e.toString()}',
        code: 'UPDATE_TALENT_FAILED',
      );
    }
  }

  @override
  Future<void> deleteTalent(String name) async {
    try {
      _initializeIfNeeded();

      final index = _talents.indexWhere((t) => t.nome == name);
      if (index == -1) {
        throw RepositoryException.dataNotFound('Talent "$name"');
      }

      _talents.removeAt(index);
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to delete talent: ${e.toString()}',
        code: 'DELETE_TALENT_FAILED',
      );
    }
  }

  @override
  Future<Talent> addRatingToTalent(String talentName, Rating rating) async {
    try {
      final talent = await getTalentByName(talentName);
      if (talent == null) {
        throw RepositoryException.dataNotFound('Talent "$talentName"');
      }

      final updatedRatings = List<Rating>.from(talent.ratings)..add(rating);

      // Calculate new average rating
      final totalRating = updatedRatings.fold<double>(
        0.0,
        (sum, r) => sum + r.rating,
      );
      final newAverageRating = totalRating / updatedRatings.length;

      final updatedTalent = talent.copyWith(
        ratings: updatedRatings,
        rating: newAverageRating,
        totalRatings: updatedRatings.length,
      );

      return await updateTalent(updatedTalent);
    } catch (e) {
      if (e is RepositoryException) rethrow;

      throw RepositoryException(
        message: 'Failed to add rating to talent: ${e.toString()}',
        code: 'ADD_RATING_FAILED',
      );
    }
  }
}
