import 'package:flutter/material.dart';

import '../widgets/custom_scaffold.dart';

class AdvertisementPage extends StatelessWidget {
  const AdvertisementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      currentPage: AppPage.ads,
      body: Center(child: Text('Página de Propagandas')),
    );
  }
}
