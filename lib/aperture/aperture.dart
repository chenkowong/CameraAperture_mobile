/*
 * Created by Alfonso Cejudo, Saturday, July 13th 2019.
 */

import 'package:flutter/material.dart';
import 'aperture_blades.dart';

class Aperture extends StatelessWidget {
  /// The optional child is visible when the Aperture is not fully closed, and
  /// is wrapped inside a clipped container so that its contents only appear
  /// within the Aperture bounds.
  final Widget child;

  /// Set the starting position of the Aperture to be opened (default) or
  /// closed.
  final bool startOpened;

  final AnimationController animationController;
  final Animation curvedAnimation;

  Aperture(
      {this.child,
      this.animationController,
      this.curvedAnimation,
      this.startOpened = true});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // !中心动画区的大小
        final bladeWidth = constraints.maxWidth * 1.17;

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (child != null)
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  alignment: Alignment.center,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: child,
                ),
              ),
            // !圆形布局
            // ClipOval(
            //   clipBehavior: Clip.antiAlias,
            //   child: ApertureBlades(
            //     bladeWidth: bladeWidth,
            //     animationController: animationController,
            //     curvedAnimation: curvedAnimation,
            //     startOpened: startOpened,
            //   ),
            // ),
            // !长方形布局
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: ApertureBlades(
                bladeWidth: bladeWidth,
                animationController: animationController,
                curvedAnimation: curvedAnimation,
                startOpened: startOpened,
              ),
            )
          ],
        );
      },
    );
  }
}
