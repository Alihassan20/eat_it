import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';
class Menu_widget extends StatelessWidget {
  String txt;
  IconData icon;
  final VoidCallback click;
   Menu_widget(this.txt, this.icon, this.click);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Icon(
              icon,
              color: kwhite,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(txt,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: kwhite))
          ],
        ),
      ),
    );
  }
}
