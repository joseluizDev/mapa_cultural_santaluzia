/// Base class for all screen states
/// Follows Object Calisthenics by encapsulating state behavior
abstract class ScreenState {
  const ScreenState();
}

/// Loading state - indicates async operation in progress
class LoadingState extends ScreenState {
  const LoadingState();

  @override
  String toString() => 'LoadingState()';

  @override
  bool operator ==(Object other) => other is LoadingState;

  @override
  int get hashCode => 'LoadingState'.hashCode;
}

/// Success state - contains successful operation result
class SuccessState<T> extends ScreenState {
  final T data;

  const SuccessState(this.data);

  @override
  String toString() => 'SuccessState(data: $data)';

  @override
  bool operator ==(Object other) =>
      other is SuccessState<T> && other.data == data;

  @override
  int get hashCode => data.hashCode;
}

/// Error state - contains error information
class ErrorState extends ScreenState {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  const ErrorState({required this.message, this.code, this.stackTrace});

  @override
  String toString() => 'ErrorState(message: $message, code: $code)';

  @override
  bool operator ==(Object other) =>
      other is ErrorState && other.message == message && other.code == code;

  @override
  int get hashCode => message.hashCode ^ (code?.hashCode ?? 0);
}

/// Empty state - indicates no data available
class EmptyState extends ScreenState {
  final String? message;

  const EmptyState([this.message]);

  @override
  String toString() => 'EmptyState(message: $message)';

  @override
  bool operator ==(Object other) =>
      other is EmptyState && other.message == message;

  @override
  int get hashCode => message?.hashCode ?? 0;
}

/// Initial state - default state before any operation
class InitialState extends ScreenState {
  const InitialState();

  @override
  String toString() => 'InitialState()';

  @override
  bool operator ==(Object other) => other is InitialState;

  @override
  int get hashCode => 'InitialState'.hashCode;
}
