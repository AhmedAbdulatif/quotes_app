import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/features/quotes/domain/usecases/random_quote_usecase.dart';
import 'package:quotes_app/features/splash/domain/repositories/lang_repository.dart';

class GetLanguageUseCase implements Usecase<String, NoParams> {
  final LanuageRepository _lanuageRepository;
  GetLanguageUseCase(this._lanuageRepository);

  @override
  Future<Either<Failure, String>> execute(NoParams params) async {
    return await _lanuageRepository.getAppLanguage();
  }
}
