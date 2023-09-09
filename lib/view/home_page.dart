import 'package:flutter/material.dart';
import 'package:forumapp/controller/post_controller.dart';
import 'package:forumapp/widgets/post_data.dart';

import 'package:forumapp/widgets/post_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();
  final PostController _controller =Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 237, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 227, 242),
        toolbarHeight: 40,
        centerTitle: true,
        title: Text(
          'Forum',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: size * 0.08,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
          children: [
            PostView(
              hintText: 'What do you want to ask',
              controller: _postController,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async{
                    await _controller.createPost(content: _postController.text.trim());
                    _postController.clear();
                    _controller.getAllPost();
                  },
                  child:Obx(() {
                    return _controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                    'Post',
                    style: GoogleFonts.poppins(color: Colors.black),
                  );
                  },)),
            ),
            const Divider(
              color: Colors.black, // Màu của đường kẻ
              thickness: 1.0, // Độ dày của đường kẻ
              indent: 20, // Khoảng cách bắt đầu từ bên trái (tùy chọn)
              endIndent: 20, // Khoảng cách kết thúc bên phải (tùy chọn)
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: Text(
                "Recent Post",
                style: GoogleFonts.poppins(
                    fontSize: size * 0.06, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              return _controller.isLoading.value?
              CircularProgressIndicator():
              Expanded(
                child: Container(
                  
                  child:ListView.builder(
                    itemCount: _controller.posts.value.length,
                    itemBuilder: (context,index){
                      return PostData(
                        post: _controller.posts.value[index]
                        );
                    }
                    )
                ),
            );
            })
          ],
        ),
      
    );
  }
}
