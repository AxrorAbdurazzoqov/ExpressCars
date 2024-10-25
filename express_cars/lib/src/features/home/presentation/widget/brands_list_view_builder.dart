import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';
import 'package:flutter/material.dart';

class BrandsListViewBuilder extends StatelessWidget {
  final HomeSuccess state;
  const BrandsListViewBuilder({
    super.key, required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: state.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        return Column(
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
                state.data[index].image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 5),
            Text(state.data[index].name),
          ],
        );
      },
    );
  }
}