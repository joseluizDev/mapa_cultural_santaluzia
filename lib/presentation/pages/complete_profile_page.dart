import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';

typedef CompleteProfileCallback =
    void Function({
      required String name,
      required String cpf,
      required String age,
      required String city,
      required String description,
      required List<String> activities,
    });

class CompleteProfilePage extends StatefulWidget {
  final String contact;
  final String contactType;
  final CompleteProfileCallback? onCompleteProfile;

  const CompleteProfilePage({
    super.key,
    required this.contact,
    required this.contactType,
    this.onCompleteProfile,
  });

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();

  late AnimationController _gradientController;
  late AnimationController _floatController1;
  late AnimationController _floatController2;
  late AnimationController _floatController3;

  final _cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool _isLoading = false;
  String? _errorMessage;

  // Lista de atividades/talentos disponíveis
  final List<String> _availableActivities = [
    'Música',
    'Dança',
    'Teatro',
    'Pintura',
    'Escultura',
    'Fotografia',
    'Culinária',
    'Artesanato',
    'Literatura',
    'Poesia',
    'Stand-up',
    'Magia/Ilusionismo',
    'Capoeira',
    'Artes Marciais',
    'Yoga',
    'Massoterapia',
    'Tatuagem',
    'Design Gráfico',
    'Moda',
    'Barbeiro/Cabeleireiro',
    'Jardinagem',
    'Marcenaria',
    'Eletrônica',
    'Programação',
    'Educação',
    'Consultoria',
    'Outros',
  ];

  final List<String> _selectedActivities = [];

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
    _nameController.dispose();
    _cpfController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
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
          _buildProfileContent(),
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

  Widget _buildProfileContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.mediumSpacing),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Center(child: _buildGlassmorphismCard()),
        ),
      ),
    );
  }

  Widget _buildGlassmorphismCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(32),
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
              const SizedBox(height: 32),
              _buildForm(),
              const SizedBox(height: 24),
              _buildCompleteProfileButton(),
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
            const Text('👤', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Text(
              'Complete seu Perfil',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [AppColors.culturalRed, AppColors.culturalBlue],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Último passo!',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1f2937),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Preencha seus dados para finalizar o cadastro e começar a compartilhar seus talentos',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_errorMessage != null) _buildErrorMessage(),
          _buildNameField(),
          const SizedBox(height: 16),
          _buildCpfField(),
          const SizedBox(height: 16),
          _buildAgeField(),
          const SizedBox(height: 16),
          _buildCityField(),
          const SizedBox(height: 20),
          _buildActivitiesSection(),
          const SizedBox(height: 20),
          _buildDescriptionField(),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFfef2f2),
        border: Border.all(color: const Color(0xFFfecaca)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Color(0xFFdc2626), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: _nameController,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          labelText: 'Nome Completo *',
          hintText: 'Digite seu nome completo',
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Text('👤', style: TextStyle(fontSize: 20)),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite seu nome completo';
          }
          if (value.trim().split(' ').length < 2) {
            return 'Por favor, digite nome e sobrenome';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCpfField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: _cpfController,
        inputFormatters: [_cpfMaskFormatter],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          labelText: 'CPF *',
          hintText: '000.000.000-00',
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Text('📄', style: TextStyle(fontSize: 20)),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite seu CPF';
          }
          if (value.length < 14) {
            return 'CPF deve ter 11 dígitos';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAgeField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: _ageController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          labelText: 'Idade *',
          hintText: 'Ex: 25',
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Text('🎂', style: TextStyle(fontSize: 20)),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite sua idade';
          }
          int? age = int.tryParse(value);
          if (age == null || age < 16 || age > 120) {
            return 'Idade deve estar entre 16 e 120 anos';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCityField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: _cityController,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          labelText: 'Cidade *',
          hintText: 'Digite sua cidade',
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Text('📍', style: TextStyle(fontSize: 20)),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, digite sua cidade';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suas Atividades/Talentos *',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecione as atividades que você pratica ou tem talento',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF6b7280),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableActivities.map((activity) {
            final isSelected = _selectedActivities.contains(activity);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedActivities.remove(activity);
                  } else {
                    _selectedActivities.add(activity);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3b82f6)
                      : const Color(0xFFf3f4f6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3b82f6)
                        : const Color(0xFFd1d5db),
                  ),
                ),
                child: Text(
                  activity,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : const Color(0xFF374151),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedActivities.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Selecione pelo menos uma atividade',
              style: TextStyle(fontSize: 12, color: Colors.red[600]),
            ),
          ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 4,
        maxLength: 500,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          labelText: 'Fale um pouco sobre você *',
          hintText: 'Conte sobre sua experiência, estilo, o que te inspira...',
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Text('💬', style: TextStyle(fontSize: 20)),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, fale um pouco sobre você';
          }
          if (value.length < 50) {
            return 'Descrição deve ter pelo menos 50 caracteres';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCompleteProfileButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3b82f6), Color(0xFF1d4ed8)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3b82f6).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _completeProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLoading ? 'Finalizando...' : 'Finalizar Cadastro',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (!_isLoading) ...[
              const SizedBox(width: 8),
              const Text('🎉', style: TextStyle(fontSize: 16)),
            ],
          ],
        ),
      ),
    );
  }

  void _completeProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedActivities.isEmpty) {
        setState(() {
          _errorMessage = 'Por favor, selecione pelo menos uma atividade';
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // If callback is provided, use it
      if (widget.onCompleteProfile != null) {
        widget.onCompleteProfile!(
          name: _nameController.text,
          cpf: _cpfController.text,
          age: _ageController.text,
          city: _cityController.text,
          description: _descriptionController.text,
          activities: List<String>.from(_selectedActivities),
        );
        return;
      }

      // Otherwise, use the default implementation
      // Simular salvamento do perfil
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          // Mostrar sucesso
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Perfil criado com sucesso! Bem-vindo(a)! 🎉'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          // Navegar para home
          context.go('/home');
        }
      });
    }
  }
}
