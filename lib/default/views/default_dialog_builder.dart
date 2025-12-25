import 'package:flutter/material.dart';
import 'package:smart_rate_us/default/views/default_button_view.dart';
import 'package:smart_rate_us/default/views/default_stars_view.dart';

Widget buildDefaultDialogWidget(
  BuildContext context,
  VoidCallback onLike,
  VoidCallback onDislike,
  VoidCallback onRemindLater,
) {
  return DoYouLoveUsDefaultDialog(
    textConfig: DefaultDialogTextConfig(
      title: 'Do you like our app?',
      remindLaterText: 'Remind me later',
      iLikeItText: 'I like it',
      itCouldBeBetterText: 'Could be better',
    ),

    onLike: onLike,
    onDislike: onDislike,
    onRemindLater: onRemindLater,
    starsBuilder: (BuildContext context) {
      return Icon(Icons.star_rounded, size: 48, color: Theme.of(context).colorScheme.primary);
    },
  );
}

Future<void> defaultSuccessDialogCallback(
  BuildContext context,
  WidgetBuilder successDialogBuilder,
) async {
  await showDialog(context: context, builder: successDialogBuilder);

  if (context.mounted) {
    Navigator.of(context).pop();
  }
}

class DefaultDialogTextConfig {
  final String title;
  final String remindLaterText;
  final String iLikeItText;
  final String itCouldBeBetterText;

  DefaultDialogTextConfig({
    required this.title,
    required this.remindLaterText,
    required this.iLikeItText,
    required this.itCouldBeBetterText,
  });
}

class DoYouLoveUsDefaultDialog extends StatefulWidget {
  final DefaultDialogTextConfig textConfig;
  final WidgetBuilder? starsBuilder;

  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onRemindLater;

  final Color? primaryColor;

  const DoYouLoveUsDefaultDialog({
    super.key,
    required this.textConfig,
    required this.onLike,
    required this.onDislike,
    required this.onRemindLater,
    required this.starsBuilder,
    this.primaryColor,
  });

  @override
  State<DoYouLoveUsDefaultDialog> createState() => _DoYouLoveUsDefaultDialogState();
}

class _DoYouLoveUsDefaultDialogState extends State<DoYouLoveUsDefaultDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(16),
      children: <Widget>[
        Column(
          children: [
            const SizedBox(height: 8),
            Text(
              widget.textConfig.title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 12),
            SizedBox(width: 220, child: DefaultStarsView(starBuilder: widget.starsBuilder)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DefaultButtonView.secondary(
                    borderRadius: 8,
                    callback: widget.onDislike,
                    customBackgroundColor: widget.primaryColor?.withValues(alpha: 0.1),
                    customChild: Text(
                      widget.textConfig.itCouldBeBetterText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: widget.primaryColor ?? Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DefaultButtonView(
                    borderRadius: 8,
                    title: widget.textConfig.iLikeItText,
                    callback: widget.onLike,
                    customBackgroundColor: widget.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DefaultButtonView.transparent(
              customTextColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              callback: widget.onRemindLater,
              title: widget.textConfig.remindLaterText,
            ),
          ],
        ),
      ],
    );
  }

  VoidCallback callback(VoidCallback action) {
    return () {
      Navigator.of(context).pop();
      action.call();
    };
  }
}

SimpleDialog makeInformDialog({
  required BuildContext context,
  required String title,
  Widget? child,
  String? subtitle2,
  String? buttonTitle,
  bool negative = false,
  bool subtitleCentered = true,
  Color? customButtonColor,
}) {
  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    backgroundColor: Theme.of(context).colorScheme.surface,
    contentPadding: const EdgeInsets.all(16),
    children: <Widget>[
      Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        overflow: title.length > 400 ? TextOverflow.ellipsis : null,
        maxLines: title.length > 400 ? 4 : null,
      ),
      const SizedBox(height: 16.0),
      if (subtitle2 != null) ...[
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtitle2,
            textAlign: subtitleCentered ? TextAlign.center : TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        const SizedBox(height: 24.0),
      ],
      if (child != null)
        Padding(padding: const EdgeInsets.only(bottom: 24, right: 16, left: 16.0), child: child),
      DefaultButtonView(
        borderRadius: 8.0,
        title: buttonTitle ?? 'OK',
        customBackgroundColor:
            customButtonColor ?? (negative ? Theme.of(context).colorScheme.error : null),
        callback: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Future<void> defaultPopCallback(BuildContext context) async {
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}

Future<void> defaultWriteFeedbackCallback(BuildContext context, Widget writeFeedbackPage) async {
  await Navigator.of(context).push<void>(
    MaterialPageRoute(
      builder: (context) {
        return writeFeedbackPage;
      },
    ),
  );
}
