import 'package:flutter/material.dart';
import '../localization/custom_localizations.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = CustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('forgotPassword')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(localization.translate('forgotPasswordMessage')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(localization.translate('backToLogin')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
