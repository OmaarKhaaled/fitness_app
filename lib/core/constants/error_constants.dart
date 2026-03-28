class ErrorsConstant {
  ErrorsConstant._();
  //================== DIO Exceptions ==================================
  static const String connectionTimeoutError =
      'Connection timeout. Please try again.';
  static const String sendTimeoutError = 'Send timeout. Please try again.';
  static const String receiveTimeoutError =
      'Receive timeout. Please try again.';
  static const String noInternetError =
      'No internet connection. Please check your network.';
  static const String cancelError = 'Request cancelled.';
  static const String badCertificateError = 'Bad certificate.';

  //================== API Responses ==================================
  static const String badRequestError = 'Invalid request.';
  static const String noContent = 'No content available.';
  static const String forbiddenError = 'Access forbidden.';
  static const String unauthorizedError = 'Unauthorized access.';
  static const String notFoundError = 'Resource not found.';
  static const String internalServerError = 'Internal server error.';
  static const String sessionExpiredError =
      'Session expired. Please log in again.';

  //================== Local Exceptions ==================================
  static const String cacheError = 'Cache error occurred.';

  //================== Unknown Error ==================================
  static const String defaultError = 'Something went wrong. Please try again.';
}
