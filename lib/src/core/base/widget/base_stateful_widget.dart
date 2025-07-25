import 'package:flutter/material.dart';
import 'package:safety_zone/src/core/base/manager/loading/loading_manager.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  final Color materialColor;

  const BaseStatefulWidget({
    super.key,
    this.materialColor = Colors.white,
  });

  @override
  BaseState createState() {
    return baseCreateState();
  }

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with LoadingManager {

  @override
  Widget build(BuildContext context) {
    return baseWidget();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget baseWidget() {
    return Material(
        color: widget.materialColor,
        child: Stack(
          fit: StackFit.expand,
          children: [baseBuild(context), loadingManagerWidget()],
        ));
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  Widget baseBuild(BuildContext context);
}
