class SpaceContentItem {
  const SpaceContentItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.newsSite,
    required this.publishedAt,
    required this.url,
    required this.authors,
  });

  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String newsSite;
  final String publishedAt;
  final String url;
  final List<String> authors;

  factory SpaceContentItem.fromJson(Map<String, dynamic> json) {
    final List<dynamic> authorList = json['authors'] as List<dynamic>? ?? const [];
    return SpaceContentItem(
      id: json['id'] as int,
      title: (json['title'] as String?)?.trim() ?? '',
      imageUrl: (json['image_url'] as String?)?.trim() ?? '',
      summary: (json['summary'] as String?)?.trim() ?? '',
      newsSite: (json['news_site'] as String?)?.trim() ?? '',
      publishedAt: (json['published_at'] as String?)?.trim() ?? '',
      url: (json['url'] as String?)?.trim() ?? '',
      authors: authorList
          .map((author) => (author as Map<String, dynamic>)['name']?.toString().trim() ?? '')
          .where((name) => name.isNotEmpty)
          .toList(),
    );
  }

  String get authorLabel => authors.isEmpty ? newsSite : authors.join(', ');

  String get publishedLabel {
    final DateTime? date = DateTime.tryParse(publishedAt)?.toLocal();
    if (date == null) {
      return publishedAt;
    }

    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}