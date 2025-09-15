/// Serviço mock para simulação de envio de códigos de verificação
class VerificationService {
  /// Simula o envio de um código de verificação via email
  static Future<bool> sendVerificationCodeByEmail(String email) async {
    // Simula delay de envio
    await Future.delayed(const Duration(seconds: 2));

    // Para demonstração, simula sucesso
    print('📧 Código de verificação enviado para: $email');
    return true;
  }

  /// Simula o envio de um código de verificação via SMS
  static Future<bool> sendVerificationCodeBySMS(String phone) async {
    // Simula delay de envio
    await Future.delayed(const Duration(seconds: 2));

    // Para demonstração, simula sucesso
    print('📱 Código de verificação enviado para: $phone');
    return true;
  }

  /// Simula a verificação de um código
  static Future<bool> verifyCode(String code) async {
    // Simula delay de verificação
    await Future.delayed(const Duration(seconds: 1));

    // Para demonstração, aceita qualquer código que termine com "0"
    return code.endsWith('0');
  }

  /// Gera um código de verificação aleatório de 4 dígitos
  static String generateCode() {
    return '1230'; // Código fixo para demonstração (termina com 0 para ser válido)
  }
}
