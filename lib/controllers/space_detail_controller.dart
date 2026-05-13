import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/space_content_item.dart';
import '../services/spaceflight_news_service.dart';

class SpaceDetailController extends GetxController {
  SpaceDetailController({
    required this.menu,
    required this.itemId,
    required this.title,
  });

  final String menu;
  final int itemId;
  final String title;

  final SpaceflightNewsService _service = const SpaceflightNewsService();
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<SpaceContentItem> item = Rxn<SpaceContentItem>();

  @override
  void onInit() {
    super.onInit();
    loadDetail();
  }

  Future<void> loadDetail() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      item.value = await _service.fetchDetail(menu, itemId);
    } catch (error) {
      errorMessage.value = 'Gagal memuat detail artikel.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openSourceUrl() async {
    final SpaceContentItem? currentItem = item.value;
    if (currentItem == null || currentItem.url.isEmpty) {
      return;
    }

    final Uri uri = Uri.parse(currentItem.url);
    final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      Get.snackbar('Info', 'Tidak dapat membuka tautan berita.');
    }
  }
}