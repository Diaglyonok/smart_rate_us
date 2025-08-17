import 'package:flutter/material.dart';
import 'package:smart_rate_us/default/views/default_button_view.dart';
import 'package:smart_rate_us/default/views/default_decoration.dart';

Widget buildDefaultWriteUsPageWidget(
  BuildContext context,
  bool isLoading,
  void Function(Map<String, dynamic> feedback) onSend,
) {
  return DefaultWriteFeedbackScreen(
    isButtonLoading: isLoading,
    onSend: onSend,
    userEmail: 'user@example.com',
    config: DefaultWriteFeedbackConfig(
      howBecomeBetterText: 'How can we become better?',
      pleaseDescribeIssuesText: 'Please describe the issues',
      emailText: 'Email',
      emailForResposeDescriptionText: 'Email for response',
      writeYourFeedbackHereText: 'Write your feedback here',
      writeYourEmailText: 'Write your email',
      sendFeedbackText: 'Send feedback',
    ),
  );
}

class DefaultWriteFeedbackConfig {
  final String howBecomeBetterText;
  final String pleaseDescribeIssuesText;
  final String emailText;
  final String emailForResposeDescriptionText;
  final String writeYourFeedbackHereText;
  final String writeYourEmailText;
  final String sendFeedbackText;

  const DefaultWriteFeedbackConfig({
    required this.howBecomeBetterText,
    required this.pleaseDescribeIssuesText,
    required this.emailText,
    required this.emailForResposeDescriptionText,
    required this.writeYourFeedbackHereText,
    required this.writeYourEmailText,
    required this.sendFeedbackText,
  });
}

class DefaultWriteFeedbackScreen extends StatefulWidget {
  final DefaultWriteFeedbackConfig config;
  final bool isButtonLoading;
  final String? userEmail;
  final void Function(Map<String, dynamic> feedback) onSend;

  const DefaultWriteFeedbackScreen({
    super.key,
    required this.config,
    required this.isButtonLoading,
    required this.onSend,
    this.userEmail,
  });

  @override
  State<DefaultWriteFeedbackScreen> createState() => _DefaultWriteFeedbackScreenState();
}

class _DefaultWriteFeedbackScreenState extends State<DefaultWriteFeedbackScreen> {
  late TextEditingController emailController;
  final TextEditingController controller = TextEditingController();
  final FocusNode feedbackFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.userEmail ?? '');
  }

  @override
  void dispose() {
    emailController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            widget.config.howBecomeBetterText,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Builder(
          builder: (context) {
            return ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                DecoratedBox(
                  decoration: getCardDecoration(context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.config.emailText} (${widget.config.emailForResposeDescriptionText}):',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        TextField(
                          selectionControls: getControls(context),
                          controller: emailController,
                          maxLines: 1,
                          onSubmitted: (value) {
                            feedbackFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface.withValues(alpha: 1),
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          cursorWidth: 1.0,
                          textCapitalization: TextCapitalization.none,
                          decoration: defaultDecoration(context),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          widget.config.pleaseDescribeIssuesText,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        TextField(
                          selectionControls: getControls(context),
                          controller: controller,
                          maxLines: null,
                          autofocus: true,
                          focusNode: feedbackFocusNode,
                          onSubmitted: (value) => _send(context),
                          textInputAction: TextInputAction.send,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          cursorWidth: 1.0,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: defaultDecoration(context),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DecoratedBox(
                  decoration: getCardDecoration(context),
                  child: DefaultButtonView(
                    title: widget.config.sendFeedbackText,
                    isLoading: widget.isButtonLoading,
                    callback: () => _send(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _send(BuildContext context) {
    if (controller.text == '') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(widget.config.writeYourFeedbackHereText)));
      return;
    }

    final String? email = emailController.text == '' ? widget.userEmail : emailController.text;

    if ((email ?? '').isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(widget.config.writeYourEmailText)));
      return;
    }

    widget.onSend({'feedback': controller.text, 'email': email});
  }
}
