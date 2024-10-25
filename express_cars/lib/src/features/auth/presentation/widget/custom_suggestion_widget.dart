import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/core/extensions/show_custom_snack_bar.dart';
import 'package:express_cars/src/core/utils/firebase_auth_service.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_network_action_button.dart';
import 'package:express_cars/src/features/navigation/screen/navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';

class CustomSuggestionWidget extends StatelessWidget {
  const CustomSuggestionWidget({
    super.key,
    required this.title,
    required this.suggestion,
    required this.onTap,
  });

  final String title;
  final String suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  endIndent: context.getWidth(0.035),
                ),
              ),
              Text('Or continue with social account', style: context.textTheme.titleSmall),
              Expanded(child: Divider(indent: context.getWidth(0.035))),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomNetworkActionButton(
              title: "Google",
              icon: AppVectors.instance.google,
              onTap: () async {
                  await FirebaseService.instance.signInWithGoogle(
                    onSuccess: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navigation()), (_) => false),
                    onError: () => context.showCustomSnackBar(color: AppColors.instance.red, title: 'Failed to sign in with Google'),
                  );
                
              },
            ),
            CustomNetworkActionButton(
              title: "Guest",
              icon: AppVectors.instance.profile,
              onTap: () async {
                await FirebaseService.instance.signInAsGuest(
                  onSuccess: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navigation()), (_) => false),
                  onError: () => context.showCustomSnackBar(color: AppColors.instance.red, title: 'Failed to sign in as Guest'),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: RichText(
            text: TextSpan(
              text: title,
              style: context.textTheme.titleMedium,
              children: <InlineSpan>[
                TextSpan(text: suggestion, style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.greenAccent, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = onTap),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
