import 'package:mapa_cultural_santaluzia/core/services/verification_service.dart';
import 'package:mapa_cultural_santaluzia/domain/entities/user.dart';

class RegisterUseCase {
  // In a real app, this would depend on a repository

  Future<bool> sendVerificationCode(String contact, String contactType) async {
    try {
      if (contactType == 'email') {
        return await VerificationService.sendVerificationCodeByEmail(contact);
      } else {
        return await VerificationService.sendVerificationCodeBySMS(contact);
      }
    } catch (e) {
      print('Error sending verification code: $e');
      return false;
    }
  }

  Future<bool> verifyCode(String code) async {
    try {
      return await VerificationService.verifyCode(code);
    } catch (e) {
      print('Error verifying code: $e');
      return false;
    }
  }

  // Mock function to simulate creating a user
  Future<User?> register({
    required String contact,
    required String contactType,
    required String name,
    required String cpf,
    required String age,
    required String city,
    required String description,
    required List<String> activities,
  }) async {
    try {
      // Simulate a delay like a network request
      await Future.delayed(const Duration(seconds: 2));

      // Create a new user with completed profile
      return User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        contact: contact,
        contactType: contactType,
        name: name,
        cpf: cpf,
        age: age,
        city: city,
        description: description,
        activities: activities,
        isProfileComplete: true,
      );
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }
}
