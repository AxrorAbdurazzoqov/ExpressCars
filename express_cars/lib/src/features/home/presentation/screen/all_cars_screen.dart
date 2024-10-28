import 'package:express_cars/src/core/common/custom_info_card.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_event.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';
import 'package:express_cars/src/features/home/presentation/widget/custom_filter_widget.dart';
import 'package:express_cars/src/core/common/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AllCarsScreen extends StatefulWidget {
  const AllCarsScreen({super.key});

  @override
  State<AllCarsScreen> createState() => _AllCarsScreenState();
}

class _AllCarsScreenState extends State<AllCarsScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool recommended = true;
  bool newModel = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchHomeScreenData());
  }

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
          'All Cars',
          style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.success && state.allCarsData != null) {
                List<String> types = state.allCarsData!.map((mp) => mp.type).toSet().toList();
                List<num> prices = state.allCarsData!.map((mp) => mp.pricePerMonth).toList();
                prices.sort();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomSearchTextField(controller: _searchController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 8),
                          children: [
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                scrollControlDisabledMaxHeightRatio: context.getHeight(0.7),
                                constraints: BoxConstraints(minHeight: context.getHeight(0.7)),
                                context: context,
                                builder: (context) {
                                  return CustomFilterWidget(
                                    minPrice: prices.first.toDouble(),
                                    maxPrice: prices.last.toDouble(),
                                    types: types,
                                  );
                                },
                              ),
                              child: Container(
                                height: 40,
                                width: 90,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.instance.greenAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppVectors.instance.filter),
                                    const SizedBox(width: 4),
                                    Text('Filter', style: context.textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            FilterChip(
                              selected: recommended,
                              label: Text('Recommended'),
                              onSelected: (value) {
                                if (value) context.read<HomeBloc>().add(OnFilteringEvent(filter: 'Recommended'));
                                setState(() {
                                  recommended = value;
                                  newModel = !value;
                                });
                              },
                            ),
                            const SizedBox(width: 5),
                            FilterChip(
                              selected: newModel,
                              label: Text('New Models'),
                              onSelected: (value) {
                                if (value) context.read<HomeBloc>().add(OnFilteringEvent(filter: 'New Models'));
                                setState(() {
                                  newModel = value;
                                  recommended = !value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ListView(
                        padding: EdgeInsets.only(right: 20),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          state.allCarsData?.length ?? 0,
                          (index) => state.allCarsData != null
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: CustomInfoCard(model: state.allCarsData![index]),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
