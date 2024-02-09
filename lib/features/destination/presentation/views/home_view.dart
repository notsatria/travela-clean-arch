import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travela/features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:travela/features/destination/presentation/views/text_failure.dart';
import 'package:travela/features/destination/presentation/widgets/circle_loading.dart';
import 'package:travela/features/destination/presentation/widgets/custom_chip.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController topDestinationPageController = PageController();

  refresh() {
    context.read<TopDestinationBloc>().add(GetTopDestinationEvent());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => refresh(),
      child: ListView(
        children: [
          const Gap(30.0),
          header(),
          const Gap(20.0),
          search(),
          const Gap(24.0),
          categories(),
          const Gap(20.0),
          topDestination(),
          const Gap(30.0),
          allDestination(),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: const CircleAvatar(
              radius: 16.0,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          const Gap(5.0),
          Text(
            'Hi, Dre!',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Spacer(),
          const Badge(
            backgroundColor: Colors.red,
            alignment: Alignment(0.6, -0.6),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                hintText: 'Search destination here...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Gap(10.0),
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }

  Widget categories() {
    List categories = [
      'Beach',
      'Lake',
      'Mountain',
      'Forest',
      'City',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: List.generate(
            categories.length,
            (index) => CustomChip(
              context: context,
              label: categories[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget topDestination() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Destination',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              BlocBuilder<TopDestinationBloc, TopDestinationState>(
                builder: (context, state) {
                  if (state is TopDestinationSuccess) {
                    return SmoothPageIndicator(
                      controller: topDestinationPageController,
                      count: state.data.length,
                      effect: WormEffect(
                        dotColor: Colors.grey[300]!,
                        activeDotColor: Theme.of(context).primaryColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
        const Gap(16.0),
        BlocBuilder<TopDestinationBloc, TopDestinationState>(
          builder: (context, state) {
            if (state is TopDestinationLoading) {
              return const CircleLoading();
            }
            if (state is TopDestinationFailure) {
              return TextFailure(message: state.message);
            }
            if (state is TopDestinationSuccess) {}
            return const SizedBox(
              height: 120,
            );
          },
        ),
      ],
    );
  }

  allDestination() {
    return const SizedBox();
  }
}
