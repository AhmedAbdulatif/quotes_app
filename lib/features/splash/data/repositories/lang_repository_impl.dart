import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:quotes_app/features/splash/domain/repositories/lang_repository.dart';

class LangRepositoryImpl implements LanuageRepository {
  final LangLocalDataSource _langLocalDataSource;
  LangRepositoryImpl(this._langLocalDataSource);

  @override
  Future<Either<Failure, bool>> changeAppLanguage(
      {required String langCode}) async {
    try {
      final isLanguageChanged =
          await _langLocalDataSource.changeAppLanguage(langCode: langCode);
      return Right(isLanguageChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getAppLanguage() async {
    try {
      final langCode = await _langLocalDataSource.getAppLanguage();
      return Right(langCode);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
