import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';

typedef LoginCallback = void Function(String email, String password);

class LoginPage extends StatefulWidget {
  final LoginCallback? onLogin;

  const LoginPage({super.key, this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _gradientController;
  late AnimationController _floatController1;
  late AnimationController _floatController2;
  late AnimationController _floatController3;

  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool _isLoading = false;
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
    _passwordController.dispose();
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
          _buildLoginContent(),
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

  Widget _buildLoginContent() {
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
              _buildCreateAccountLink(),
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
          'Bem-vindo de volta!',
          style: GoogleFonts.poppins(
            fontSize: 32, // 2rem
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1f2937),
          ),
        ),
        const SizedBox(height: 8), // 0.5rem
        Text(
          'Entre na sua conta para continuar descobrindo talentos incríveis',
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
          _buildPhoneField(),
          const SizedBox(height: 16), // 1rem
          _buildPasswordField(),
          const SizedBox(height: 32), // 2rem
          _buildLoginButton(),
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
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
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
        onPressed: _isLoading ? null : _login,
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
              _isLoading ? 'Entrando...' : 'Entrar',
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

  Widget _buildCreateAccountLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Não tem uma conta? ',
          style: GoogleFonts.inter(
            fontSize: 14, // 0.875rem
            color: const Color(0xFF6b7280),
          ),
        ),
        TextButton(
          onPressed: () {
            context.go('/register');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Criar conta gratuitamente',
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

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // If callback is provided, use it
      if (widget.onLogin != null) {
        widget.onLogin!(_phoneController.text, _passwordController.text);
        return;
      }

      // Otherwise, use the default implementation
      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          // For demo purposes, show success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login realizado com sucesso!')),
          );

          // Navigate to home
          context.go('/home');
        }
      });
    }
  }
}
