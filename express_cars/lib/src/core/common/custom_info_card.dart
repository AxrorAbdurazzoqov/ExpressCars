import 'package:cached_network_image/cached_network_image.dart';
import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/utils/hive_service.dart';
import 'package:express_cars/src/features/detail/presentation/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

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
                CachedNetworkImage(
                  imageUrl: model.imageUrl,
                  imageBuilder: (context, imageProvider) => Image.network(
                    height: 150,
                    width: double.infinity,
                    model.imageUrl,
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.instance.grey,
                    highlightColor: AppColors.instance.grey.withValues(alpha: 0.3),
                    child: Image.network(
                      height: 150,
                      width: double.infinity,
                      model.imageUrl,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.instance.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (HiveService.instance.readData(key: model.carId) == null) {
                        HiveService.instance.writeData(key: model.carId, value: model);
                      } else {
                        HiveService.instance.deleteData(key: model.carId);
                      }
                    });
                  },
                  icon: SvgPicture.asset(
                    AppVectors.instance.like,
                    colorFilter: HiveService.instance.readData(key: model.carId) != null ? ColorFilter.mode(AppColors.instance.amber, BlendMode.srcIn) : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
