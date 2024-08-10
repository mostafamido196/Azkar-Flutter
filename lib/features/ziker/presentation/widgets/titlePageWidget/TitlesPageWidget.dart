import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:flutter/material.dart';


class TitleListWidget extends StatelessWidget {
  final List<Ziker> posts;
  const TitleListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].arr.toString(),
            style: TextStyle(fontSize: 16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            // Navigator.push(
            //   context,
              // MaterialPageRoute(
                // builder: (_) => PostDetailPage(post: posts[index]),
              // ),
            // );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}
