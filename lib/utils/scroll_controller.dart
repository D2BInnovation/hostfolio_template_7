import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppScrollController extends ChangeNotifier {
  final ScrollController _controller = ScrollController();
  
  ScrollController get controller => _controller;
  
  double get offset => _controller.hasClients ? _controller.offset : 0.0;
  
  void scrollTo(double offset, {Duration duration = const Duration(milliseconds: 800)}) {
    if (_controller.hasClients) {
      _controller.animateTo(
        offset,
        duration: duration,
        curve: Curves.easeInOutCubic,
      );
    }
  }
  
  void scrollToTop() {
    scrollTo(0);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
