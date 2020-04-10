import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:realtimefirebase/src/models/producto_model.dart';

class HomePage extends StatefulWidget {

  HomePage( { this.app } );
  final FirebaseApp app;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DatabaseReference producto;
  final List<ProductoModel> productos = List();

  @override
  void initState() { 
    super.initState();
      producto = FirebaseDatabase.instance.reference().child('productos');
      producto.onChildChanged.listen(_onEntryChanged);  
  }

    @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime Database')
      ),
      body: _crearListado(),
    );
  }

  _onEntryChanged(Event event){
    var old = productos.singleWhere( ( entry ) => entry.ido == event.snapshot.key );
    setState(() {
      productos[productos.indexOf(old)]= ProductoModel.fromSnapshot(event.snapshot);
    });

  }

  Widget _crearListado(){
    return  Column(
      children: <Widget>[
        Flexible(
          child: FirebaseAnimatedList(
            query: producto,
            itemBuilder: (BuildContext context, 
                          DataSnapshot snapshot, 
                          Animation<double> animation, 
                          int index
            ) {          
              return ( _crearItem( snapshot ) );                
            },
          ),
        ),
      ],
    );  
  }

  Widget _crearItem( DataSnapshot snapshot ){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth  : 60,
                minHeight : 80,
                maxWidth  : 60,
                maxHeight : 80,
              ),
              child: Icon(Icons.shopping_cart),
            ),
            title: Text('${ snapshot.value['id']} \nNombre: ${snapshot.value['nombre']}'), 
            subtitle: Text('Precio: ${ snapshot.value['precio'] } \nCantidad: ${snapshot.value['cantidad']}'),         
          ),
        ],
      ),
    );
  }


}