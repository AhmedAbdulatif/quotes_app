import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/features/splash/domain/repositories/lang_repository.dart';

class ChangeLanguageUseCase implements Usecase<bool, String> {
  final LanuageRepository _lanuageRepository;
  ChangeLanguageUseCase(this._lanuageRepository);
  @override
  Future<Either<Failure, bool>> execute(String langCode) async {
    return await _lanuageRepository.changeAppLanguage(langCode: langCode);
  }
}
