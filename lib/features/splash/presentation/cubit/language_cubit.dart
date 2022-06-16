import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/quotes/domain/usecases/random_quote_usecase.dart';
import 'package:quotes_app/features/splash/domain/usecases/change_language.dart';
import 'package:quotes_app/features/splash/domain/usecases/get_saved_language.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final ChangeLanguageUseCase changeLanguageUseCase;
  final GetLanguageUseCase getLanguageUseCase;
  LanguageCubit(
      {required this.changeLanguageUseCase, required this.getLanguageUseCase})
      : super(const ChangeLocalState(Locale(AppStrings.englishCode)));

  String currentLangCode = AppStrings.englishCode;
  Future<void> getSavedLanguage() async {
    final result = await getLanguageUseCase.execute(NoParams());
    result.fold((failure) {
      debugPrint(failure.toString());
    }, (langCode) {
      currentLangCode = langCode;
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  Future<void> _changeLanguage(String langCode) async {
    final result = await changeLanguageUseCase.execute(langCode);
    result.fold((failure) {
      debugPrint(failure.toString());
    }, (bool isChanged) {
      currentLangCode = langCode;
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  void toEnglish() => _changeLanguage(AppStrings.englishCode);
  void toArabic() => _changeLanguage(AppStrings.arabicCode);
}
