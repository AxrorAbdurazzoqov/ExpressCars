import 'package:animate_do/animate_do.dart';
import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/core/extensions/show_custom_snack_bar.dart';
import 'package:express_cars/src/core/utils/app_validators.dart';
import 'package:express_cars/src/core/utils/firebase_auth_service.dart';
import 'package:express_cars/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:express_cars/src/features/auth/presentation/screen/register_screen.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_app_logo.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_suggestion_widget.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:express_cars/src/features/navigation/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: BounceInDown(
                      delay: const Duration(milliseconds: 300),
                      child: SafeArea(
                        child: CustomAppLogo(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Log in to your account using email or social networks',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium!.copyWith(
                        color: AppColors.instance.grey,
                      ),
                    ),
                  ),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        ElasticInRight(
                          delay: const Duration(milliseconds: 550),
                          child: CustomTextFormField(controller: _emailController, hinText: 'Email address', validator: AppValidators.email),
                        ),
                        const SizedBox(height: 10),
                        ElasticInRight(
                          delay: const Duration(milliseconds: 750),
                          child: CustomTextFormField(controller: _passwordController, hinText: 'Password', isSecured: true, textInputAction: TextInputAction.done, validator: AppValidators.password),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElasticInLeft(
                      delay: const Duration(milliseconds: 1200),
                      child: TextButton(
                          onPressed: () async {
                            if (_emailController.text.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text)) {
                              context.read<AuthBloc>().add(ResetPasswordEvent(email: _emailController.text));
                              context.showCustomSnackBar(color: AppColors.instance.blue, title: 'Check email to reset your password');
                            } else {
                              context.showCustomSnackBar(color: AppColors.instance.red, title: 'Enter email address');
                            }
                          },
                          child: Text(
                            'Reset Password?',
                            style: context.textTheme.titleMedium!.copyWith(color: AppColors.instance.greenAccent),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    onTap: () {
                      if (_globalKey.currentState!.validate()) {
                        FirebaseService.instance.signInWithEmail(
                          email: _emailController.text,
                          password: _passwordController.text,
                          onError: () => context.showCustomSnackBar(color: AppColors.instance.red, title: 'Failed to sign in with email'),
                          onSuccess: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navigation()), (_) => false),
                        );
                      }
                    },
                    title: 'Login',
                    borderRadius: 15,
                    height: context.getHeight(0.08),
                    width: context.getWidth(1),
                  ),
                  BounceInUp(
                    child: CustomSuggestionWidget(
                      title: "Didn't have an account",
                      suggestion: '\tSignup',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
