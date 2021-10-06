import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/app_icons.dart';
import '../util/lo_form_info.dart';

class Navbar extends StatelessWidget {
  static const kHeight = 72.0;
  final ValueChanged<ThemeMode> onThemeChanged;

  const Navbar({
    Key? key,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Material(
      elevation: 1,
      child: Container(
        height: kHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'LoForm',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => launch(LoFormInfo.pub),
                  icon: const Icon(AppIcons.dart),
                ),
                IconButton(
                  onPressed: () => launch(LoFormInfo.repository),
                  icon: const Icon(AppIcons.github),
                ),
                IconButton(
                  onPressed: () {
                    onThemeChanged(
                      isLightTheme ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                  icon: Icon(
                    isLightTheme
                        ? Icons.nightlight_round
                        : Icons.wb_sunny_rounded,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
