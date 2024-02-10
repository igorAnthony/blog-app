import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/comments/comment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentView extends ConsumerStatefulWidget {
  final int? postId;

  const CommentView({super.key, this.postId});

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends  ConsumerState<CommentView> {
  final List<dynamic> _commentsList = [];
  //bool _loading = true; 
  int? userId = 0;
  int _editCommentId = 0;

  late final TextEditingController _commentController;

  // Future<void> _getComments() async{
  //   userId = ref.read(userStoreProvider).value!.id;
    
  //   ApiResponse response = await getComment(widget.postId ?? 0);

  //   if(response.error == null){
  //     setState(() { 
  //       _commentsList = response.data as List<dynamic>;
  //       _loading = _loading ? !_loading : _loading;
  //     });
  //   }
  //   else if(response.error == unauthorized){
  //     logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}')
  //     ));
  //   }
  // }

  // void _createComment() async {
  //   ApiResponse response = await createComment(widget.postId ?? 0, _commentController.text);

  //   if(response.error == null){
  //     setState(() {
  //       _commentController.clear();
  //       _loading = _loading ? !_loading : _loading;
  //     });
  //   }
  //   else if(response.error == unauthorized){
  //     logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
  //   }else{
  //     setState(() {
  //       _loading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}')
  //     ));
  //   }
  // }

  // void _editComment() async {
  //   ApiResponse response = await editComment(_editCommentId, _commentController.text);

  //   if(response.error == null){
  //     _editCommentId = 0;
  //     _commentController.clear();
  //     _getComments();
  //   }
  //   else if(response.error == unauthorized){
  //     logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}')
  //     ));
  //   }
  // }

  // void _deleteComment(int commentId) async {
  //   ApiResponse response = await deleteComment(commentId);

  //   if(response.error == null){
  //     _getComments();
  //   }
  //   else if(response.error == unauthorized){
  //     logout().then((value) => {navigatorPushNamedAndRemoveUntil(context, loginRoute)});
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}')
  //     ));
  //   }
  // }

  @override
  void initState() {
    _commentController = TextEditingController();
    //_getComments();    
    super.initState();
  }
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments')
      ),
      body: Column(
        children: [
          Expanded( 
            child: RefreshIndicator(
              onRefresh: () {
                //return _getComments();
                return Future.value();
              },
              child: ListView.builder(
                itemCount: _commentsList.length,
                itemBuilder: (context, index) {
                  Comment comment = _commentsList[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border:  Border(
                        bottom: BorderSide(color:Colors.black26, width: 0.5)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30, 
                                  decoration: BoxDecoration(
                                    image: comment.user!.avatar != null ? DecorationImage(
                                      image: NetworkImage('${comment.user!.avatar}'),
                                      fit: BoxFit.cover
                                    ) : null,
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blueGrey
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  '${comment.user!.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:16
                                  ),
                                )
                              ],
                            ),
                            comment.user!.id == userId ?
                            PopupMenuButton( 
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.more_vert, color: Colors.black),
                              ),
                              itemBuilder:(context) => [
                                const PopupMenuItem(
                                  value:'edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem(
                                  value:'delete', 
                                  child: Text('Delete'),
                                ),
                              ],  
                              onSelected:(value) {
                                if(value == 'edit'){
                                  setState(() {
                                    _editCommentId = comment.id ?? 0;
                                    _commentController.text = comment.comment ?? '';
                                  });
                                }else{
                                  //_deleteComment(comment.id ?? 0);
                                }
                              },        
                            ) : const SizedBox(height: 10,),                            
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 6),
                          child: Text('${comment.comment}'),
                        )
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black26, width:0.5)
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: kInputDecoration('Comment'),
                    controller: _commentController,
                  )
                ),
                IconButton(
                  onPressed: (){
                    if(_commentController.text.isNotEmpty){
                      setState(() {
                        //_loading = true;
                      });
                      if(_editCommentId > 0){
                       // _editComment();
                      }else{
                        //_createComment();
                      }   
                    }
                  }, 
                  icon: const Icon(Icons.send)
                )
              ],
            ),
          )
        ],
      )
    );
  }
}