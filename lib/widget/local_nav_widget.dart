import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';

///球区入口
class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;
  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        // todo
      },
      child: Column(
        children: [
          Image.network(
            model.icon!,
            width: 32,
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              model.title!,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
