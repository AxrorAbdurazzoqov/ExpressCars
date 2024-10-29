import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/auth/presentation/screen/login_screen.dart';
import 'package:express_cars/src/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'package:express_cars/src/features/profile/presentation/widget/custom_user_docs_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(FirebaseAuth.instance.currentUser!.photoURL ?? ''),
            ),
            const SizedBox(height: 10),
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? 'Guest',
              style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) {
                  return CustomUserDocsContainer(
                    icon: context.watch<ProfileBloc>().state.docsInfo[index]['icon'],
                    title: context.watch<ProfileBloc>().state.docsInfo[index]['title'],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: List.generate(
                3,
                (index) => CustomProfileActionListTile(
                  title: context.watch<ProfileBloc>().state.profileActions[index]['title'],
                  icon: context.watch<ProfileBloc>().state.profileActions[index]['icon'],
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (_) => false,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomProfileActionListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  const CustomProfileActionListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.instance.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon),
      ),
      title: Text(title),
      trailing: IconButton(
        icon: Icon(Icons.chevron_right_rounded),
        onPressed: onTap,
      ),
    );
  }
}
