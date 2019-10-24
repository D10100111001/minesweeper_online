import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_context_menu_web/context_menu.dart';
import 'package:minesweeper_online/helpers/box_decoration.dart';
import 'package:minesweeper_online/models/square.dart';
import 'package:minesweeper_online/models/square_state_type.dart';
import 'package:minesweeper_online/models/square_type.dart';

class SquareTile extends StatelessWidget {
  final Square square;
  final bool showContents;
  final Function onOpen;
  final Function onMark;
  const SquareTile(
      {@required this.square,
      @required this.onOpen,
      @required this.onMark,
      this.showContents});

  Widget buildTileBorder(
      bool opened, Widget child, ToggleButtonsThemeData themeData) {
    BoxDecoration decoration;
    if (opened)
      decoration = BoxDecoration(
        color: themeData.fillColor,
        border: Border.all(
          width: 1.0,
          color: themeData.selectedBorderColor,
        ),
      );
    else {
      decoration = BoxDecorationHelper.buildMinesweeperDecoration(themeData);
    }

    return SizedBox(
      height: 16.0,
      width: 16.0,
      child: DecoratedBox(
        decoration: decoration,
        child: MouseRegion(
          onEnter: (e) {},
          onExit: (e) {},
          child: Listener(
            onPointerDown: (e) {
              if (e.buttons == 2) {
                toggleDefaultContextMenu(false);
                onMark();
              }
            },
            child: InkWell(
              child: Center(
                child: child,
              ),
              onTap: onOpen,
              onLongPress: onMark,
            ),
          ),
        ),
      ),
    );
  }

  Widget createTile(Square square, ThemeData themeData) {
    String tileText = "";
    Color testColor = Colors.black;
    var toggleThemeData = themeData.toggleButtonsTheme;
    final stackItems = <Widget>[];
    switch (square.state) {
      case SquareStateType.Flagged:
        tileText = "`";
        continue closed;
      case SquareStateType.Marked:
        tileText = "?";
        continue closed;
      closed:
      case SquareStateType.Closed:
        if (showContents && tileText == "") continue opened;
        break;
      case SquareStateType.WrongFlagged:
        stackItems.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        tileText = "*";
        break;
      case SquareStateType.TriggerMine:
        toggleThemeData = toggleThemeData.copyWith(fillColor: Colors.red);
        continue opened;
      opened:
      case SquareStateType.Opened:
        tileText = square.type == SquareType.Mine
            ? "*"
            : square.adjacentMines.toString();
        testColor = square.type == SquareType.Mine
            ? testColor
            : (themeData.brightness == Brightness.light ||
                    square.color == Colors.transparent
                ? square.color
                : square.color.withAlpha(200));
        break;
    }
    return buildTileBorder(
        square.state == SquareStateType.Opened ||
            square.state == SquareStateType.WrongFlagged ||
            square.state == SquareStateType.TriggerMine,
        Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Text(
              tileText,
              style: TextStyle(
                  color: testColor,
                  fontFamily: themeData.textTheme.body2.fontFamily),
            ),
            ...stackItems,
          ],
        ),
        toggleThemeData);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return createTile(square, themeData);
  }
}
