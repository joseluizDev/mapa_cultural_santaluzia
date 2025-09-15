import 'package:flutter/foundation.dart';

/// Base class for all stores using ValueNotifier pattern
abstract class BaseStore {
  final List<ValueNotifier> _notifiers = [];

  /// Register a notifier to be disposed automatically
  T register<T extends ValueNotifier>(T notifier) {
    _notifiers.add(notifier);
    return notifier;
  }

  /// Dispose all registered notifiers
  void dispose() {
    for (final notifier in _notifiers) {
      notifier.dispose();
    }
    _notifiers.clear();
  }
}

/// Base state class for page states
abstract class PageState {
  const PageState();
}

/// Loading state mixin
mixin LoadingState {
  late final ValueNotifier<bool> isLoading = ValueNotifier(false);
}

/// Error state mixin
mixin ErrorState {
  late final ValueNotifier<String?> errorMessage = ValueNotifier(null);
}