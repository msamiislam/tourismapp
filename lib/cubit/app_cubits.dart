import 'package:bloc/bloc.dart';
import 'package:tourismapp/cubit/app_cubit_state.dart';
import 'package:tourismapp/model/data_model.dart';
import 'package:tourismapp/pages/detail_page.dart';
import 'package:tourismapp/services/data_services.dart';

class AppCubits extends Cubit<CubitStates>{
  AppCubits({required this.data}) : super(InitialState()){
    emit(WelcomeState());
  }
  final DataServices data;
  late final places;

  Future<void> getData() async {
    try{
      emit(LoadingState());
      places=await data.getInfo();
      emit(LoadedState(places));
    }catch(e){

    }
  }

  detailpage(DataModel data){
    emit(DetailState(data));
  }
  
}