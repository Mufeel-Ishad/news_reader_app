import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme_manager.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    final currentMode = themeManager.themeMode;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Choose Theme", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ListTile(
            title: const Text("System Default"),
            leading: Radio(
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (val) {
                themeManager.setTheme(val!);
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: const Text("Light"),
            leading: Radio(
              value: ThemeMode.light,
              groupValue: currentMode,
              onChanged: (val) {
                themeManager.setTheme(val!);
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: const Text("Dark"),
            leading: Radio(
              value: ThemeMode.dark,
              groupValue: currentMode,
              onChanged: (val) {
                themeManager.setTheme(val!);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
