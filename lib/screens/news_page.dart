import 'package:flutter/material.dart';

import 'space_menu_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceMenuPage(
      menu: 'articles',
      title: 'Berita Terkini',
      subtitle: 'Artikel terbaru dari Spaceflight News API.',
    );
  }
}
