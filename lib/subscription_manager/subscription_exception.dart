/// Subscription exception class
class SubscriptionException implements Exception {
  /// Class constructor
  SubscriptionException({this.message});

  /// Exception message
  String message;

  @override
  String toString() => 'Injector Exception: $message';
}
