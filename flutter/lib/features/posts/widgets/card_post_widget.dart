import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/posts/model/post.dart';
import 'package:flutter_blog_app/features/posts/presentation/post_detail_view.dart';

class CardPostWidget extends StatelessWidget {
  final Post post;
  final Function(int postId) onLikeDislike;
  
  const CardPostWidget({
    super.key,
    required this.post,
    required this.onLikeDislike,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostDetailView(post),
          ),
        );
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: post.user?.avatar != null
                    ? DecorationImage(
                        image: NetworkImage('${post.user!.avatar}'),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 3),
                  Text(
                    (post.user?.name)?.toUpperCase() ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 5),
                  Text('${post.title}', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 18)),
                  Row(
                    children: [
                      kButton(
                        post.likesCount ?? 0,
                        Icons.favorite_border_outlined,
                        Colors.black38,
                        onTap: () {
                          onLikeDislike(post.id ?? 0);
                        },
                      ),
                      const SizedBox(width: 30),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.black54,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '1hr ago',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.bookmark_border_outlined,
                          color: Colors.black54,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// post.user!.id == userId
//     ? PopupMenuButton(
//         child: const Padding(
//           padding:
//               EdgeInsets.only(right: 10),
//           child: Icon(Icons.more_vert,
//               color: Colors.black),
//         ),
//         itemBuilder: (context) => [
//           const PopupMenuItem(
//             value: 'edit',
//             child: Text('Edit'),
//           ),
//           const PopupMenuItem(
//             value: 'delete',
//             child: Text('Delete'),
//           ),
//         ],
//         onSelected: (value) {
//           if (value == 'edit') {
//             Navigator.of(context).push(
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         CreatePostView(
//                           title:
//                               'Edit Post',
//                           post: post,
//                         )));
//           } else {
//             _deletePost(post.id ?? 0);
//           }
//         },
//       )
//     : const SizedBox()