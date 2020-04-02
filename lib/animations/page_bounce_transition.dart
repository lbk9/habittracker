import 'package:flutter/cupertino.dart';

class CustomPageBounceTransition extends PageRouteBuilder{
 final Widget widget;
 final Alignment alignment;
 CustomPageBounceTransition({this.widget, this.alignment}) : super(
 transitionDuration: Duration(milliseconds: 500),
 transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> animationEnd, Widget child){
 animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
 return ScaleTransition(
 alignment: alignment,
 scale: animation,
 child: child
 );
 },
 pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> animationEnd) {
   return widget;
 });
}