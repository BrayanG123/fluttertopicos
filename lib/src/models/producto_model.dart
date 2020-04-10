
// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String id;
    String ido;
    String nombre;
    double precio;
    double cantidad;
    bool disponible;
    String descripcion;

    ProductoModel({
        this.id,
        this.ido        = '',
        this.nombre     = '',
        this.precio     = 0.0,
        this.cantidad   = 0.0,
        this.disponible = true,
        this.descripcion = '',
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id         : json["id"],
        ido        : json["ido"],
        nombre     : json["nombre"],
        precio     : json["precio"].toDouble(),
        cantidad   : json["cantidad"].toDouble(),
        disponible : json["disponible"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id"         : id,
        "ido"        : ido,
        "nombre"     : nombre,
        "precio"     : precio,
        "cantidad"   : cantidad,
        "disponible" : disponible,
        "descripcion": descripcion,
    };

    ProductoModel.fromSnapshot(DataSnapshot snapshot):
      id          = snapshot.value['id'],
      ido         = snapshot.key,
      nombre      = snapshot.value['nombre'],
      precio      = snapshot.value['precio'].toDouble(),
      cantidad    = snapshot.value['cantidad'].toDouble(),
      disponible  = snapshot.value['disponible'],
      descripcion = snapshot.value['descripcion'];

}
