import 'package:http/http.dart' as http;
import 'package:vdev_riverpod_project/models/data.dart';

class DataService {
  List<JokesApi> getJokes;
  List jokes = [];
  String url = "http://jsonplaceholder.typicode.com/posts";

  Future<List<JokesApi>> getListJokesApi() async {
    print("category service");
    // print(value);
    var resp = await http.get(Uri.parse(url));
    getJokes = jokesApiFromJson(resp.body);
    return getJokes;
  }
}
