import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/detail/presentation/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomInfoCard extends StatelessWidget {
  final CarInfoModel model;
  const CustomInfoCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                id: model.carId,
                name: model.name,
              ),
            ),
          ),
          child: Container(
            height: 250,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.instance.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Image.network(
                  height: 150,
                  width: double.infinity,
                  model.imageUrl,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${model.name} ${model.model}',
                      style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text((model.reviews.reduce((a, b) => a + b) / model.reviews.length).toString()),
                    SvgPicture.asset(AppVectors.instance.star),
                  ],
                ),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 28,
                      width: 28,
                      AppVectors.instance.motor,
                    ),
                    const SizedBox(width: 5),
                    Text('${model.features.engine}  hp'),
                    Spacer(),
                    SvgPicture.asset(
                      height: 24,
                      width: 24,
                      AppVectors.instance.automatic,
                    ),
                    const SizedBox(width: 5),
                    Text(model.features.transmission),
                    Spacer(),
                    Text(
                      '\$${model.pricePerMonth}',
                      style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.instance.grey.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(AppVectors.instance.favourite),
          ),
        ),
      ],
    );
  }
}
