import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import '../src/item.dart';
import 'package:rxdart/rxdart.dart';

enum CartEventType {
  add, remove
}

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc {
  final itemList = [
    Item('맥북', 2340000),
    Item('아이폰', 1280000),
    Item('아이패드', 1600000),
    Item('애플워치', 600000),
    Item('에어팟 프로', 300000),
  ];

  final _cardList = List<Item>(); // 빈 리스트 생성

  final _cardListSubject = BehaviorSubject<List<Item>>();

  Stream<List<Item>> get cardList => _cardListSubject.stream;

  void add(CartEvent event) {
    switch (event.type) {
      case CartEventType.add:
        _cardList.add(event.item);
        break;
      case CartEventType.remove:
        _cardList.remove(event.item);
        break;
    }
    _cartListSubject.add(_cardList);
  }
}