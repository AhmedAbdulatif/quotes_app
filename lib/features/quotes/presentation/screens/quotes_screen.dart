import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes_app/core/locale/app_localizations.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/core/widgets/error_widget.dart';
import 'package:quotes_app/features/quotes/presentation/cubit/quotes_cubit.dart';
import 'package:quotes_app/features/quotes/presentation/widgets/quote_content.dart';
import 'package:quotes_app/features/splash/presentation/cubit/language_cubit.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  _getRandomQuote() {
    BlocProvider.of<QuotesCubit>(context).getRandomQuote();
  }

  _getSavedLanguage() {
    BlocProvider.of<LanguageCubit>(context).getSavedLanguage();
  }

  @override
  void initState() {
    _getRandomQuote();
    _getSavedLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getRandomQuote();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.translate_outlined, color: AppColors.primaryColor),
            onPressed: () {
              if (AppLocalizations.of(context)!.isEnLocale) {
                BlocProvider.of<LanguageCubit>(context).toArabic();
              } else {
                BlocProvider.of<LanguageCubit>(context).toEnglish();
              }
            },
          ),
          title: Text(AppLocalizations.of(context)!.translate("app_name")!),
        ),
        body: Column(
          children: [
            BlocBuilder<QuotesCubit, QuotesState>(
              builder: (context, state) {
                if (state is QuotesLoadingState) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                } else if (state is QuotesErrorState) {
                  return MyErrorWidget(onPressed: () {
                    _getRandomQuote();
                  });
                } else if (state is QuotesSuccessState) {
                  return QuoteContent(quote: state.quote);
                } else {
                  return SpinKitFadingCircle(
                    color: AppColors.primaryColor,
                  );
                }
              },
            ),
            InkWell(
              onTap: () {
                _getRandomQuote();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
