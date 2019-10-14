import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/responsive_widget.dart';

class Page extends StatelessWidget {
  final Widget child;
  const Page({Key key, this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AnimatedPadding(
            duration: Duration(seconds: 1),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
            child: ResponsiveWidget(
              largeScreen: child,
            ),
          ),
        ),
      ),
    );
  }
}
