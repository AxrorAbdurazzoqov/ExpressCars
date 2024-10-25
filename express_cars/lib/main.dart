import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:express_cars/firebase_options.dart';
import 'package:express_cars/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:express_cars/src/features/home/data/data_source/home_data_source.dart';
import 'package:express_cars/src/features/home/data/repository/home_repository.dart';
import 'package:express_cars/src/features/home/domain/usecase/get_rentals_usecase.dart';
import 'package:express_cars/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:express_cars/src/features/navigation/bloc/navigation_bloc.dart';
import 'package:express_cars/src/features/onboarding/bloc/bloc/onboarding_bloc.dart';
import 'package:express_cars/src/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final NotificationService notificationService = NotificationService();
  // await notificationService.init();
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
        BlocProvider(
          create: (context) => HomeBloc(
            getRentalsUsecase: GetRentalsUsecase(
              repository: HomeRepositoryImpl(
                dataSource: HomeDataSourceImpl(dio: dio),
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
