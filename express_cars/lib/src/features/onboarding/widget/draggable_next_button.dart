import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/auth/presentation/screen/login_screen.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_bloc.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraggableNextButton extends StatefulWidget {
  const DraggableNextButton({super.key});

  @override
  DraggableNextButtonState createState() => DraggableNextButtonState();
}

class DraggableNextButtonState extends State<DraggableNextButton> {
  double dX = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          dX = (dX + details.delta.dx).clamp(0, 65);
        });
      },
      onHorizontalDragEnd: (details) {
        dX = 0;
        context.read<OnboardingBloc>().add(
              OnIndexChangedEvent(
                index: BlocProvider.of<OnboardingBloc>(context).state.index+1,
                onSuccess: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (_) => false),
              ),
            );
      },
      child: Container(
        height: 55,
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.instance.grey.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              bottom: 0,
              child: Row(
                children: List.generate(
                  3,
                  (index) {
                    return Icon(
                      CupertinoIcons.chevron_right,
                      size: 20,
                      color: AppColors.instance.black.withValues(alpha: ((index + 1) * 3) / 10),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Transform.translate(
                offset: Offset(dX, 0),
                child: Container(
                  height: 55,
                  width: 110,
                  decoration: BoxDecoration(
                    color: AppColors.instance.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: context.textTheme.titleLarge!.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
