import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/body_wrapper.dart';
import 'package:inkflowai/widgets/custom_appbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdaptiveUI extends StatelessWidget {
  final String appbarTitle;
  final Widget body;
  final List<Widget> actions;
  final bool isScrollable;
  const AdaptiveUI({
    super.key,
    required this.appbarTitle,
    required this.body,
    required this.actions,
    required this.isScrollable,
  });

  Widget buildBody(BuildContext context) {
    return isScrollable
        ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BodyWrapper(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: body,
              ),
            ),
          )
        : BodyWrapper(
            child: body,
          );
  }

  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 4,
          child: Align(alignment: Alignment.topLeft, child: buildBody(context)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isMobile =
            sizingInformation.isMobile || sizingInformation.isTablet;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(size.width, kToolbarHeight),
            child: CustomAppbar(
              title: appbarTitle,
              actions: actions,
            ),
          ),
          body: isMobile ? buildBody(context) : buildDesktop(context),
        );
      },
    );
  }
}
