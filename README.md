# CameraAperture_mobile

Camera Aperture animation for mobile by Flutter

Flutter的移动端相机快门动画封装

#### Created by Alfonso Cejudo, Saturday, July 13th 2019.  [link](https://github.com/alfonsocejudo/aperture_demo)

这是Alfonso Cejudo封装的快门动画，Alfonso的设计是圆盘快门动画。我在他的基础和原理上进行二次封装，可以进行移动端全屏视觉的动画效果。

这个[链接](https://medium.com/jet-set-digital/camera-aperture-animation-flutter-ft-custompainter-animatedbuilder-clipoval-3ab296e7de58)可以看到更多他的动画原理，值得观摩。

![](./demo.gif)

---

## 核心原理：

 - aperture.dart > 定义ApertureBladePainter类的属性和方法
 - aperture_blades.dart > 计算动画的逻辑和封装
 - aperture_blade_painter.dart > 引用ApertureBladePainter类和外观布局

## 初始化设置动画参数

 - main.dart > 
 
```
void initState() {
  super.initState();

  animationController = AnimationController(
    // !初始动画周期为13秒
      vsync: this, duration: Duration(milliseconds: 1300));

  animationController.addStatusListener((status) {
    // ! 快门(动画区)合并时重启动画
    if (status == AnimationStatus.completed) {
      Future.delayed(const Duration(milliseconds: 400), () {
        animationController.reverse();
        // animationController.stop();
      });
    // ! 快门(动画区)最大化张开时停止动画
    } else if (status == AnimationStatus.dismissed) {
      Future.delayed(const Duration(milliseconds: 400), () {
        // animationController.forward();
        animationController.stop();
      });
    }
  });
  // !Starts running this animation in reverse (towards the beginning).
  // !将动画至于开始状态（未执行）
  // !如果设置成forward将自动开启动画效果
  animationController.reverse();
  // animationController.dispose();
}

@override
// !启用停止动画效果
void dispose() {
  animationController.dispose();

  super.dispose();
}
```


## 拍照按钮启用动画

```
setState((){
  // !启用动画效果
  animationController.forward();
});
```
