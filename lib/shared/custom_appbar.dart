import 'package:flutter/material.dart';
import 'package:moviemax/shared/colors.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    this.backgroundColor,
    this.gradientColor,
    this.leading,
    this.onBackPressed,
    this.onActionPressed,
    this.title,
    this.titleColor,
    this.image,
    required this.icon,
  }) : super(key: key);

  final Color? backgroundColor;
  final Gradient? gradientColor;
  final Widget? leading;
  final VoidCallback? onBackPressed;
  final VoidCallback? onActionPressed;
  final String? title;
  final Color? titleColor;
  final String? image;
  final int icon;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.2);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: widget.preferredSize.height,
            decoration: BoxDecoration(
              gradient: widget.gradientColor,
              color: widget.backgroundColor ?? Colors.transparent,
            ),
            child: widget.icon == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.sort_rounded,
                          color: widget.titleColor ?? MovieMaxColors.white,
                        ),
                        onPressed: () {},
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 30,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications_rounded,
                          color: widget.titleColor ?? MovieMaxColors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                : null,
          ),
          if (widget.icon == 2)
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onBackPressed,
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: widget.titleColor ?? MovieMaxColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onActionPressed,
                      child: Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: widget.titleColor ?? MovieMaxColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
