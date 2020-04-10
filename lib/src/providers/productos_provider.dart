import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:realtimefirebase/src/models/producto_model.dart';




class ProductosProvider {
  final String _url = 'https://topicos-a8945.firebaseio.com';

  Future<bool> crearProducto ( ProductoModel producto) async{

    final url = '$_url/productos.json';

    final resp = await http.post( url, body: productoModelToJson(producto) );

    final decodedData = json.decode( resp.body );

    // print( decodedData );

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async{
    final url = '$_url/productos.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if ( decodedData == null ) return [];

    if ( decodedData['error'] != null ) return [];

    decodedData.forEach( (id, prod) {
      // print(id);
      // print(prod);
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    } );

    // final decodedData = json.decode(resp.body);
    // print(decodedData);

    // print(productos);
    return productos;
  }
}