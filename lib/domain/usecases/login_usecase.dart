import 'package:mapa_cultural_santaluzia/core/services/verification_service.dart';
import 'package:mapa_cultural_santaluzia/domain/entities/user.dart';

class LoginUseCase {
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

  // Mock function to simulate login
  Future<User?> login(String contact, String contactType) async {
    try {
      // Simulate a delay like a network request
      await Future.delayed(const Duration(seconds: 1));

      // Create a mock user with a completed profile for demo purposes
      return User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        contact: contact,
        contactType: contactType,
        isProfileComplete: true,
        name: 'Usuário Demo',
        city: 'Santa Luzia',
        activities: ['Música', 'Arte'],
      );
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }
}
