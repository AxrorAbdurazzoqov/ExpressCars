import 'package:express_cars/src/core/common/custom_info_card.dart';
import 'package:express_cars/src/core/extensions/context_text_theme.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_event.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandCarsScreen extends StatefulWidget {
  final String brandName;
  const BrandCarsScreen({super.key, required this.brandName});

  @override
  State<BrandCarsScreen> createState() => _BrandCarsScreenState();
}

class _BrandCarsScreenState extends State<BrandCarsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchBrandCarsEvent(brandName: widget.brandName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.brandName,
          style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.success) {
                return ListView.separated(
                  itemCount: state.brandCarsData?.length ?? 0,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return CustomInfoCard(model: state.brandCarsData![index]);
                  },
                );
              } else if (state.status == HomeStatus.failure) {
                return Center(
                  child: Text(state.errorMessage ?? 'Something went wrong'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
