import 'package:flutter/material.dart';
import 'package:quotes_app/core/locale/app_localizations.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/core/utils/media_query_values.dart';

class MyErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const MyErrorWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            size: 150,
            color: AppColors.primaryColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            AppLocalizations.of(context)!.translate("something_went_wrong")!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.translate("try_again")!,
          style: const TextStyle(
            color: AppColors.hintColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 55,
          width: context.width * 0.55,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                onPrimary: Theme.of(context).primaryColor,
                elevation: 500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
            onPressed: () {
              onPressed.call();
            },
            child: Text(
              AppLocalizations.of(context)!.translate("reload_screen")!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
