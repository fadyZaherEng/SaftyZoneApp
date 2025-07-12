import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';

class GreetingSection extends StatefulWidget {
  final S s;
  final bool isLoading;
  final String fullName;

  const GreetingSection({
    Key? key,
    required this.s,
    required this.isLoading,
    required this.fullName,
  }) : super(key: key);

  @override
  State<GreetingSection> createState() => _GreetingSectionState();
}

class _GreetingSectionState extends State<GreetingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 3.1416 / 2, // ربع لفة (90 درجة)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startFlipLoop();
  }

  Future<void> _startFlipLoop() async {
    while (mounted) {
      await _controller.forward(); // يلف ربع لفة
      await _controller.reverse(); // يرجع مكانه
      await Future.delayed(const Duration(seconds: 1)); // توقف لحظة
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.s.welcome}, ${widget.fullName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.s.dailyTasksSubtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child: widget.isLoading
                  ? Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              )
                  : SvgPicture.asset(
                ImagePaths.hello,
                width: 48.w,
                height: 48.h,
              ),
            );
          },
        ),
      ],
    );
  }
}
