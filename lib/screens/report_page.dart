import 'package:flutter/material.dart';

import 'space_menu_page.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceMenuPage(
      menu: 'reports',
      title: 'Report Terkini',
      subtitle: 'Laporan terbaru dari Spaceflight News API.',
    );
  }
}
