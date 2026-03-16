// lib/screens/confirmation/widgets/ticket_cutout_clipper.dart

import 'package:flutter/material.dart';

class TicketCutoutClipper extends CustomClipper<Path> {
  final double holeRadius;
  final double holeYOffset;

  TicketCutoutClipper({
    required this.holeRadius,
    required this.holeYOffset,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top left
    path.lineTo(0, holeYOffset - holeRadius);

    // Left semi-circle cutout
    path.arcToPoint(
      Offset(0, holeYOffset + holeRadius),
      clockwise: true,
      radius: Radius.circular(holeRadius),
    );

    // Line to bottom left
    path.lineTo(0, size.height);

    // Line to bottom right
    path.lineTo(size.width, size.height);

    // Line to right semi-circle start
    path.lineTo(size.width, holeYOffset + holeRadius);

    // Right semi-circle cutout
    path.arcToPoint(
      Offset(size.width, holeYOffset - holeRadius),
      clockwise: true,
      radius: Radius.circular(holeRadius),
    );

    // Line to top right
    path.lineTo(size.width, 0);

    // Close back to top left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class TicketDashedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const TicketDashedDivider({
    super.key,
    this.height = 1,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 8.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
