// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';
import 'package:express_cars/src/features/home/presentation/screen/brand_cars_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/common/custom_search_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBrandsScreen extends StatefulWidget {
  const AllBrandsScreen({super.key});

  @override
  State<AllBrandsScreen> createState() => _AllBrandsScreenState();
}

class _AllBrandsScreenState extends State<AllBrandsScreen> {
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
          'All Brands',
          style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            CustomSearchTextField(controller: _searchController),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'All Brands',
                style: context.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.brandsData?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BrandCarsScreen(brandName: state.brandsData![index].name),
                            ),
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.instance.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              height: 50,
                              width: 50,
                              state.brandsData![index].image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          title: Text(state.brandsData![index].name),
                          subtitle: Text("${state.brandsData![index].avaible.length} Cars Available"),
                          trailing: Icon(CupertinoIcons.chevron_right),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
