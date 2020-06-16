import 'dart:convert';

import 'package:dart_designer_pattern_adapter/endereco_model.dart';
import 'package:dart_designer_pattern_adapter/xml2_json_adapter.dart';
import 'package:dart_designer_pattern_adapter/xml2_json_transform.dart';
import 'package:dio/dio.dart';
import 'package:xml2json/xml2json.dart';

Future<void> run() async {
  var enderecoModel = await Dio().get('https://viacep.com.br/ws/01001000/json/').then(
        (res) => EnderecoModel.fromJson(res.data),
      );
  print(enderecoModel);
  print('############################################');
  print('XML');

  var res = await Dio().get('https://viacep.com.br/ws/01001000/xml/')
  .then((res) => Xml2JsonAdapter.adapter(res.data))
  .then((res) => EnderecoModel.fromJson(res['xmlcep']));
  print(res);
  print(res.runtimeType);

  print('############################################');
  print('XML Por Transform');

  var dio = Dio();
  dio.transformer = Xml2JsonTransform();

  var res2 = await 
    dio
    .get('https://viacep.com.br/ws/01001000/xml/')
    .then((res) => EnderecoModel.fromJson(res.data['xmlcep']));
  
  print(res2);
  print(res2.runtimeType);

}
