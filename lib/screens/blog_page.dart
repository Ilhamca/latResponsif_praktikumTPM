import 'package:flutter/material.dart';

import 'space_menu_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceMenuPage(
      menu: 'blogs',
      title: 'Blog Terkini',
      subtitle: 'Posting blog terbaru dari Spaceflight News API.',
    );
  }
}
