import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/cubit/app_cubit_state.dart';
import 'package:tourismapp/cubit/app_cubits.dart';
import 'package:tourismapp/pages/detail_page.dart';
import 'package:tourismapp/pages/navpages/main_page.dart';
import 'package:tourismapp/pages/welcome_page.dart';

class AppCubitsLogic extends StatefulWidget {
  const AppCubitsLogic({ Key? key }) : super(key: key);

  @override
  _AppCubitsLogicState createState() => _AppCubitsLogicState();
}

class _AppCubitsLogicState extends State<AppCubitsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state ){
          if(state is WelcomeState){
            return WelcomePage();
          }if(state is DetailState){
            return DetailPage();
          }if(state is MainState){
            return MainPage();
          }if(state is LoadingState){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Container();
          }
        },
        ),
    );
  }
}