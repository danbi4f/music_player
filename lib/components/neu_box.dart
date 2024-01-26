import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  const NeuBox({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {

    // is dark mode
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          // darker shadow on bottom right
          BoxShadow(
              color: isDark ? Colors.black : Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4)),
           BoxShadow(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              blurRadius: 15,
              offset:  const Offset(-4, -4)),

          // lighter shadow on bottom left
        ],
      ),
      child: child,
    );
  }
}
