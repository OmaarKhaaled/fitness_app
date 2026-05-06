import 'app_exception.dart';

sealed class LocalException extends AppException {
  const LocalException(super.message, {super.code});
}

class CacheException extends LocalException {
  const CacheException(super.message, {super.code});
}
