import 'package:flutter/material.dart';

enum ButtonType { normal, secondary, transparent, border }

class DefaultButtonView extends StatelessWidget {
  const DefaultButtonView({
    super.key,
    required this.callback,
    this.title,
    this.borderRadius,
    this.isLoading = false,
    this.customBackgroundColor,
    this.customChild,
    this.isError = false,
  }) : type = ButtonType.normal,
       customTextColor = null,
       borderColor = null,
       borderWidth = null;

  const DefaultButtonView.secondary({
    super.key,
    required this.callback,
    this.title,
    this.borderRadius,
    this.isLoading = false,
    this.customChild,
    this.isError = false,
    this.customTextColor,
    this.customBackgroundColor,
  }) : type = ButtonType.secondary,
       borderColor = null,
       borderWidth = null;

  const DefaultButtonView.border({
    super.key,
    required this.callback,
    this.title,
    this.borderRadius,
    this.isLoading = false,
    this.customChild,
    this.isError = false,
    this.customTextColor,
    this.customBackgroundColor,
    this.borderColor,
    this.borderWidth,
  }) : type = ButtonType.border;

  const DefaultButtonView.transparent({
    super.key,
    required this.callback,
    this.title,
    this.borderRadius,
    this.isLoading = false,
    this.customChild,
    this.customTextColor,
  }) : type = ButtonType.transparent,
       isError = false,
       customBackgroundColor = null,
       borderColor = null,
       borderWidth = null;

  final String? title;
  final VoidCallback? callback;
  final double? borderRadius;
  final double? borderWidth;
  final bool isLoading;
  final Widget? customChild;

  final ButtonType type;
  final bool isError;

  final Color? customTextColor;
  final Color? customBackgroundColor;
  final Color? borderColor;

  Color textColor(BuildContext context) {
    if (customTextColor != null) {
      return customTextColor!;
    }

    if (isError) {
      return Theme.of(context).colorScheme.error;
    }

    if (type == ButtonType.transparent || type == ButtonType.border) {
      return Theme.of(context).colorScheme.onSurface;
    }

    if (type != ButtonType.secondary) {
      return Theme.of(context).colorScheme.onSecondary;
    }

    return Theme.of(context).colorScheme.primary;
  }

  Color? backgroundColor(BuildContext context) {
    if (customBackgroundColor != null) {
      return customBackgroundColor;
    }

    if (type == ButtonType.transparent) {
      return Colors.transparent;
    }

    if (type == ButtonType.border) {
      return Theme.of(context).colorScheme.primary.withValues(alpha: 0.05);
    }

    if (type == ButtonType.secondary) {
      if (isError) {
        return Theme.of(context).colorScheme.error.withValues(alpha: 0.1);
      }

      return Theme.of(context).colorScheme.primary.withValues(alpha: 0.1);
    }

    return null;
  }

  TextStyle textStyle(BuildContext context) {
    return type == ButtonType.normal
        ? Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium!;
  }

  BoxBorder? getBorder(BuildContext context) {
    return type == ButtonType.border
        ? Border.all(
            color: (borderColor ?? Theme.of(context).colorScheme.primary).withValues(alpha: 1),
            width: borderWidth ?? 0.4,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return _SimpleButton(
      title: title ?? '',
      textStyle: textStyle(context).copyWith(color: textColor(context)),
      border: getBorder(context),
      borderRadius: borderRadius ?? 12.0,
      callback: callback,
      backgroundColor: backgroundColor(context),
      child:
          customChild ??
          (isLoading
              ? SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(color: textColor(context)),
                )
              : null),
    );
  }
}

class _SimpleButton extends StatelessWidget {
  final String title;
  final VoidCallback? callback;
  final Widget? child;
  final double borderRadius;
  final Color? backgroundColor;

  final TextStyle? textStyle;
  final BoxBorder? border;

  const _SimpleButton({
    this.callback,
    required this.title,
    this.child,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.textStyle,
    this.border,
  });

  Color getColor(BuildContext context) => backgroundColor ?? Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    bool isDisabled = callback == null;
    final style =
        (textStyle ??
        Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSecondary));
    return InkWell(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 256),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isDisabled
                ? Color.alphaBlend(Colors.white.withValues(alpha: 0.5), getColor(context))
                : getColor(context),

            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: callback,
              child: Center(
                child:
                    child ??
                    Text(title, semanticsLabel: title, style: style, textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
