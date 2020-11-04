import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/src/item.dart';
import 'package:flutter_cart_bloc/src/my_cart.dart';


class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: [
          IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCart()));
              },
          )
        ],
      ),
      body: BlocBuilder<CartBloc, List<Item>>(
        bloc: _cartBloc,
          builder: (BuildContext context, List state) {
            return Center(
              child: ListView(
                children: _itemList.map((item) =>
                    _buildItem(item, state, _cartBloc)).toList(),
              ),
            );
          }
    ),

    );
  }
  Widget _buildItem(Item todo, List state, CartBloc bloc) {
    final isChecked = state.contains(todo);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        subtitle: Text('${todo.price}'),
        trailing: IconButton(
          icon: isChecked ? Icon(Icons.check, color: Colors.red,) : Icon(Icons.check),
          onPressed: () {
            setState(() {
              if(isChecked) {
                bloc.add(CartEvent(CartEventType.remove, todo));
              } else {
                bloc.add(CartEvent(CartEventType.add, todo));
              }
            });
          },),
        title: Text(
          todo.title,
          style: TextStyle(fontSize: 27.0),
        ),
      ),
    );
  }

}
