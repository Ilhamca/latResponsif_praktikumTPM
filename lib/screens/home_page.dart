import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'blog_page.dart';
import 'news_page.dart';
import 'report_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EAF9),
      appBar: AppBar(
        title: Text('Hai, $username!'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2B2330),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(height: 4),
          _SimpleCard(
            title: 'News',
            description: 'Get an overview of the latest news from various sources. Easily link your users to the right websites',
            icon: Icons.newspaper_outlined,
            onTap: () {
              Get.to(() => const NewsPage());
            },
          ),
          SizedBox(height: 12),
          _SimpleCard(
            title: 'Blog',
            description: 'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast',
            icon: Icons.article_outlined,
            onTap: () {
              Get.to(() => const BlogPage());
            },
          ),
          SizedBox(height: 12),
          _SimpleCard(
            title: 'Report',
            description: 'Space stations and other missions often publish their data. With SNAP, you can include it in your app.',
            icon: Icons.assessment_outlined,
            onTap: () {
              Get.to(() => const ReportPage());
            },
          ),
        ],
      ),
    );
  }
}

class _SimpleCard extends StatelessWidget {
  const _SimpleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF2EDF9),
      borderRadius: BorderRadius.circular(18),
      elevation: 4,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: const Color(0xFF6C63FF)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF20172F),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B5F7B),
                            height: 1.35,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
