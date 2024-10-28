import 'package:express_cars/src/core/common/custom_info_card.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/core/utils/hive_service.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late final List favouriteCars;

  @override
  void initState() {
    super.initState();
    favouriteCars = HiveService.instance.readAllData.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favourite Cars'),
      ),
      body: SizedBox(
        height: context.getHeight(1),
        width: double.infinity,
        child: ListView.separated(
          itemCount: favouriteCars.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return CustomInfoCard(
              model: favouriteCars[index],
            );
          },
        ),
      ),
    );
  }
}
