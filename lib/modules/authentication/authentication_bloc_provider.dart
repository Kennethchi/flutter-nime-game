import 'package:flutter/widgets.dart';
import 'package:nimle/modules/authentication/authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget{

  AuthenticationBloc? bloc;
  Widget child;
  Key? key;
  
  AuthenticationBlocProvider({
    required this.bloc,
    this.key,
    required this.child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  
  
}