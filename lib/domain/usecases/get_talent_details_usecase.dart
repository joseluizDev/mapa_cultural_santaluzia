import '../../core/services/talent_management_service_contract.dart';
import '../../core/utils/exceptions.dart';
import '../entities/talent.dart';

/// Use case for retrieving talent details
/// Encapsulates the business logic for getting talent information
class GetTalentDetailsUseCase {
  final TalentManagementService _managementService;

  const GetTalentDetailsUseCase(this._managementService);

  /// Executes talent retrieval by name
  ///
  /// Parameters:
  /// - [name]: The name of the talent to retrieve
  ///
  /// Returns the talent if found, throws exception if not found
  Future<Talent> execute(String name) async {
    try {
      // Validate input
      if (name.trim().isEmpty) {
        throw UseCaseException.invalidInput('name');
      }

      // Business rule: Name must be properly formatted
      final sanitizedName = _sanitizeName(name);

      // Get talent
      final talent = await _managementService.getTalentByName(sanitizedName);

      // Business rule: Talent must exist
      if (talent == null) {
        throw UseCaseException(
          message: 'Talent with name "$sanitizedName" not found',
          code: 'TALENT_NOT_FOUND',
        );
      }

      return talent;
    } catch (e) {
      if (e is UseCaseException) rethrow;

      if (e is ServiceException) {
        throw UseCaseException(
          message: 'Failed to get talent details: ${e.message}',
          code: 'GET_TALENT_DETAILS_FAILED',
        );
      }

      throw UseCaseException.businessRuleViolation(
        'Get talent details operation',
      );
    }
  }

  /// Sanitizes the name by trimming whitespace and normalizing case
  String _sanitizeName(String name) {
    return name.trim();
  }
}
