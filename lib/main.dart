import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travela/common/app_route.dart';
import 'package:travela/features/destination/presentation/bloc/all_destination/all_destination_bloc.dart';
import 'package:travela/features/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:travela/features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:travela/features/destination/presentation/cubit/dashboard_cubit.dart';
import 'package:travela/features/destination/presentation/views/dashboard.dart';
import 'package:travela/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (_) => DashboardCubit(),
        ),
        BlocProvider<AllDestinationBloc>(
            create: (_) => locator<AllDestinationBloc>()),
        BlocProvider<TopDestinationBloc>(
            create: (_) => locator<TopDestinationBloc>()),
        BlocProvider<SearchDestinationBloc>(
            create: (_) => locator<SearchDestinationBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const Dashboard(),
        initialRoute: AppRoute.dashboard,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
