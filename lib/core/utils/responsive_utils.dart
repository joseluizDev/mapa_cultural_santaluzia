import 'package:flutter/material.dart';

import '../constants/dimensions.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppDimensions.breakpointMobile;
  }

  static bool isTablet(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return largura >= AppDimensions.breakpointMobile &&
        largura < AppDimensions.breakpointDesktop;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.breakpointDesktop;
  }

  static int obterNumeroColunasGrid(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }

  static double obterPaddingHorizontal(BuildContext context) {
    if (isMobile(context)) return AppDimensions.espacamentoMedio;
    if (isTablet(context)) return AppDimensions.espacamentoGrande;
    return AppDimensions.espacamentoExtraGrande;
  }

  static double obterEspacamentoEntreCards(BuildContext context) {
    if (isMobile(context)) return AppDimensions.espacamentoMedio;
    return AppDimensions.espacamentoGrande;
  }

  ResponsiveUtils._();
}
