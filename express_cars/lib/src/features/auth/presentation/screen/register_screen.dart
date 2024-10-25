import 'package:animate_do/animate_do.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/src/core/common/custom_elevated_button.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/core/extensions/show_custom_snack_bar.dart';
import 'package:express_cars/src/core/utils/app_validators.dart';
import 'package:express_cars/src/core/utils/firebase_auth_service.dart';
import 'package:express_cars/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:express_cars/src/features/auth/presentation/screen/login_screen.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_suggestion_widget.dart';
import 'package:express_cars/src/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:express_cars/src/features/navigation/screen/navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
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
                  const SizedBox(height: 18),
                  BounceInDown(
                    delay: const Duration(milliseconds: 300),
                    child: SafeArea(
                        child: CustomAppLogo(),
                      ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        BounceInDown(
                          delay: const Duration(milliseconds: 200),
                          child: CustomTextFormField(controller: _fullNameController, hinText: 'Name', validator: AppValidators.name),
                        ),
                        const SizedBox(height: 10),
                        BounceInDown(
                          delay: const Duration(milliseconds: 350),
                          child: CustomTextFormField(controller: _emailController, hinText: 'Email Address', validator: AppValidators.email),
                        ),
                        const SizedBox(height: 10),
                        BounceInDown(
                          delay: const Duration(milliseconds: 500),
                          child: CustomTextFormField(controller: _usernameController, hinText: 'Password', validator: AppValidators.name, isSecured: true),
                        ),
                        const SizedBox(height: 10),
                        BounceInDown(
                          delay: const Duration(milliseconds: 750),
                          child: CustomTextFormField(controller: _passwordController, hinText: 'Confirm Password', isSecured: true, textInputAction: TextInputAction.done, validator: AppValidators.password),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    onTap: () {
                      if (_globalKey.currentState!.validate()) {
                        FirebaseService.instance.createAccountWithEmail(
                          email: _emailController.text,
                          password: _passwordController.text,
                          username: _usernameController.text,
                          onSuccess: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navigation()), (_) => false),
                          onFailure: () => context.showCustomSnackBar(color: AppColors.instance.red, title: 'Failed to create account'),
                        );
                        context.read<AuthState>().add(
                              UploadUserInfoEvent(
                                fullname: _fullNameController.text,
                                email: _emailController.text,
                                username: _usernameController.text,
                              ),
                            );
                      }
                    },
                    title: 'Signup',
                    height: context.getHeight(0.08),
                    borderRadius: 15,
                    width: context.getWidth(1),
                  ),
                  BounceInUp(
                    child: CustomSuggestionWidget(
                      title: 'Already have an account',
                      suggestion: '\tLogin',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
