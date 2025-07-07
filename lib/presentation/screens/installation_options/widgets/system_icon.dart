import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalizedSystemIcon extends StatelessWidget {
  final String iconName;
  final String name;
  final double size;

  const LocalizedSystemIcon({
    super.key,
    required this.iconName,
    required this.name,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/$iconName.svg',
      width: size.w,
      height: size.w,
      placeholderBuilder: (BuildContext context) => Icon(
        _getFallbackIcon(iconName),
        size: size.w,
        color: const Color(0xFF8B0000),
        semanticLabel: name,
      ),
      semanticsLabel: name,
    );
  }

  IconData _getFallbackIcon(String iconName) {
    switch (iconName) {
      case 'fire_pump':
        return Icons.water_damage;
      case 'water_sprinkler':
        return Icons.water_drop;
      case 'fire_cabinet':
        return Icons.dashboard;
      case 'fire_extinguisher':
        return Icons.fire_extinguisher;
      case 'control_panel':
        return Icons.developer_board;
      case 'fire_detector':
        return Icons.sensors;
      case 'alarm_bell':
        return Icons.notification_important;
      case 'glass_breaker':
        return Icons.broken_image;
      case 'lighting':
        return Icons.lightbulb;
      case 'emergency_exit':
        return Icons.exit_to_app;
      default:
        return Icons.build;
    }
  }
}
