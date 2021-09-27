import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants.dart';

class AddScreen extends StatelessWidget {
  final bool isEdit;
  final String pageTitle;
  final IconData pageIcon;

  AddScreen({
    Key key,
    this.isEdit = false,
    this.pageTitle = '',
    this.pageIcon = Icons.fiber_smart_record_outlined,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _IconsGridState.selectedIconIndex = icons.indexOf(pageIcon);
    controller.text = pageTitle;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 30,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 5.0),
                height: 220,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(300),
                    topRight: Radius.circular(300),
                  ),
                ),
              ),
              headerPart(),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          const IconsGrid(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: const Icon(
            Icons.done,
            size: 50,
          ),
          onPressed: () => controller.text.isNotEmpty
              ? Navigator.pop(
                  context, [controller.text, _IconsGridState.selectedIconIndex])
              : Navigator.pop(context)),
    );
  }

  Widget headerPart() {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(300),
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Text(
              isEdit ? 'Edit Page' : 'Create a new page',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0, color: black),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          padding: const EdgeInsets.only(left: 10.0, top: 4.0, right: 10.0),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextField(
            maxLines: 1,
            controller: controller,
            enableSuggestions: true,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Enter page name...',
              hintStyle: TextStyle(color: black),
              border: InputBorder.none,
            ),
            cursorColor: white,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class IconsGrid extends StatefulWidget {
  const IconsGrid({
    Key key,
  }) : super(key: key);

  @override
  _IconsGridState createState() => _IconsGridState();
}

class _IconsGridState extends State<IconsGrid> {
  static int selectedIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return IconButton(
            icon: CircleAvatar(
              radius: 50,
              child: Icon(
                icons[index],
                size: 30,
                color: black,
              ),
              backgroundColor: selectedIconIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor,
            ),
            onPressed: () {
              selectedIconIndex = index;
              setState(() {});
            },
          );
        },
      ),
    );
  }
}

final icons = [
  Icons.fiber_smart_record_outlined,
  Icons.monetization_on_outlined,
  Icons.airplanemode_on_sharp,
  Icons.card_travel,
  Icons.directions_car,
  Icons.home_outlined,
];
