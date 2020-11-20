import 'package:flutter/material.dart';

class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
    print("${this.runtimeType} #initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("${this.runtimeType} #didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("${this.runtimeType} #didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("${this.runtimeType} #dispose");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("${this.runtimeType} #deactivate");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("${this.runtimeType} #reassemble");
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
