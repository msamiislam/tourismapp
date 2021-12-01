import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tourismapp/model/data_model.dart';

class DataServices{
  String baseUrl = "http://adventuree.com/api";
  Future<List<DataModel>> getInfo() async {
    var apiurl = '/getplaces';
    http.Response res = await http.get(Uri.parse(baseUrl+apiurl));

    try{
      if(res.statusCode==200){
        List<dynamic> list = json.decode(res.body);
        print(list);
        return list.map((e) => DataModel.fromjson(e)).toList();
      }else{
        return <DataModel>[];
      }

    }catch(e){
      print(e);
      return <DataModel>[];
    }


  }
}