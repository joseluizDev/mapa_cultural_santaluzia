import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/services/verification_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _gradientController;
  late AnimationController _floatController1;
  late AnimationController _floatController2;
  late AnimationController _floatController3;

  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _isEmailSelected = true; // Controla se email ou telefone foi selecionado
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _gradientController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat(reverse: true);

    _floatController1 = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);

    _floatController2 = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat(reverse: true);

    _floatController3 = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _gradientController.dispose();
    _floatController1.dispose();
    _floatController2.dispose();
    _floatController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          _buildFloatingCircles(),
          _buildRegisterContent(),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(gradient: AppColors.warmGradient),
        );
      },
    );
  }

  Widget _buildFloatingCircles() {
    return Stack(
      children: [
        _buildFloatingCircle(
          controller: _floatController1,
          size: 200,
          top: 50,
          left: 30,
          delay: 0,
        ),
        _buildFloatingCircle(
          controller: _floatController2,
          size: 150,
          bottom: 100,
          right: 50,
          delay: 5,
        ),
        _buildFloatingCircle(
          controller: _floatController3,
          size: 100,
          top: 300,
          right: 80,
          delay: 10,
        ),
      ],
    );
  }

  Widget _buildFloatingCircle({
    required AnimationController controller,
    required double size,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double delay,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final offset = controller.value * 60 - 30;
        final rotation = controller.value * 360;

        return Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: Transform.translate(
            offset: Offset(0, offset),
            child: Transform.rotate(
              angle: rotation * 3.14159 / 180,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRegisterContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.mediumSpacing),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 448), // 28rem
          child: _buildGlassmorphismCard(),
        ),
      ),
    );
  }

  Widget _buildGlassmorphismCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 40, // 2.5rem
        vertical: 48, // 3rem
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(32), // 2rem
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 64,
            offset: const Offset(0, 32),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 0,
            offset: const Offset(0, 0),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 32), // 2rem
              _buildForm(),
              const SizedBox(height: 24), // 1.5rem
              _buildTermsCheckbox(),
              const SizedBox(height: 24), // 1.5rem
              _buildRegisterButton(),
              const SizedBox(height: 24), // 1.5rem
              _buildDivider(),
              const SizedBox(height: 24), // 1.5rem
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🌟',
              style: TextStyle(fontSize: 32), // 2rem
            ),
            const SizedBox(width: 12), // 0.75rem
            Text(
              'Talentos Locais',
              style: GoogleFonts.poppins(
                fontSize: 20, // 1.25rem
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [AppColors.culturalRed, AppColors.culturalBlue],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // 0.5rem
        Text(
          'Criar nova conta',
          style: GoogleFonts.poppins(
            fontSize: 32, // 2rem
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1f2937),
          ),
        ),
        const SizedBox(height: 8), // 0.5rem
        Text(
          'Junte-se à nossa comunidade e descubra talentos incríveis na sua região',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15, // 0.95rem
            color: const Color(0xFF6b7280),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (_errorMessage != null) _buildErrorMessage(),
          _buildContactMethodSelector(),
          const SizedBox(height: 16), // 1rem
          if (_isEmailSelected) _buildEmailField() else _buildPhoneField(),
          const SizedBox(height: 16), // 1rem
          _buildPasswordField(),
          const SizedBox(height: 16), // 1rem
          _buildConfirmPasswordField(),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12), // 0.75rem
      margin: const EdgeInsets.only(bottom: 16), // 1rem
      decoration: BoxDecoration(
        color: const Color(0xFFfef2f2),
        border: Border.all(color: const Color(0xFFfecaca)),
        borderRadius: BorderRadius.circular(8), // 0.5rem
      ),
      child: Row(
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(
                color: Color(0xFFdc2626),
                fontSize: 14, // 0.875rem
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12), // 0.75rem
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isEmailSelected = true;
                  _phoneController.clear();
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: _isEmailSelected
                      ? const Color(0xFF3b82f6)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '✉️',
                      style: TextStyle(
                        fontSize: 20,
                        color: _isEmailSelected
                            ? Colors.white
                            : const Color(0xFF6b7280),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _isEmailSelected
                            ? Colors.white
                            : const Color(0xFF6b7280),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isEmailSelected = false;
                  _emailController.clear();
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: !_isEmailSelected
                      ? const Color(0xFF3b82f6)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '📱',
                      style: TextStyle(
                        fontSize: 20,
                        color: !_isEmailSelected
                            ? Colors.white
                            : const Color(0xFF6b7280),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Telefone',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: !_isEmailSelected
                            ? Colors.white
                            : const Color(0xFF6b7280),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12), // 0.75rem
      ),
      child: TextFormField(
        controller: _phoneController,
        inputFormatters: [_phoneMaskFormatter],
        keyboardType: TextInputType.phone,
        style: const TextStyle(fontSize: 16), // 1rem
        decoration: InputDecoration(
          labelText: 'Telefone',
          hintText: '(11) 99999-9999',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(12), // 0.75rem
            child: Text('📱', style: TextStyle(fontSize: 20)), // 1.25rem
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, // 0.75rem
            vertical: 12, // 0.75rem
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite seu telefone';
          }
          if (value.length < 15) {
            // (11) 99999-9999 = 15 chars
            return 'Por favor, digite um telefone válido com DDD';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12), // 0.75rem
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16), // 1rem
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'seu@email.com',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(12), // 0.75rem
            child: Text('✉️', style: TextStyle(fontSize: 20)), // 1.25rem
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, // 0.75rem
            vertical: 12, // 0.75rem
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite seu email';
          }
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Por favor, digite um email válido';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12), // 0.75rem
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        style: const TextStyle(fontSize: 16), // 1rem
        decoration: InputDecoration(
          labelText: 'Senha',
          hintText: 'Digite sua senha',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(12), // 0.75rem
            child: Text('🔒', style: TextStyle(fontSize: 20)), // 1.25rem
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, // 0.75rem
            vertical: 12, // 0.75rem
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite sua senha';
          }
          if (value.length < 6) {
            return 'A senha deve ter pelo menos 6 caracteres';
          }
          if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
            return 'A senha deve conter letras maiúsculas, minúsculas e números';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12), // 0.75rem
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: true,
        style: const TextStyle(fontSize: 16), // 1rem
        decoration: InputDecoration(
          labelText: 'Confirmar senha',
          hintText: 'Digite a senha novamente',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(12), // 0.75rem
            child: Text('🔐', style: TextStyle(fontSize: 20)), // 1.25rem
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, // 0.75rem
            vertical: 12, // 0.75rem
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, confirme sua senha';
          }
          if (value != _passwordController.text) {
            return 'As senhas não coincidem';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppColors.culturalBlue,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 14, // 0.875rem
                color: const Color(0xFF6b7280),
              ),
              children: [
                const TextSpan(text: 'Aceito os '),
                TextSpan(
                  text: 'Termos de Uso',
                  style: const TextStyle(
                    color: Color(0xFF3b82f6),
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' e '),
                TextSpan(
                  text: 'Política de Privacidade',
                  style: const TextStyle(
                    color: Color(0xFF3b82f6),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 56, // 3.5rem
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3b82f6), Color(0xFF1d4ed8)],
        ),
        borderRadius: BorderRadius.circular(12), // 0.75rem
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3b82f6).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _register,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 0.75rem
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLoading ? 'Criando conta...' : 'Criar conta',
              style: GoogleFonts.inter(
                fontSize: 16, // 1rem
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (!_isLoading) ...[
              const SizedBox(width: 8),
              const Text('→', style: TextStyle(fontSize: 16)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFd1d5db))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // 1rem
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ), // 0.5rem
            color: Colors.white,
            child: Text(
              'ou',
              style: GoogleFonts.inter(
                fontSize: 14, // 0.875rem
                color: const Color(0xFF6b7280),
              ),
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFd1d5db))),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Já tem uma conta? ',
          style: GoogleFonts.inter(
            fontSize: 14, // 0.875rem
            color: const Color(0xFF6b7280),
          ),
        ),
        TextButton(
          onPressed: () {
            context.go('/login'); // Volta para a tela de login
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Fazer login',
            style: GoogleFonts.inter(
              fontSize: 14, // 0.875rem
              color: const Color(0xFF3b82f6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_acceptTerms) {
        setState(() {
          _errorMessage = 'Você deve aceitar os termos de uso para continuar';
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        // Determina o contato e tipo
        String contact = _isEmailSelected
            ? _emailController.text
            : _phoneController.text;
        String contactType = _isEmailSelected ? 'email' : 'phone';

        // Simula o envio do código de verificação
        bool success;
        if (_isEmailSelected) {
          success = await VerificationService.sendVerificationCodeByEmail(
            contact,
          );
        } else {
          success = await VerificationService.sendVerificationCodeBySMS(
            contact,
          );
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          if (success) {
            // Mostra mensagem de sucesso
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Código de verificação enviado para ${_isEmailSelected ? 'seu email' : 'seu telefone'}!',
                ),
                backgroundColor: Colors.green,
              ),
            );

            // Navega para a tela de verificação de código
            context.go(
              '/verify-code',
              extra: {'contact': contact, 'contactType': contactType},
            );
          } else {
            setState(() {
              _errorMessage =
                  'Erro ao enviar código de verificação. Tente novamente.';
            });
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Erro inesperado. Tente novamente.';
          });
        }
      }
    }
  }
}
