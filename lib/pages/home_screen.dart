import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inkflowai/models/activity.dart';
import 'package:inkflowai/widgets/activity_widget.dart';
import 'package:inkflowai/widgets/custom_appbar.dart';
import 'package:inkflowai/widgets/custom_drawer.dart';
import 'package:inkflowai/widgets/persistent_header.dart';

class HomeScreen extends StatefulWidget {
  final User? user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(activities.length, (index) {
          Activity activity = activities[index];

          return ActivityWidget(activity: activity);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: CustomDrawer(user: widget.user!),
      key: globalKey,
      appBar: PreferredSize(
        preferredSize: Size(size.width, kToolbarHeight),
        child: CustomMainAppbar(
          user: widget.user,
          globalKey: globalKey,
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
              pinned: false, delegate: PersistentHeader(ctx: context)),
          SliverToBoxAdapter(
            child: _buildBody(),
          )
        ],
      ),
    );
  }
}
