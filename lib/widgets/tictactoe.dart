import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants/colors.dart';

class TicTacToeCell extends StatelessWidget {
  const TicTacToeCell({super.key, required this.iconName});
  final String iconName;

  @override
  Widget build(BuildContext context) {
    Icon icon;
    switch (iconName) {
      case 'cross':
        icon = const Icon(
          Icons.close_rounded,
          size: 38,
          color: MyColors.success,
        );
      case 'circle':
        icon = const Icon(
          Icons.circle_outlined,
          size: 38,
          color: MyColors.orange,
        );
      default:
        icon = const Icon(
          Icons.edit,
          size: 38,
          color: MyColors.editIcon,
        );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
