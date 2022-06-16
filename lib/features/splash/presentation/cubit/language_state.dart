part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState(this.locale);
  final Locale locale;

  @override
  List<Object> get props => [locale];
}

class ChangeLocalState extends LanguageState {
  const ChangeLocalState(Locale currentLocale) : super(currentLocale);
}
