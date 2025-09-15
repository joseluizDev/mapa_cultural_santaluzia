import '../../domain/entities/talent.dart';
import '../../domain/repositories/talent_repository_contract.dart';
import '../utils/exceptions.dart';
import 'talent_management_service_contract.dart';

/// Concrete implementation of TalentManagementService
/// Follows dependency injection and single responsibility principles
class TalentManagementServiceImpl implements TalentManagementService {
  final TalentRepository _talentRepository;

  const TalentManagementServiceImpl(this._talentRepository);

  @override
  Future<List<Talent>> getAllTalents() async {
    try {
      return await _talentRepository.getAllTalents();
    } catch (e) {
      throw ServiceException.operationFailed('get all talents');
    }
  }

  @override
  Future<Talent?> getTalentByName(String name) async {
    try {
      _validateName(name);
      return await _talentRepository.getTalentByName(name);
    } catch (e) {
      if (e is ServiceException) rethrow;
      throw ServiceException.operationFailed('get talent by name');
    }
  }

  @override
  Future<Talent> createTalent(Talent talent) async {
    try {
      await validateTalentData(talent);

      final isAvailable = await isTalentNameAvailable(talent.nome);
      if (!isAvailable) {
        throw ServiceException.validationFailed(
          'Talent name "${talent.nome}" is already taken',
        );
      }

      return await _talentRepository.createTalent(talent);
    } catch (e) {
      if (e is ServiceException) rethrow;
      throw ServiceException.operationFailed('create talent');
    }
  }

  @override
  Future<Talent> updateTalent(Talent talent) async {
    try {
      await validateTalentData(talent);
      return await _talentRepository.updateTalent(talent);
    } catch (e) {
      if (e is ServiceException) rethrow;
      throw ServiceException.operationFailed('update talent');
    }
  }

  @override
  Future<void> deleteTalent(String name) async {
    try {
      _validateName(name);

      final existingTalent = await _talentRepository.getTalentByName(name);
      if (existingTalent == null) {
        throw ServiceException.validationFailed('Talent "$name" not found');
      }

      await _talentRepository.deleteTalent(name);
    } catch (e) {
      if (e is ServiceException) rethrow;
      throw ServiceException.operationFailed('delete talent');
    }
  }

  @override
  Future<bool> validateTalentData(Talent talent) async {
    try {
      // Validate name
      if (talent.nome.trim().isEmpty) {
        throw ServiceException.validationFailed('Talent name cannot be empty');
      }

      if (talent.nome.length < 2) {
        throw ServiceException.validationFailed(
          'Talent name must be at least 2 characters long',
        );
      }

      if (talent.nome.length > 100) {
        throw ServiceException.validationFailed(
          'Talent name cannot exceed 100 characters',
        );
      }

      // Validate city
      if (talent.cidade.trim().isEmpty) {
        throw ServiceException.validationFailed('City cannot be empty');
      }

      if (talent.cidade.length > 50) {
        throw ServiceException.validationFailed(
          'City name cannot exceed 50 characters',
        );
      }

      // Validate state
      if (talent.estado.trim().isEmpty) {
        throw ServiceException.validationFailed('State cannot be empty');
      }

      if (talent.estado.length > 50) {
        throw ServiceException.validationFailed(
          'State name cannot exceed 50 characters',
        );
      }

      // Validate description
      if (talent.descricao.trim().isEmpty) {
        throw ServiceException.validationFailed('Description cannot be empty');
      }

      if (talent.descricao.length < 10) {
        throw ServiceException.validationFailed(
          'Description must be at least 10 characters long',
        );
      }

      if (talent.descricao.length > 1000) {
        throw ServiceException.validationFailed(
          'Description cannot exceed 1000 characters',
        );
      }

      // Validate image URL
      if (talent.imagemUrl.trim().isEmpty) {
        throw ServiceException.validationFailed('Image URL cannot be empty');
      }

      if (!_isValidUrl(talent.imagemUrl)) {
        throw ServiceException.validationFailed('Invalid image URL format');
      }

      // Validate habilidades
      if (talent.habilidades.isEmpty) {
        throw ServiceException.validationFailed(
          'At least one skill must be provided',
        );
      }

      if (talent.habilidades.length > 10) {
        throw ServiceException.validationFailed(
          'Cannot have more than 10 skills',
        );
      }

      for (final habilidade in talent.habilidades) {
        if (habilidade.trim().isEmpty) {
          throw ServiceException.validationFailed('Skills cannot be empty');
        }

        if (habilidade.length > 50) {
          throw ServiceException.validationFailed(
            'Each skill cannot exceed 50 characters',
          );
        }
      }

      // Validate rating
      if (talent.rating < 0.0 || talent.rating > 5.0) {
        throw ServiceException.validationFailed(
          'Rating must be between 0.0 and 5.0',
        );
      }

      // Validate total ratings
      if (talent.totalRatings < 0) {
        throw ServiceException.validationFailed(
          'Total ratings cannot be negative',
        );
      }

      // Validate ratings consistency
      if (talent.ratings.length != talent.totalRatings) {
        throw ServiceException.validationFailed(
          'Ratings list length must match total ratings count',
        );
      }

      return true;
    } catch (e) {
      if (e is ServiceException) rethrow;
      throw ServiceException.validationFailed('Talent validation failed');
    }
  }

  @override
  Future<bool> isTalentNameAvailable(String name) async {
    try {
      _validateName(name);
      final existingTalent = await _talentRepository.getTalentByName(name);
      return existingTalent == null;
    } catch (e) {
      throw ServiceException.operationFailed('check talent name availability');
    }
  }

  @override
  Future<Map<String, dynamic>> getTalentStatistics() async {
    try {
      final talents = await _talentRepository.getAllTalents();

      if (talents.isEmpty) {
        return {
          'totalTalents': 0,
          'averageRating': 0.0,
          'topSkills': <String>[],
          'citiesDistribution': <String, int>{},
          'statesDistribution': <String, int>{},
          'ratingDistribution': <String, int>{},
        };
      }

      // Calculate statistics
      final totalTalents = talents.length;

      final totalRating = talents.fold<double>(
        0.0,
        (sum, talent) => sum + talent.rating,
      );
      final averageRating = totalRating / totalTalents;

      // Get top skills
      final skillCounts = <String, int>{};
      for (final talent in talents) {
        for (final skill in talent.habilidades) {
          skillCounts[skill] = (skillCounts[skill] ?? 0) + 1;
        }
      }

      final topSkills = skillCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // Get cities distribution
      final citiesDistribution = <String, int>{};
      for (final talent in talents) {
        citiesDistribution[talent.cidade] =
            (citiesDistribution[talent.cidade] ?? 0) + 1;
      }

      // Get states distribution
      final statesDistribution = <String, int>{};
      for (final talent in talents) {
        statesDistribution[talent.estado] =
            (statesDistribution[talent.estado] ?? 0) + 1;
      }

      // Get rating distribution
      final ratingDistribution = <String, int>{
        '0-1': 0,
        '1-2': 0,
        '2-3': 0,
        '3-4': 0,
        '4-5': 0,
      };

      for (final talent in talents) {
        if (talent.rating >= 0 && talent.rating < 1) {
          ratingDistribution['0-1'] = ratingDistribution['0-1']! + 1;
        } else if (talent.rating >= 1 && talent.rating < 2) {
          ratingDistribution['1-2'] = ratingDistribution['1-2']! + 1;
        } else if (talent.rating >= 2 && talent.rating < 3) {
          ratingDistribution['2-3'] = ratingDistribution['2-3']! + 1;
        } else if (talent.rating >= 3 && talent.rating < 4) {
          ratingDistribution['3-4'] = ratingDistribution['3-4']! + 1;
        } else if (talent.rating >= 4 && talent.rating <= 5) {
          ratingDistribution['4-5'] = ratingDistribution['4-5']! + 1;
        }
      }

      return {
        'totalTalents': totalTalents,
        'averageRating': averageRating,
        'topSkills': topSkills.take(10).map((e) => e.key).toList(),
        'citiesDistribution': citiesDistribution,
        'statesDistribution': statesDistribution,
        'ratingDistribution': ratingDistribution,
      };
    } catch (e) {
      throw ServiceException.operationFailed('get talent statistics');
    }
  }

  /// Validates that the name is not empty and meets basic requirements
  void _validateName(String name) {
    if (name.trim().isEmpty) {
      throw ServiceException.validationFailed('Name cannot be empty');
    }
  }

  /// Validates if a string is a valid URL
  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
