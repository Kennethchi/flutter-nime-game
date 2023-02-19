// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:nimle/modules/authentication/authentication_bloc.dart';
import 'package:nimle/modules/authentication/authentication_bloc_provider.dart';


class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  AuthenticationBloc? _bloc;

  String userid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bloc = AuthenticationBloc();

    /*
    if (FirebaseAuth.instance.currentUser != null){
      setState(() {
        userid = FirebaseAuth.instance.currentUser!.uid;
      });
    }
    else{
      setState(() {
        userid = "Not Available";
      });
    }

     */
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationBlocProvider(
        bloc: _bloc,
        child: Scaffold(
          body: Center(
            child: Text(userid),
          ),
        )
    );
  }
}
