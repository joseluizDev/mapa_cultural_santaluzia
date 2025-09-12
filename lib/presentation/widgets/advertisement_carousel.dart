import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../domain/entities/advertisement.dart';

class AdvertisementCarousel extends StatefulWidget {
  final List<Advertisement> propagandas;
  final Duration autoPlayDuration;

  const AdvertisementCarousel({
    super.key,
    required this.propagandas,
    this.autoPlayDuration = const Duration(seconds: 5),
  });

  @override
  State<AdvertisementCarousel> createState() => _AdvertisementCarouselState();
}

class _AdvertisementCarouselState extends State<AdvertisementCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    if (widget.propagandas.length > 1) {
      _timer = Timer.periodic(widget.autoPlayDuration, (timer) {
        if (mounted) {
          _nextSlide();
        }
      });
    }
  }

  void _nextSlide() {
    final nextIndex = (_currentIndex + 1) % widget.propagandas.length;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _previousSlide() {
    final previousIndex =
        (_currentIndex - 1 + widget.propagandas.length) %
        widget.propagandas.length;
    _pageController.animateToPage(
      previousIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToSlide(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.propagandas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.symmetric(
        vertical: AppDimensions.espacamentoGrande,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppDimensions.bordaArredondadaGrande,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppDimensions.bordaArredondadaGrande,
        ),
        child: Stack(
          children: [
            // Slides
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.propagandas.length,
              itemBuilder: (context, index) {
                return _buildSlide(widget.propagandas[index]);
              },
            ),

            // Controles de navegação
            if (widget.propagandas.length > 1) ...[
              // Botão anterior
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildNavigationButton(
                    Icons.chevron_left,
                    _previousSlide,
                  ),
                ),
              ),

              // Botão próximo
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _buildNavigationButton(
                    Icons.chevron_right,
                    _nextSlide,
                  ),
                ),
              ),

              // Indicadores
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: _buildIndicators(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(Advertisement propaganda) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagem de fundo
        Image.network(
          propaganda.imagemUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.gray100,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 64,
                  color: AppColors.gray500,
                ),
              ),
            );
          },
        ),

        // Overlay com gradiente
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0x80000000)],
              stops: [0.6, 1.0],
            ),
          ),
        ),

        // Conteúdo do texto
        Positioned(
          bottom: 60,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                propaganda.nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Color(0x80000000),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                propaganda.periodo,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Color(0x80000000),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.gray900, size: 24),
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.propagandas.length,
        (index) => Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentIndex
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: InkWell(
            onTap: () => _goToSlide(index),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
