import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../views/screens/tikets_hitory/line_metro.dart';
import 'core/metro_seclection_model.dart';

part 'line_metro_state.dart';

class LineMetroCubit extends Cubit<LineMetroState> {
  LineMetroCubit() : super(LineMetroStateInitial());


  String  selectedLine  = "Choose The  Line";
  List<String> lines = [
    "First Line",
    "Second Line",
    "Third Line",
  ];
    List<MetroStationModel>metroSelection=[];
  void updateMetroSelection(){
    if(selectedLine=="First Line"){
      metroSelection=metroStationsOne;
    }else if(selectedLine=="Second Line"){
      metroSelection=metroStationsTwo;
    }else if(selectedLine=="Third Line"){
      metroSelection=metroStationsThree;
    }else{
      metroStationsThree=[];
    }
  }
  void setSelectionLine({required String line}){
    selectedLine=line;
    updateMetroSelection();
    emit(LineMetroUpdateSelectionState());
  }


}
