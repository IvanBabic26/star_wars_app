class HTTPResponse<T> {
  final bool? isSuccessful;
  final T? data;
  final int? statusCode;
  final String? message;

  HTTPResponse({
    this.isSuccessful,
    this.data,
    this.message,
    this.statusCode,
  });

  static String successMessage = 'Request successful.';

  static String errorMessage =
      'Invalid data received from the server! Please try again in a moment.';
}

enum Method { GET, POST, DELETE, PATCH }
