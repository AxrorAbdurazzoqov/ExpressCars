import 'package:dio/dio.dart';
import 'package:express_cars/src/core/utils/hive_service.dart';
import 'package:express_cars/src/features/detail/data/data_source/detail_data_source.dart';
import 'package:express_cars/src/features/detail/data/repository/detail_repository.dart';
import 'package:express_cars/src/features/detail/domain/usecase/book_car_by_id_usecase.dart';
import 'package:express_cars/src/features/detail/domain/usecase/fetch_car_by_id_usecase.dart';
import 'package:express_cars/src/features/detail/presentation/bloc/bloc/detail_bloc.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_all_cars_usecase.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_brand_cars_usecase.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_popular_cars_usecase.dart';
import 'package:express_cars/src/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/firebase_options.dart';
import 'package:express_cars/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:express_cars/src/features/home/data/data_source/home_data_source.dart';
import 'package:express_cars/src/features/home/data/repository/home_repository.dart';
import 'package:express_cars/src/features/home/domain/usecase/fetch_brands_usecase.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/navigation/bloc/navigation_bloc.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_bloc.dart';
import 'package:express_cars/src/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveService.instance.createBox();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  final Dio dio = Dio();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(
          create: (context) => HomeBloc(
            fetchBrandsUsecase: FetchBrandsUsecase(
              repository: HomeRepositoryImpl(
                dataSource: HomeDataSourceImpl(dio: dio),
              ),
            ),
            fetchPopularCarsUsecase: FetchPopularCarsUsecase(
              repository: HomeRepositoryImpl(
                dataSource: HomeDataSourceImpl(dio: dio),
              ),
            ),
            fetchAllCarsUsecase: FetchAllCarsUsecase(
              repository: HomeRepositoryImpl(
                dataSource: HomeDataSourceImpl(dio: dio),
              ),
            ),
            fetchBrandCarsUsecase: FetchBrandCarsUsecase(
              repository: HomeRepositoryImpl(
                dataSource: HomeDataSourceImpl(dio: dio),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DetailBloc(
            fetchCarByIdUsecase: FetchCarByIdUsecase(
              repository: DetailRepositoryImpl(
                dataSource: DetailDataSourceImpl(dio: dio),
              ),
            ),
            bookCarByIdUsecase: BookCarByIdUsecase(
              repository: DetailRepositoryImpl(
                dataSource: DetailDataSourceImpl(dio: dio),
              ),
            ),
          ),
        ),
      ],
      child: const ExpressCars(),
    ),
  );
}

class ExpressCars extends StatelessWidget {
  const ExpressCars({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpressCars',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
