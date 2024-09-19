import 'dart:ffi';
import 'dart:math';

import 'package:azkar/core/utils/FontSize.dart';
import 'package:azkar/core/utils/Utils.dart';
import 'package:azkar/core/colors.dart';
import 'package:azkar/features/ziker/domain/entities/Hadith.dart';
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:azkar/features/ziker/presentation/pages/ZikerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import '../../../../../core/widgets/CustomPopUp.dart';
import '../../../../../core/widgets/intermittent_line/DashedLinePainter.dart';
import '../../../../../core/widgets/intermittent_line/LinePainter.dart';
import '../../bloc/azkar/setting/SettingBloc.dart';
import '../../pages/MainScreen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

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
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _fontSize = Utils().fontSize(FontSize.Median);
  bool _isViberat = true;
  bool _isSound = true;
  bool _isTransfer = true;

  AudioPlayer audioPlayer = AudioPlayer();
@override
  void initState() {
    super.initState();
    final path = AssetSource('audio/light_button.mp3');
     audioPlayer.setSource(path);
     audioPlayer.setReleaseMode(ReleaseMode.stop);
  }
  @override
  void dispose() {
    _pageController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

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
          _fontSize = Utils().fontSize(state.setting.fontSize);
          _isSound = state.setting.noisy;
          _isViberat = state.setting.vibrate;
          _isTransfer = state.setting.transfer;
          return _zikerTitleContent(fontSize: _fontSize + 2);
        }
        return _zikerTitleContent(fontSize: _fontSize);
      },
    );
  }

  Widget _zikerTitleContent({required double fontSize}) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
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
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _ViewPager() {
    return Expanded(
        child: GestureDetector(
            onTap: _increaseCounter,
            child: SizedBox(
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.azkar.arr.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: _PagerContent(context, index),
                  );
                },
                onPageChanged: (num) {
                  setState(() {
                    _currentPage = num;
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
          child: Container(
            height: 50,
            child: Center(
                child: Text(
                    '${_currentPage + 1} من ${widget.azkar.arr.length}'
                        .replaceArabicNumbers(),
                    style: TextStyle(
                        fontSize: _fontSize, color: AppColors.c4Actionbar))),
          ),
        ));
  }

  Widget _ProgressAndCounter() {
    return GestureDetector(
        onTap: _increaseCounter,
        child: SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: _CircularProgress(),
              ),
              Text(
                '${widget.azkar.arr[_currentPage].state}'
                    .replaceArabicNumbers(),
                style: TextStyle(fontSize: _fontSize * 2, color: Colors.black),
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
        child: Container(
          height: 50,
          child: Center(
            child: Text(
                widget.azkar.arr[_currentPage].no_repeat.replaceArabicString(),
                style: TextStyle(
                    fontSize: _fontSize, color: AppColors.c4Actionbar)),
          ),
        ),
      ),
    );
  }

  void _increaseCounter() async {
    if (!_IsHadithFinished()) {
      makeSound();
      setState(() {
        widget.azkar.arr[_currentPage].state += 1;
      });
    }
    if (_IsHadithFinished() && !_IsLastHadith()) {
      makeVibrate();
      goTONext();
    } else if (_IsHadithFinished() && _IsLastHadith()) {
      makeVibrate();
      _showCustomPopup();
    }
  }

  void _showCustomPopup() {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomPopupWidget(() {
            Navigator.of(dialogContext).pop();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainPage()),
              (route) => false,
            );
          });
        });
  }

  bool _IsHadithFinished() {
    return widget.azkar.arr[_currentPage].state ==
        widget.azkar.arr[_currentPage].no_repeat;
  }

  bool _IsLastHadith() {
    return widget.azkar.arr.length == (_currentPage + 1);
  }

  Widget _CircularProgress() {
    return CircularProgressIndicator(
      strokeWidth: 6,
      value: widget.azkar.arr[_currentPage].state /
          widget.azkar.arr[_currentPage].no_repeat,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.c4Actionbar),
    );
  }

  Widget _PagerContent(BuildContext context, int index) {
    final myObject = widget.azkar.arr[index];
    return Stack(
      children: [
        CustomPaint(
          size: ui.Size.infinite,
          painter: LinePainter(),
        ),
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    myObject.matn,
                    style: TextStyle(
                        fontSize: _fontSize,
                        color: AppColors.c4Actionbar,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (myObject.isnad.isNotEmpty)
                  CustomPaint(
                    size: ui.Size(double.infinity, 2),
                    painter: DashedLinePainter(
                      lineHeight: 2,
                      lineColor: Colors.grey,
                    ),
                  ),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    myObject.isnad,
                    style: TextStyle(
                      fontSize: _fontSize - 2,
                      color: AppColors.c4Actionbar,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void makeSound() async {
    if (!_isSound) return;
    audioPlayer.resume();

  }

  void makeVibrate() async {
    if (!_isViberat) return;

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
        pattern: [200, 100, 200],
        intensities: [255, 128, 255],
      );
    } else {
      print('Device does not support vibration or result was null');
    }
  }

  void goTONext() {
    if(!_isTransfer)return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
