import 'package:flutter/material.dart';
import 'package:forumapp/controller/post_controller.dart';
import 'package:forumapp/model/post_model.dart';
import 'package:forumapp/widgets/post_detail.dart';
import 'package:get/get.dart';

class PostData extends StatefulWidget {
  const PostData({super.key, required this.post, });
  final PostModel post;
  

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
   @override
  Widget build(BuildContext context) {
     
    PostController _postController=Get.put(PostController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color.fromARGB(255, 15, 219, 234))
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.user.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                  Text(widget.post.user.email,
                       style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(height: 15,),
                    
                    Text(widget.post.content),
                    Row(
                      children: [
                        IconButton(onPressed: ()async{
                          await _postController.LikeAndDislike(widget.post.id);
                         _postController.getAllPost();
                           
                        }, icon: Icon(
                          Icons.thumb_up,
                          color: widget.post.liked?Colors.blue:Colors.black,
                          )),
                        IconButton(onPressed: (){Get.to(()=>PostDetails(
                          post: widget.post,
                        ));}, icon: Icon(Icons.message))
                      ],
                    )
                  ],
                ),
              ),
    );
  }
}