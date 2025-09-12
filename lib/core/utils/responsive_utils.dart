import 'package:flutter/material.dart';

import '../constants/dimensions.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppDimensions.mobileBreakpoint &&
        width < AppDimensions.desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
  }

  static int getGridColumnCount(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }

  static double getHorizontalPadding(BuildContext context) {
    if (isMobile(context)) return AppDimensions.mediumSpacing;
    if (isTablet(context)) return AppDimensions.largeSpacing;
    return AppDimensions.extraLargeSpacing;
  }

  static double getCardSpacing(BuildContext context) {
    if (isMobile(context)) return AppDimensions.mediumSpacing;
    return AppDimensions.largeSpacing;
  }

  ResponsiveUtils._();
}
