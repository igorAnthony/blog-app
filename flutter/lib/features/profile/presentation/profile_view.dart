import 'package:flutter/material.dart';
import 'package:flutter_blog_app/constant/decoration.dart';
import 'package:flutter_blog_app/features/auth/store/user_store.dart';
import 'package:flutter_blog_app/features/posts/widgets/post_list_widget.dart';
import 'package:flutter_blog_app/features/profile/widgets/profile_header_widget.dart';
import 'package:flutter_blog_app/features/profile/widgets/profile_info_widget.dart';
import 'package:flutter_blog_app/features/profile/widgets/profile_posts_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStoreProvider);
    return Scaffold(
      body: user.asData?.isLoading ?? true ? const Center(child: CircularProgressIndicator(),)
    : Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderWidget(),
            const SizedBox(height: 30,),
            ProfileInfoWidget(),   
            const SizedBox(height: 30,),     
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Posts', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 18),),
                kTextButton('More', (){}, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black, fontSize: 14),),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: PostListWidget(userId: user.asData!.value.id))

          ],
        ),
      ),
    );
  }
}