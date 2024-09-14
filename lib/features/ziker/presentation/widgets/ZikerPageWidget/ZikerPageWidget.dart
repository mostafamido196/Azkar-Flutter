import 'package:azkar/core/FontSize.dart';
import 'package:azkar/core/Utils.dart';
import 'package:azkar/core/colors.dart';
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:azkar/features/ziker/presentation/pages/ZikerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/azkar/setting/SettingBloc.dart';

class ZikerPageWidget extends StatefulWidget {
  final Ziker azkar;

  ZikerPageWidget({
    Key? key,
    required this.azkar,
  }) : super(key: key);

  @override
  _ZikerPageWidgetState createState() => _ZikerPageWidgetState();
}

class _ZikerPageWidgetState extends State<ZikerPageWidget> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.c2Read,
      child: Column(
        children: <Widget>[
          _ZikerTitle(),
          _ViewPager(),
          _BottomRow(),
        ],
      ),
    );
  }

  Widget _ZikerTitle() {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is LoadedSettingState) {
          return _zikerTitleContent(
              fontSize: Utils().fontSize(state.setting.fontSize) + 2);
        }
        return _zikerTitleContent(
            fontSize: Utils().fontSize(FontSize.Median) + 2);
      },
    );
  }

  Widget _zikerTitleContent({required double fontSize}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.c3,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          widget.azkar.name,
          style: TextStyle(
            fontSize: fontSize,
            color: AppColors.c4Actionbar,
            fontWeight: FontWeight.bold, // Make text bold
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _ViewPager() {
    print('view pager mos');
    return Expanded(
        child:GestureDetector(
        onTap: _increaseCounter, // Click event
    child:  Container(
      width: double.infinity,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.azkar.arr.length,
        itemBuilder: (context, index) {
          final myObject = widget.azkar.arr[index];
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  myObject.matn,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  myObject.isnad,
                  style: TextStyle(fontSize: 18),
                ),
              ],
     ),
          );
        },
        onPageChanged: (num) {
          setState(() {
            currentPage = num;
            print('mos num $num');
          });
        },
      ),
    )));
  }

  Widget _BottomRow() {
    return Row(
      children: [
        _MaxCounter(),
        _ProgressAndCounter(),
        _CurrentPerTotal(),
      ],
    );
  }

  Widget _CurrentPerTotal() {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // You can adjust the padding as needed
          child: Container(
            height: 50,
            child: Center(
                child: Text(
                    '${currentPage + 1} من ${widget.azkar.arr.length}'
                        .replaceArabicNumbers(),
                    style:
                        TextStyle(fontSize: 18, color: AppColors.c4Actionbar))),
          ),
        ));
  }

  Widget _ProgressAndCounter() {
    return GestureDetector(
        onTap: _increaseCounter, // Click event
        child: SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  width: double.infinity, // Full width
                  height: double.infinity, // Full height
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    value: widget.azkar.arr[currentPage].state /
                        widget.azkar.arr[currentPage].no_repeat,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.c4Actionbar),
                  )),
              // Centered text
              Text(
                '${widget.azkar.arr[currentPage].state}'.replaceArabicNumbers(),
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black), // Adjust color for visibility
              ),
            ],
          ),
        ));
  }

  Widget _MaxCounter() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // You can adjust the padding as needed
        child: Container(
          height: 50,
          child: Center(
            child: Text(
                '${widget.azkar.arr[currentPage].no_repeat.replaceArabicString()}',
                style: TextStyle(fontSize: 18, color: AppColors.c4Actionbar)),
          ),
        ),
      ),
    );
  }

  void _increaseCounter() {
    setState(() {
      widget.azkar.arr[currentPage].state += 1;
    });
  }
}
