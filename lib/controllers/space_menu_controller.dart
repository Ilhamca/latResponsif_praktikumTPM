import 'package:get/get.dart';

import '../models/space_content_item.dart';
import '../services/spaceflight_news_service.dart';

class SpaceMenuController extends GetxController {
  SpaceMenuController({
    required this.menu,
    required this.title,
    required this.subtitle,
  });

  final String menu;
  final String title;
  final String subtitle;

  final SpaceflightNewsService _service = const SpaceflightNewsService();
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<SpaceContentItem> items = <SpaceContentItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  Future<void> loadItems() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      items.assignAll(await _service.fetchItems(menu));
    } catch (error) {
      errorMessage.value = 'Data belum bisa dimuat';
    } finally {
      isLoading.value = false;
    }
  }
}