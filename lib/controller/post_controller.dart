import 'dart:convert';

import 'package:forumapp/constan/constants.dart';
import 'package:forumapp/model/comment_model.dart';
import 'package:forumapp/model/post_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comment = Rx<List<CommentModel>>([]);

  final isLoading = false.obs;
  final box = GetStorage();
  @override
  void onInit() {
    getAllPost();
    super.onInit();
  }

  // final token = box.read('token');
  Future getAllPost() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(
          '${url}feeds',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in json.decode(response.body)['feeds']) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({required String content}) async {
    try {
      var data = {'content': content};
      var response = await http.post(Uri.parse('${url}feed/store'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          },
          body: data);
      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar('lỗi', 'bạn cần viết thứ gì đó');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComment(id) async {
    try {
      comment.value.clear();
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}feed/comments/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var content in json.decode(response.body)['comments']) {
          comment.value.add(CommentModel.fromJson(content));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future createComment(id, body) async {
    try {
      var data = {'body': body};
      var request = await http.post(Uri.parse('${url}feed/comment/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          },
          body: data);
      if (request.statusCode == 201) {
        isLoading.value = false;
        print(json.decode(request.body));
      } else {
        isLoading.value = false;

        print(json.decode(request.body));
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }

  Future LikeAndDislike(id) async {
    try {
      isLoading.value = true;
      var request = await http.post(
        Uri.parse('${url}feed/like/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );
      if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'liked') {
        isLoading.value = false;
        print(json.decode(request.body));
      } else if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'Unliked') {
        isLoading.value = false;
        print(json.decode(request.body));
      } else {
       isLoading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
