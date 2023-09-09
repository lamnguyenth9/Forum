import 'package:flutter/material.dart';
import 'package:forumapp/controller/post_controller.dart';
import 'package:forumapp/model/post_model.dart';
import 'package:forumapp/widgets/input_widget.dart';
import 'package:forumapp/widgets/post_data.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});
  final PostModel post;
  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
       final PostController _postController =Get.put(PostController());

 @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComment(widget.post.id);
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      var size=MediaQuery.of(context).size.width;
     final TextEditingController _commentController = TextEditingController();
     //final PostController _postController =Get.put(PostController());
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 221, 237, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 227, 242),
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(
          'Post',
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: size * 0.08,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PostData(post:widget.post),
            SizedBox(height: 10,),
            
                InputWidget(
                  hintText: 'Write comment ...', 
                  controller: _commentController, 
                  obscureText: false),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: ElevatedButton(
                      onPressed: ()async{
                        await _postController.createComment(
                          widget.post.id,
                           _commentController.text.trim()
                          );
                          _commentController.clear();
                          _postController.getComment(widget.post.id);
                      }, 
                      child:Text("Đăng")),
                  ),
            
            SizedBox(height: 15,),
            Center(child: Text("Recent comment"),),
            Expanded(
              child: Container(
                
                
                child: Obx((){
                  return _postController.isLoading.value
                  ? Center(child: CircularProgressIndicator(),)
                  :ListView.builder(
                  shrinkWrap: true,
                  itemCount: _postController.comment.value.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                         decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                      color: Colors.black
                                      )
                                    ),
                        child: ListTile(
                            title: Text(_postController.comment.value[index].user.name, style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            subtitle:                         Text(_postController.comment.value[index].body),
                           ),
                      ),
                    );
                  }
                  );
                })
              )
              )
            
          ],
        ),
      ),
    );
  }
}
