import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travela/features/destination/presentation/views/home_view.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  change(int index) => emit(index);

  final List dashboardMenuList = [
    ['Home', Icons.home, const HomeView()],
    ['Near', Icons.near_me, const Center(child: Text('Near'))],
    ['Favourite', Icons.favorite, const Center(child: Text('Favorite'))],
    ['Profile', Icons.person, const Center(child: Text('Profile'))],
  ];

  Widget get page => dashboardMenuList[state][2];
}
