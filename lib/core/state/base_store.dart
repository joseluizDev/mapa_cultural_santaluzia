import 'package:flutter/foundation.dart';

import 'screen_state.dart';

/// Base store class using ValueNotifier for state management
/// Follows Single Responsibility Principle - manages only state
abstract class BaseStore<T> extends ValueNotifier<ScreenState> {
  BaseStore() : super(const InitialState());

  /// Current state getter for type safety
  ScreenState get currentState => value;

  /// Emits loading state
  void setLoading() {
    value = const LoadingState();
  }

  /// Emits success state with data
  void setSuccess(T data) {
    value = SuccessState<T>(data);
  }

  /// Emits error state with message
  void setError(String message, {String? code, StackTrace? stackTrace}) {
    value = ErrorState(message: message, code: code, stackTrace: stackTrace);
  }

  /// Emits empty state
  void setEmpty([String? message]) {
    value = EmptyState(message);
  }

  /// Resets to initial state
  void reset() {
    value = const InitialState();
  }

  /// Executes async operation with automatic state management
  Future<void> executeWithState(Future<T> Function() operation) async {
    try {
      setLoading();
      final result = await operation();
      setSuccess(result);
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  /// Executes async operation with custom result processing
  Future<void> executeWithCustomState<R>(
    Future<R> Function() operation,
    T Function(R result) processResult,
  ) async {
    try {
      setLoading();
      final result = await operation();
      final processedResult = processResult(result);
      setSuccess(processedResult);
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  /// Handles different types of errors
  void _handleError(dynamic error, StackTrace stackTrace) {
    if (error is Exception) {
      setError(error.toString(), stackTrace: stackTrace);
    } else {
      setError('Unexpected error: ${error.toString()}', stackTrace: stackTrace);
    }
  }

  /// Convenience method to check current state type
  bool get isLoading => currentState is LoadingState;
  bool get isSuccess => currentState is SuccessState;
  bool get isError => currentState is ErrorState;
  bool get isEmpty => currentState is EmptyState;
  bool get isInitial => currentState is InitialState;

  /// Get data from success state (type-safe)
  T? get data {
    final state = currentState;
    if (state is SuccessState<T>) {
      return state.data;
    }
    return null;
  }

  /// Get error message from error state
  String? get errorMessage {
    final state = currentState;
    if (state is ErrorState) {
      return state.message;
    }
    return null;
  }
}
