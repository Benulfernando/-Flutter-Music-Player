import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_selector.dart';
import 'package:provider/provider.dart';
class NeuBox extends StatelessWidget {

  final Widget? child;
  const NeuBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4, 4)
          ),
          BoxShadow(
              color: isDarkMode ? Colors.grey.shade800:Colors.white,
              blurRadius: 15,
              offset: const Offset(-4, -4)
          )
        ]
      ),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
