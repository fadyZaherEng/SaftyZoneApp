import 'package:flutter/material.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';

class MaintainanceScreen extends BaseStatefulWidget {
  const MaintainanceScreen({super.key});

  @override
  BaseState<MaintainanceScreen> baseCreateState() => _MaintainanceScreenState();
}

class _MaintainanceScreenState extends BaseState<MaintainanceScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintainance'),
      ),
    );
  }
}
