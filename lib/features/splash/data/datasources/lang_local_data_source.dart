import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LangLocalDataSource {
  Future<bool> changeAppLanguage({required String langCode});
  Future<String> getAppLanguage();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferences _sharedPreferences;
  LangLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> changeAppLanguage({required String langCode}) async {
    return await _sharedPreferences.setString(AppStrings.locale, langCode);
  }

  @override
  Future<String> getAppLanguage() async =>
      _sharedPreferences.getString(AppStrings.locale) ?? AppStrings.englishCode;
}
