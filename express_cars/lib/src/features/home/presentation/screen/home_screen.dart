import 'package:express_cars/src/core/common/custom_info_card.dart';
import 'package:express_cars/src/core/constants/colors/app_colors.dart';
import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/core/extensions/mediaquery_size.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_event.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';
import 'package:express_cars/src/features/home/presentation/screen/set_location_screen.dart';
import 'package:express_cars/src/features/home/presentation/widget/brands_list_view_builder.dart';
import 'package:express_cars/src/features/home/presentation/widget/custom_category_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/home/presentation/widget/custom_search_field.dart';
import 'package:express_cars/src/features/home/presentation/widget/home_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetRentalsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text.rich(
                      TextSpan(
                        text: 'Hello ${FirebaseAuth.instance.currentUser?.displayName?.split(' ')[0] ?? User} 👋\n',
                        style: context.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                            text: "Let's find your favourite car here",
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CustomSearchTextField(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SetLocationScreen()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.instance.greenAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            AppVectors.instance.filter,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    CustomCategoryWidget(
                      title: 'Trending Brands',
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 120,
                      child: BrandsListViewBuilder(state: state),
                    ),
                    CustomCategoryWidget(
                      title: "Popular Cars",
                      onTap: () {},
                    ),
                    SizedBox(
                      height: context.getHeight(0.35) * state.data.length,
                      width: double.infinity,
                      child: ListView.separated(
                        itemCount: state.data.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          return CustomInfoCard(model: state.data[index].cars[0]);
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is HomeFailure) {
                return Center(child: Text(state.errorMessage));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
