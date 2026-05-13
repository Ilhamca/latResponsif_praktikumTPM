import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/space_menu_controller.dart';
import '../models/space_content_item.dart';
import 'space_detail_page.dart';

class SpaceMenuPage extends StatelessWidget {
  const SpaceMenuPage({
    super.key,
    required this.menu,
    required this.title,
    required this.subtitle,
  });

  final String menu;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpaceMenuController>(
      init: SpaceMenuController(menu: menu, title: title, subtitle: subtitle),
      autoRemove: true,
      builder: (SpaceMenuController controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3EAF9),
          appBar: AppBar(
            title: Text(controller.title),
            centerTitle: false,
            backgroundColor: const Color(0xFF2B2330),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: controller.loadItems,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.isNotEmpty) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _SectionHeader(title: controller.title, subtitle: controller.subtitle),
                  const SizedBox(height: 16),
                  _ErrorState(onRetry: controller.loadItems),
                ],
              );
            }

            return RefreshIndicator(
              onRefresh: controller.loadItems,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.items.length + 1,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 14),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _SectionHeader(title: controller.title, subtitle: controller.subtitle);
                  }

                  final item = controller.items[index - 1];
                  return _SpaceContentCard(
                    item: item,
                    onTap: () {
                      Get.to(
                        () => SpaceDetailPage(
                          menu: controller.menu,
                          itemId: item.id,
                          title: controller.title,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF2B2330),
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6B5F7B),
              ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_outlined, size: 48, color: Color(0xFF6B5F7B)),
          const SizedBox(height: 12),
          Text(
            'Data belum bisa dimuat',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Periksa koneksi internet lalu coba lagi.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B5F7B),
                ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: onRetry, child: const Text('Coba lagi')),
        ],
      ),
    );
  }
}

class _SpaceContentCard extends StatelessWidget {
  const _SpaceContentCard({required this.item, required this.onTap});

  final SpaceContentItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2EDF9),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x15000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _NetworkImage(imageUrl: item.imageUrl),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color(0xFF2B2330),
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.authorLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF7A6D8A),
                            ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.publishedLabel,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF7A6D8A),
                                  ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward, size: 18, color: Color(0xFF7A6D8A)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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