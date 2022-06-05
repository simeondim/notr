/// Thrown when application cannot continue to be used.
class FatalError {
  const FatalError(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;
}
