import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/models/category.dart';
import 'package:vdev_riverpod_project/service/dataService.dart';

final apiService = Provider((ref) => DataService());

final categoryServiceProvider = FutureProvider<List<Category>>((ref) {
  return ref.read(apiService).getListCategoryApi();
});
