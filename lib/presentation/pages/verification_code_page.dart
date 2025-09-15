import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../stores/verification_code_store.dart';

class VerificationCodePage extends StatefulWidget {
  final String contact;
  final String contactType; // 'email' ou 'phone'

  const VerificationCodePage({
    super.key,
    required this.contact,
    required this.contactType,
  });

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage>
    with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  late AnimationController _gradientController;
  late AnimationController _floatController1;
  late AnimationController _floatController2;
  late AnimationController _floatController3;

  // Replace direct state variables with store
  late final VerificationCodeStore _store;

  @override
  void initState() {
    super.initState();
    _store = VerificationCodeStore(
      contact: widget.contact,
      contactType: widget.contactType,
    );
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
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _gradientController.dispose();
    _floatController1.dispose();
    _floatController2.dispose();
    _floatController3.dispose();
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          _buildFloatingCircles(),
          _buildVerificationContent(),
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

  Widget _buildVerificationContent() {
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
              _buildCodeInputs(),
              const SizedBox(height: 24), // 1.5rem
              ValueListenableBuilder<String?>(
                valueListenable: _store.errorMessage,
                builder: (context, errorMessage, child) {
                  if (errorMessage != null) {
                    return _buildErrorMessage(errorMessage);
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 24), // 1.5rem
              _buildVerifyButton(),
              const SizedBox(height: 24), // 1.5rem
              _buildResendSection(),
              const SizedBox(height: 24), // 1.5rem
              _buildBackToLoginLink(),
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
              '🔐',
              style: TextStyle(fontSize: 32), // 2rem
            ),
            const SizedBox(width: 12), // 0.75rem
            Text(
              'Verificação',
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
          'Confirme sua identidade',
          style: GoogleFonts.poppins(
            fontSize: 25, // 2rem
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1f2937),
          ),
        ),
        const SizedBox(height: 8), // 0.5rem
        Text(
          'Digite o código de 4 dígitos enviado para ${_store.formatContact()}',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15, // 0.95rem
            color: const Color(0xFF6b7280),
          ),
        ),
      ],
    );
  }

  Widget _buildCodeInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFf9fafb),
            border: Border.all(
              color: _controllers[index].text.isNotEmpty
                  ? const Color(0xFF3b82f6)
                  : const Color(0xFFe5e7eb),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1f2937),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }

              // Verificar se todos os campos estão preenchidos
              bool allFilled = _controllers.every(
                (controller) => controller.text.isNotEmpty,
              );
              if (allFilled) {
                _verifyCode();
              }

              // Clear error message when user starts typing
              _store.errorMessage.value = null;
            },
          ),
        );
      }),
    );
  }

  Widget _buildErrorMessage(String errorMessage) {
    return Container(
      padding: const EdgeInsets.all(12), // 0.75rem
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
              errorMessage,
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

  Widget _buildVerifyButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: _store.isLoading,
      builder: (context, isLoading, child) {
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
            onPressed: isLoading ? null : _verifyCode,
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
                  isLoading ? 'Verificando...' : 'Verificar código',
                  style: GoogleFonts.inter(
                    fontSize: 16, // 1rem
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (!isLoading) ...[
                  const SizedBox(width: 8),
                  const Text(
                    '✓',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResendSection() {
    return ValueListenableBuilder<bool>(
      valueListenable: _store.canResend,
      builder: (context, canResend, child) {
        return Column(
          children: [
            Text(
              'Não recebeu o código?',
              style: GoogleFonts.inter(
                fontSize: 14, // 0.875rem
                color: const Color(0xFF6b7280),
              ),
            ),
            const SizedBox(height: 8),
            if (canResend)
              TextButton(
                onPressed: _resendCode,
                child: Text(
                  'Reenviar código',
                  style: GoogleFonts.inter(
                    fontSize: 14, // 0.875rem
                    color: const Color(0xFF3b82f6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              ValueListenableBuilder<int>(
                valueListenable: _store.resendCountdown,
                builder: (context, countdown, child) {
                  return Text(
                    'Reenviar em ${countdown}s',
                    style: GoogleFonts.inter(
                      fontSize: 14, // 0.875rem
                      color: const Color(0xFF6b7280),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildBackToLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Voltar para ',
          style: GoogleFonts.inter(
            fontSize: 14, // 0.875rem
            color: const Color(0xFF6b7280),
          ),
        ),
        TextButton(
          onPressed: () {
            context.go('/login');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'tela de login',
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

  void _verifyCode() {
    List<String> codeDigits = _controllers.map((controller) => controller.text).toList();
    _store.verifyCode(codeDigits, context);
  }

  void _clearCodeInputs() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  void _resendCode() {
    _store.resendCode(context);
  }
}
