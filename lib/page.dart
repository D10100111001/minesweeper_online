import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper_online/responsive_widget.dart';
import 'package:minesweeper_online/state/game_manager_state.dart';
import 'package:provider/provider.dart';

class Page extends StatelessWidget {
  final Widget child;
  const Page({Key key, this.child}) : super();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gameManager = Provider.of<GameManagerState>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AnimatedPadding(
            duration: Duration(seconds: 1),
            padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0), //EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
            child: ResponsiveWidget(
              largeScreen: child,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isDarkMode)
              gameManager.setLightTheme();
            else
              gameManager.setDarkTheme();
          },
          child:
              Icon(isDarkMode ? Icons.brightness_low : Icons.brightness_high),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
