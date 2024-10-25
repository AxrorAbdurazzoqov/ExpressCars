import 'package:express_cars/src/features/home/presentation/screen/set_location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: context.getWidth(0.06)),
        child: SvgPicture.asset(AppVectors.instance.dashboard),
      ),
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetLocationScreen()),
          );
        },
        child: Row(
          children: [
            SvgPicture.asset(
              AppVectors.instance.location,
            ),
            const SizedBox(width: 5),
            Text(
              "Mirzo Ulug'bek, Tashkent",
              style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SvgPicture.asset(AppVectors.instance.dropButton),
          ],
        ),
      ),
      actions: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            height: 35,
            width: 35,
            fit: BoxFit.cover,
            FirebaseAuth.instance.currentUser?.photoURL ?? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=',
          ),
        ),
        SizedBox(width: context.getWidth(0.06)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
