import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/home/presentation/widget/custom_place_card.dart';
import 'package:express_cars/src/core/common/custom_search_field.dart';
import 'package:flutter/material.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search Location',
          style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            CustomSearchTextField(controller: _searchController),
            const SizedBox(height: 20),
            CustomPlaceCard(
              color: AppColors.instance.greenAccent,
              icon: Icons.local_cafe,
              title: 'Coffee',
              subtitle: '150 places',
            ),
            const SizedBox(height: 10),
            CustomPlaceCard(
              color: AppColors.instance.red,
              icon: Icons.local_movies,
              title: 'Cinema',
              subtitle: '8 places',
            ),
          ],
        ),
      ),
    );
  }
}