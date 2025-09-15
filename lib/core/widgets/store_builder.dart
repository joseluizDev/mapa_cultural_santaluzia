import 'package:flutter/material.dart';

import '../state/base_store.dart';
import '../state/screen_state.dart';

/// Widget that rebuilds based on store state changes
/// Follows Single Responsibility Principle - handles only UI state reactions
class StoreBuilder<T> extends StatelessWidget {
  final BaseStore<T> store;
  final Widget Function(BuildContext context, T data) onSuccess;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context, String message)? onError;
  final Widget Function(BuildContext context, String? message)? onEmpty;
  final Widget Function(BuildContext context)? onInitial;

  const StoreBuilder({
    super.key,
    required this.store,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.onEmpty,
    this.onInitial,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ScreenState>(
      valueListenable: store,
      builder: (context, state, child) {
        return switch (state) {
          LoadingState() => _buildLoading(context),
          SuccessState<T>() => onSuccess(context, state.data),
          ErrorState() => _buildError(context, state.message),
          EmptyState() => _buildEmpty(context, state.message),
          InitialState() => _buildInitial(context),
          _ => _buildError(context, 'Unknown state: ${state.runtimeType}'),
        };
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    if (onLoading != null) {
      return onLoading!(context);
    }

    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(BuildContext context, String message) {
    if (onError != null) {
      return onError!(context, message);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, String? message) {
    if (onEmpty != null) {
      return onEmpty!(context, message);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message ?? 'No data available',
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    if (onInitial != null) {
      return onInitial!(context);
    }

    return const SizedBox.shrink();
  }
}

/// Simplified version for common use cases
class SimpleStoreBuilder<T> extends StatelessWidget {
  final BaseStore<T> store;
  final Widget Function(BuildContext context, T data) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;

  const SimpleStoreBuilder({
    super.key,
    required this.store,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<T>(
      store: store,
      onSuccess: builder,
      onLoading: loadingWidget != null ? (_) => loadingWidget! : null,
      onError: errorWidget != null ? (_, __) => errorWidget! : null,
      onEmpty: emptyWidget != null ? (_, __) => emptyWidget! : null,
    );
  }
}
