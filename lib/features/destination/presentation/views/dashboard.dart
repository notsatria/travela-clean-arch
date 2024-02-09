import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travela/features/destination/presentation/cubit/dashboard_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<DashboardCubit>().page,
      bottomNavigationBar: Material(
        elevation: 10,
        child: BlocBuilder<DashboardCubit, int>(
          builder: (context, state) {
            return Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: NavigationBar(
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                  selectedIndex: state,
                  onDestinationSelected: (value) {
                    context.read<DashboardCubit>().change(value);
                  },
                  destinations: context
                      .read<DashboardCubit>()
                      .dashboardMenuList
                      .map((menu) {
                    return NavigationDestination(
                      label: menu[0].toString(),
                      icon: Icon(
                        menu[1],
                        color: Colors.grey,
                      ),
                      tooltip: menu[0].toString(),
                      selectedIcon: Icon(
                        menu[1],
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }).toList()),
            );
          },
        ),
      ),
    );
  }
}
