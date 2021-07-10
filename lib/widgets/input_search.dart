import 'dart:math';

import 'package:flutter/material.dart';

class InputSearch extends StatefulWidget {
  InputSearch({
    Key? key,
    required this.searchController,
    required this.onChanged,
    required this.onSaved,
    required this.hint,
    this.backgroundColor,
    this.height,
    this.width,
  }) : super(key: key);

  final SearchAnimController searchController;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final String hint;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isShow = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    widget.searchController._addListener(() {
      _isShow = !_isShow;
      if (_isShow)
        _controller.forward();
      else
        _controller.reverse();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()..scale(_controller.value, 1.0),
          child: Opacity(
            opacity: max(0.0, (2 * _controller.value - 1)),
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          controller: widget.searchController.searchController,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.backgroundColor,
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.black38),
            contentPadding: EdgeInsets.only(
              left: 15.0,
              right: 70.0,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0 * 1 - _controller.value),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0 * 1 - _controller.value),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0 * 1 - _controller.value),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchAnimController {
  SearchAnimController() {
    searchController = TextEditingController();
  }
  late TextEditingController searchController;
  late Function() _search;

  _addListener(Function() search) {
    this._search = search;
  }

  void search() => _search();
}
