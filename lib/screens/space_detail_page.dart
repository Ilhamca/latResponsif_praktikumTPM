import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/space_detail_controller.dart';

class SpaceDetailPage extends StatelessWidget {
  const SpaceDetailPage({
    super.key,
    required this.menu,
    required this.itemId,
    required this.title,
  });

  final String menu;
  final int itemId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpaceDetailController>(
      init: SpaceDetailController(menu: menu, itemId: itemId, title: title),
      autoRemove: true,
      builder: (SpaceDetailController controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3EAF9),
          appBar: AppBar(
            title: Text(controller.title),
            backgroundColor: const Color(0xFF2B2330),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: controller.loadDetail,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.openSourceUrl,
            icon: const Icon(Icons.open_in_browser),
            label: const Text('Buka Web'),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.isNotEmpty || controller.item.value == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    controller.errorMessage.isNotEmpty
                        ? controller.errorMessage.value
                        : 'Gagal memuat detail artikel.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            }

            final item = controller.item.value!;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 4,
                  color: const Color(0xFFF2EDF9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: _NetworkImage(imageUrl: item.imageUrl),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: const Color(0xFF2B2330),
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _InfoChip(label: item.newsSite, icon: Icons.public),
                                _InfoChip(label: item.publishedLabel, icon: Icons.calendar_today_outlined),
                                if (item.authors.isNotEmpty)
                                  _InfoChip(label: item.authorLabel, icon: Icons.person_outline),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item.summary,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xFF4D4560),
                                    height: 1.55,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            if (item.url.isNotEmpty)
                              Text(
                                item.url,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF7A6D8A),
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16, color: const Color(0xFF6C63FF)),
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: const Color(0xFF4D4560),
            fontWeight: FontWeight.w600,
          ),
      backgroundColor: Colors.white,
      side: BorderSide.none,
    );
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        color: const Color(0xFFE5DDF2),
        child: const Icon(Icons.image_not_supported_outlined, color: Color(0xFF7A6D8A), size: 36),
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return Container(
          color: const Color(0xFFE5DDF2),
          child: const Icon(Icons.image_not_supported_outlined, color: Color(0xFF7A6D8A), size: 36),
        );
      },
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          color: const Color(0xFFE5DDF2),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }
}