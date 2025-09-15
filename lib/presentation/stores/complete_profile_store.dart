import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_store.dart';

class CompleteProfileStore extends BaseStore with LoadingState, ErrorState {
  // Selected activities notifier
  late final ValueNotifier<List<String>> selectedActivities = register(ValueNotifier([]));

  // Available activities list
  final List<String> availableActivities = [
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
    'Marketing',
    'Vendas',
    'Administração',
    'Finanças',
    'Educação',
    'Consultoria',
    'Outros',
  ];

  CompleteProfileStore() {
    // Register loading and error notifiers for automatic disposal
    register(isLoading);
    register(errorMessage);
  }

  /// Toggle activity selection
  void toggleActivity(String activity) {
    final currentList = List<String>.from(selectedActivities.value);
    if (currentList.contains(activity)) {
      currentList.remove(activity);
    } else {
      currentList.add(activity);
    }
    selectedActivities.value = currentList;
  }

  /// Check if activity is selected
  bool isActivitySelected(String activity) {
    return selectedActivities.value.contains(activity);
  }

  /// Complete profile submission
  Future<void> completeProfile({
    required String name,
    required String cpf,
    required String age,
    required String city,
    required String description,
    required BuildContext context,
  }) async {
    if (selectedActivities.value.isEmpty) {
      errorMessage.value = 'Selecione pelo menos uma atividade';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate profile completion
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil completado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to home
        context.go('/home');
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Erro ao completar perfil. Tente novamente.';
    }
  }
}