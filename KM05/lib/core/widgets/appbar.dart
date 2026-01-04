import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;

  static const TextStyle titleTextStyle1 = TextStyle(
    color: AppColors.darkBlue,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleTextStyle2 = TextStyle(
    color: AppColors.darkYellow,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  const AppAppBar({
    super.key,
    this.title,
    this.titleText,
    this.actions,
  }) : assert(title == null || titleText == null, 'Cannot provide both title and titleText');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      toolbarHeight: 120,
      centerTitle: true,
      title: title ?? (titleText != null 
        ? Text(
            titleText!,
          )
        : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

