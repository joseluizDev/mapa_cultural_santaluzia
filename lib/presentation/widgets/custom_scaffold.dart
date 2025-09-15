import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import 'buttons.dart';

enum AppPage { home, about, ads }

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final AppPage currentPage;

  const CustomScaffold({
    super.key,
    required this.body,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.warmGradient),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_buildAppBar(context)];
          },
          body: body,
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.mediumSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Famosos Locais',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      NavigationButton(
                        text: 'Início',
                        active: currentPage == AppPage.home,
                        onPressed: () => GoRouter.of(context).go('/'),
                      ),
                      NavigationButton(
                        text: 'Sobre',
                        active: currentPage == AppPage.about,
                        onPressed: () => GoRouter.of(context).go('/about'),
                      ),
                      NavigationButton(
                        text: 'Propagandas',
                        active: currentPage == AppPage.ads,
                        onPressed: () => GoRouter.of(context).go('/ads'),
                      ),
                      NavigationButton(
                        text: 'Entrar',
                        onPressed: () => GoRouter.of(context).go('/login'),
                      ),
                      const SizedBox(width: AppDimensions.mediumSpacing),
                      PrimaryButton(
                        text: 'Criar conta',
                        onPressed: () => GoRouter.of(context).go('/register'),
                        backgroundColor: AppColors.white,
                        textColor: AppColors.culturalBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
