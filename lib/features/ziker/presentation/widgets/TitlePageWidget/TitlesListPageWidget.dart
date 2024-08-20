import 'package:azkar/core/FontSize.dart';
import 'package:azkar/core/Utils.dart';
import 'package:azkar/core/colors.dart';
import 'package:azkar/features/ziker/domain/entities/Setting.dart';
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:flutter/material.dart';

class AzkarListWidget extends StatelessWidget {
  final List<Ziker> azkar;

  const AzkarListWidget({
    Key? key,
    required this.azkar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.c2Read,
        child: ListView.builder(
          itemCount: azkar.length,
          itemBuilder: (context, index) {
            return _itemList(index);
          },
        ));
  }

  Widget _itemList(int index) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(20), // Corner radius
          color: AppColors.c6Item,
          child: ListTile(
            title: Text(
              azkar[index].name,
              style: TextStyle(
                  fontSize: Utils().fontSize(azkar.first.font),
                  // fontWeight: FontWeight.bold
                  ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              // Handle onTap
            },
          ),
        ));

    /*ListTile(
      title: Text(
        azkar[index].name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );*/
  }


}
