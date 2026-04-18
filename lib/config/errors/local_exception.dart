import 'app_exception.dart';

sealed class LocalException extends AppException {
  LocalException(super.message, {super.code});
}

class CacheException extends LocalException {
  CacheException(super.message, {super.code});
}
