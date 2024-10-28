import 'package:express_cars/src/core/common/brand_model.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/features/home/presentation/screen/brand_cars_screen.dart';
import 'package:flutter/material.dart';

class BrandsListViewBuilder extends StatelessWidget {
  final List<BrandModel> data;
  const BrandsListViewBuilder({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BrandCarsScreen(brandName: data[index].name),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  height: 70,
                  width: 70,
                  data[index].image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 5),
              Text(data[index].name),
            ],
          ),
        );
      },
    );
  }
}
