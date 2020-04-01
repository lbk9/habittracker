import 'package:flutter/cupertino.dart';

class CustomPageBounceTransition extends PageRouteBuilder{
 final Widget widget;
 CustomPageBounceTransition({this.widget}) : super(
 transitionDuration: Duration(milliseconds: 500),
 transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> animationEnd, Widget child){
 animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
 return ScaleTransition(
 alignment: Alignment.bottomRight,
 scale: animation,
 child: child
 );
 },
 pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> animationEnd) {
   return widget;
 });
}