import 'package:flutter/material.dart';
import 'package:smart_rate_us/default/views/default_dialog_builder.dart';

Widget buildDefaultSuccessDialogView() {
  return DefaultSuccessDialogView(
    textConfig: DefaultSuccessDialogTextConfig(
      buttonTitle: 'OK',
      title: 'Thank You!',
      subtitle: 'We appreciate your feedback and carefully review it!',
    ),
  );
}

class DefaultSuccessDialogTextConfig {
  final String title;
  final String subtitle;
  final String? buttonTitle;

  DefaultSuccessDialogTextConfig({
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
  });
}

class DefaultSuccessDialogView extends StatelessWidget {
  final DefaultSuccessDialogTextConfig textConfig;
  final Color? primaryColor;
  const DefaultSuccessDialogView({super.key, required this.textConfig, this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return makeInformDialog(
      context: context,
      title: textConfig.title,
      subtitle2: textConfig.subtitle,
      buttonTitle: textConfig.buttonTitle,
      customButtonColor: primaryColor,
    );
  }
}
