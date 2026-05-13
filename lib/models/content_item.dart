import 'package:flutter/material.dart';

class ContentItem {
  const ContentItem({
    required this.title,
    required this.description,
    required this.tag,
    required this.icon,
  });

  final String title;
  final String description;
  final String tag;
  final IconData icon;
}
