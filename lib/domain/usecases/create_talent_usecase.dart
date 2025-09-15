import '../../core/services/talent_management_service_contract.dart';
import '../../core/utils/exceptions.dart';
import '../entities/talent.dart';

/// Use case for creating a new talent
/// Encapsulates the business logic for talent creation
class CreateTalentUseCase {
  final TalentManagementService _managementService;

  const CreateTalentUseCase(this._managementService);

  /// Executes talent creation
  ///
  /// Parameters:
  /// - [talent]: The talent to create
  ///
  /// Returns the created talent
  Future<Talent> execute(Talent talent) async {
    try {
      // Business rule: Validate talent data
      await _managementService.validateTalentData(talent);

      // Business rule: Ensure name is available
      final isAvailable = await _managementService.isTalentNameAvailable(
        talent.nome,
      );
      if (!isAvailable) {
        throw UseCaseException.businessRuleViolation(
          'Talent name "${talent.nome}" is already taken',
        );
      }

      // Business rule: Initialize with default values for new talent
      final newTalent = talent.copyWith(
        rating: 0.0,
        totalRatings: 0,
        ratings: [],
      );

      // Create talent
      final createdTalent = await _managementService.createTalent(newTalent);

      return createdTalent;
    } catch (e) {
      if (e is UseCaseException) rethrow;

      if (e is ServiceException) {
        throw UseCaseException(
          message: 'Failed to create talent: ${e.message}',
          code: 'CREATE_TALENT_FAILED',
        );
      }

      throw UseCaseException.businessRuleViolation('Create talent operation');
    }
  }
}
