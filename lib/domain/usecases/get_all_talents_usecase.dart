import '../../core/services/talent_management_service_contract.dart';
import '../../core/utils/exceptions.dart';
import '../entities/talent.dart';

/// Use case for retrieving all talents
/// Encapsulates the business logic for listing talents
class GetAllTalentsUseCase {
  final TalentManagementService _managementService;

  const GetAllTalentsUseCase(this._managementService);

  /// Executes talent list retrieval
  ///
  /// Returns a list of all talents sorted by rating (highest first)
  Future<List<Talent>> execute() async {
    try {
      // Get all talents
      final talents = await _managementService.getAllTalents();

      // Business rule: Sort talents by rating (highest first), then by name
      talents.sort((a, b) {
        final ratingComparison = b.rating.compareTo(a.rating);
        if (ratingComparison != 0) return ratingComparison;
        return a.nome.compareTo(b.nome);
      });

      return talents;
    } catch (e) {
      if (e is ServiceException) {
        throw UseCaseException(
          message: 'Failed to get all talents: ${e.message}',
          code: 'GET_ALL_TALENTS_FAILED',
        );
      }

      throw UseCaseException.businessRuleViolation('Get all talents operation');
    }
  }
}
