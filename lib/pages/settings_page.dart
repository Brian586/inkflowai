import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveUI(
      appbarTitle: "Settings",
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [ThemeSettings()],
      ),
      actions: [],
      isScrollable: true,
    );
  }
}

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  String selectedTheme = "light";
  int value = 0;

  onChanged(String theme) {
    switch (theme) {
      case "light":
        AdaptiveTheme.of(context).setLight();
        break;
      case "dark":
        AdaptiveTheme.of(context).setDark();
        break;
      case "system":
        AdaptiveTheme.of(context).setSystem();
        break;
    }
  }

  Widget alternativeIconBuilder(
      BuildContext context,
      AnimatedToggleProperties<String> local,
      GlobalToggleProperties<String> global) {
    IconData data = Icons.light_mode_outlined;
    switch (local.value) {
      case "light":
        data = Icons.light_mode_outlined;
        break;
      case "dark":
        data = Icons.dark_mode_outlined;
        break;
      case "system":
        data = Icons.brightness_medium_outlined;
        break;
    }
    return Icon(data);
  }

  String changeSelectedTheme(AdaptiveThemeMode mode) {
    if (mode.isLight) {
      return "light";
    } else if (mode.isDark) {
      return "dark";
    } else if (mode.isSystem) {
      return "system";
    } else {
      return "light";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (_, mode, child) {
        // update your UI
        selectedTheme = changeSelectedTheme(mode);

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set Theme",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(fontWeightDelta: 3),
              ),
              const Divider(
                height: 20.0,
                color: Colors.grey,
                thickness: 1.0,
              ),
              AnimatedToggleSwitch<String>.size(
                // textDirection: TextDirection.rtl,
                current: selectedTheme,
                values: const [
                  "light",
                  "dark",
                  "system",
                ],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(150),
                customIconBuilder: (context, local, global) {
                  bool isSelected = selectedTheme == local.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alternativeIconBuilder(
                          context,
                          local,
                          global,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          local.value,
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
                style: const ToggleStyle(borderColor: Colors.transparent),
                styleBuilder: (i) =>
                    const ToggleStyle(indicatorColor: Colors.deepPurple),
                onChanged: onChanged,
              )
            ],
          ),
        );
      },
    );
  }
}
