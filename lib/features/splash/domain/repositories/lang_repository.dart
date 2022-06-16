import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/error/failures.dart';

abstract class LanuageRepository {
  Future<Either<Failure, bool>> changeAppLanguage({required String langCode});
  Future<Either<Failure, String>> getAppLanguage();
}
