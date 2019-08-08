import 'package:flutter/material.dart';
import './aperture/aperture.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Camera demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();



}


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  //声明变量
  TextEditingController typeController = TextEditingController();
  String showText = 'welcome to app';
  AnimationController animationController;

  @override
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'images/bay.png',
                width: 600,
                fit: BoxFit.fitWidth,
              ),
              //!aperture
              SizedBox(
                // !动画范围
                width: 600.0,
                height: 610.0,
                child: Aperture(
                  // animationController: animationController,
                  animationController: animationController,
                  
                  // child: Image.asset('images/dope.png'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    setState((){
                      // !启用动画效果
                      animationController.forward();
                    });
                  },
                  child: Text('拍照')
                ),
              )
            ],
          ),
        ));

        
  }
  switchCap(){}
}
