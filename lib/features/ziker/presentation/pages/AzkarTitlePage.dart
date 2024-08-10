import 'package:azkar/features/ziker/presentation/bloc/AzkarTitlesBloc.dart';
import 'package:azkar/features/ziker/presentation/widgets/titlePageWidget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';

class AzkarTitlePage extends StatefulWidget {
  const AzkarTitlePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AzkarTitlePage> {
  bool _isDrawerOpen = false;


  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBodyAndNavSideBar(),
      // endDrawer: const DrawerWidget(),
    );
  }

  AppBar _buildAppbar() => AppBar(
          title: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _toggleDrawer,
            ),
            const SizedBox(width: 8.0), // Spacing between icon and title
            const Text('صحيح الأذكار'),
          ],
        ),
      ));

  Widget _buildBodyAndNavSideBar() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
            children: [
          _buildBody(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: DrawerWidget(isOpen: _isDrawerOpen)
          )
        ]));
  }

  Widget _buildBody() {
    return GestureDetector(
        onTap: () {
      if (_isDrawerOpen) {
        setState(() {
          _isDrawerOpen = false;
        });
      }
    Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<AzkarTitlesBloc, AzkarTitlesState>(
        builder: (context, state) {
          if (state is LoadingAzkarTitlesState) {
            // return LoadingWidget();
          } else if (state is LoadedAzkarTitlesState) {
            // return RefreshIndicator(
            //     onRefresh: () => _onRefresh(context),
            //     child: Container()//PostListWidget(posts: state.posts)
            // );
          } else if (state is ErrorAzkarTitlesState) {
            // return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  });}
}
