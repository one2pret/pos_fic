// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_fic/core/constants/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pos_fic/presentation/home/bloc/checkout/checkout_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    // InkWell is a gesture detector that responds to taps
    return InkWell(
      onTap: onTap,
      // Set border radius for the InkWell widget
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Column(
        // Set the main axis size to minimum
        mainAxisSize: MainAxisSize.min,
        children: [
          // Check if the label is 'Orders'
          label == 'Orders'
              ? BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return SizedBox(
                        // Set the width and height of the SizedBox
                        width: 25.0,
                        height: 25.0,
                        child: SvgPicture.asset(
                          // Set the path of the SVG image
                          iconPath,
                          // Set the color of the SVG image based on the isActive variable
                          colorFilter: ColorFilter.mode(
                            isActive ? AppColors.black : AppColors.disabled,
                            BlendMode.srcIn,
                          ),
                        ),
                      );
                    }, success: (data, qty, total) {
                      if (data.isEmpty) {
                        return SizedBox(
                          // Set the width and height of the SizedBox
                          width: 25.0,
                          height: 25.0,
                          child: SvgPicture.asset(
                            // Set the path of the SVG image
                            iconPath,
                            // Set the color of the SVG image based on the isActive variable
                            colorFilter: ColorFilter.mode(
                              isActive ? AppColors.black : AppColors.disabled,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      } else {
                        return badges.Badge(
                          // Display a badge with the text '3'
                          badgeContent: Text(
                            '$qty',
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: SizedBox(
                            // Set the width and height of the SizedBox
                            width: 25.0,
                            height: 25.0,
                            child: SvgPicture.asset(
                              // Set the path of the SVG image
                              iconPath,
                              // Set the color of the SVG image based on the isActive variable
                              colorFilter: ColorFilter.mode(
                                isActive ? AppColors.black : AppColors.disabled,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        );
                      }
                    });
                  },
                )
              : SizedBox(
                  // Set the width and height of the SizedBox
                  width: 25.0,
                  height: 25.0,
                  child: SvgPicture.asset(
                    // Set the path of the SVG image
                    iconPath,
                    // Set the color of the SVG image based on the isActive variable
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.black : AppColors.disabled,
                      BlendMode.srcIn,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
