import 'package:http/http.dart' as http;
import 'package:vdev_riverpod_project/models/category.dart';

class DataService {
  List<Category> getJokes;
  List jokes = [];
  String url = "http://jsonplaceholder.typicode.com/posts";

  Future<List<Category>> getListCategoryApi() async {
    var resp = await http.get(Uri.parse(url));
    getJokes = categoryApiFromJson(resp.body);
    return getJokes;
  }
}
