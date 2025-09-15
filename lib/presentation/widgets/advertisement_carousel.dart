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

class _AdvertisementCarouselState extends State<AdvertisementCarousel>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
    _startAutoPlay();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
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
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _previousSlide() {
    final previousIndex =
        (_currentIndex - 1 + widget.propagandas.length) % widget.propagandas.length;
    _pageController.animateToPage(
      previousIndex,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _goToSlide(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
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
      height: 320,
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.largeSpacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withOpacity(0.4),
            offset: const Offset(0, 8),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
        child: Stack(
          children: [
            // Slides
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _animationController.reset();
                  _animationController.forward();
                });
              },
              itemCount: widget.propagandas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildSlide(widget.propagandas[index]),
                );
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
    return ScaleTransition(
      scale: _animation.drive(Tween(begin: 0.95, end: 1.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 10),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.largeBorderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagem de fundo
              Image.network(
                propaganda.imagemUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.warmGradient,
                    ),
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
                    colors: [Colors.transparent, Colors.black54],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),

              // Conteúdo do texto
              Positioned(
                bottom: 40,
                left: 24,
                right: 24,
                child: FadeTransition(
                  opacity: _animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        propaganda.nome,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Color(0x80000000),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        propaganda.periodo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2,
                              color: Color(0x80000000),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.gray900, size: 28),
        splashRadius: 28,
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.propagandas.length,
        (index) => Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentIndex
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            border: Border.all(
              color: Colors.white, 
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => _goToSlide(index),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}