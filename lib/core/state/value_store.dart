import 'package:flutter/material.dart';

// State types
enum StateStatus { initial, loading, success, error, empty }

// UI State class
class UiState<T> {
  final StateStatus status;
  final T? data;
  final String? message;
  final dynamic error;

  const UiState({
    this.status = StateStatus.initial,
    this.data,
    this.message,
    this.error,
  });

  // Constructors
  factory UiState.initial() => UiState<T>(status: StateStatus.initial);
  factory UiState.loading() => UiState<T>(status: StateStatus.loading);
  factory UiState.success(T data) =>
      UiState<T>(status: StateStatus.success, data: data);
  factory UiState.error(String message, {dynamic error}) =>
      UiState<T>(status: StateStatus.error, message: message, error: error);
  factory UiState.empty([String? message]) => UiState<T>(
    status: StateStatus.empty,
    message: message ?? 'No data available',
  );

  // Getters
  bool get isInitial => status == StateStatus.initial;
  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isError => status == StateStatus.error;
  bool get isEmpty => status == StateStatus.empty;
}

// Store class
class Store<T> extends ValueNotifier<UiState<T>> {
  Store() : super(UiState<T>.initial());

  void setInitial() => value = UiState<T>.initial();
  void setLoading() => value = UiState<T>.loading();
  void setSuccess(T data) => value = UiState<T>.success(data);
  void setError(String message, {dynamic error}) =>
      value = UiState<T>.error(message, error: error);
  void setEmpty([String? message]) => value = UiState<T>.empty(message);

  UiState<T> get state => value;
  T? get data => value.data;

  Future<void> execute(Future<T> Function() operation) async {
    try {
      setLoading();
      final result = await operation();

      if (result is List && result.isEmpty) {
        setEmpty('No items found');
      } else if (result is Map && result.isEmpty) {
        setEmpty('No data found');
      } else {
        setSuccess(result);
      }
    } catch (e) {
      setError('Error: ${e.toString()}', error: e);
    }
  }
}

// Widget builder
class StoreConsumer<T> extends StatelessWidget {
  final Store<T> store;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? initialBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, String message)? errorBuilder;
  final Widget Function(BuildContext context, String? message)? emptyBuilder;

  const StoreConsumer({
    super.key,
    required this.store,
    required this.builder,
    this.initialBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UiState<T>>(
      valueListenable: store,
      builder: (context, state, _) {
        switch (state.status) {
          case StateStatus.initial:
            return _buildInitial(context);
          case StateStatus.loading:
            return _buildLoading(context);
          case StateStatus.success:
            return builder(context, state.data as T);
          case StateStatus.error:
            return _buildError(context, state.message ?? 'Unknown error');
          case StateStatus.empty:
            return _buildEmpty(context, state.message);
        }
      },
    );
  }

  Widget _buildInitial(BuildContext context) {
    if (initialBuilder != null) {
      return initialBuilder!(context);
    }
    return const SizedBox.shrink();
  }

  Widget _buildLoading(BuildContext context) {
    if (loadingBuilder != null) {
      return loadingBuilder!(context);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(BuildContext context, String message) {
    if (errorBuilder != null) {
      return errorBuilder!(context, message);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, String? message) {
    if (emptyBuilder != null) {
      return emptyBuilder!(context, message);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message ?? 'No data available',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
