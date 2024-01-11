// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_fic/core/components/spaces.dart';
import 'package:pos_fic/core/constants/colors.dart';

class NavItem extends StatelessWidget {
  final String iconPath; 
  final String label; 
  final bool isActive; 
  final VoidCallback onTap;

  const NavItem({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.black : AppColors.disabled,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SpaceHeight(4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.black : AppColors.disabled,
            ),
          ),
        ],
      ),
    );
  }
}
