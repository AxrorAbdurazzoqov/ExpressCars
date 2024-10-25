import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:express_cars/src/core/constants/vectors/app_vectors.dart';
import 'package:express_cars/src/features/navigation/bloc/navigation_bloc.dart';
import 'package:express_cars/src/features/navigation/bloc/navigation_event.dart';
import 'package:express_cars/src/features/navigation/widget/custom_active_icon.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<NavigationBloc>().state.screens[context.watch<NavigationBloc>().state.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: context.watch<NavigationBloc>().state.currentIndex,
        onTap: (index) {
          BlocProvider.of<NavigationBloc>(context).add(
            OnNavbarIndexChangedEvent(index: index),
          );
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "home",
            icon: SvgPicture.asset(AppVectors.instance.home),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.home),
          ),
          BottomNavigationBarItem(
            label: "favourite",
            icon: SvgPicture.asset(AppVectors.instance.favourite),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.favourite),
          ),
          BottomNavigationBarItem(
            label: "chat",
            icon: SvgPicture.asset(AppVectors.instance.chat),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.chat),
          ),
          BottomNavigationBarItem(
            label: "profile",
            icon: SvgPicture.asset(AppVectors.instance.profile),
            activeIcon: CustomActiveIcon(icon: AppVectors.instance.profile),
          ),
        ],
      ),
    );
  }
}
