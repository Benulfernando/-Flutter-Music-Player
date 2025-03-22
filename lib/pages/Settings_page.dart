import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_selector.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S",
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(25),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode",
              style: TextStyle(
                fontSize: 15
              ),),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return CupertinoSwitch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme(); // Correctly calling the function
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
