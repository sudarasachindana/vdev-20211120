import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/models/data.dart';
import 'package:vdev_riverpod_project/service/dataService.dart';

final apiService = Provider((ref) => DataService());

final categoryServiceProvider = FutureProvider<List<JokesApi>>((ref) {
  return ref.read(apiService).getListJokesApi();
});
