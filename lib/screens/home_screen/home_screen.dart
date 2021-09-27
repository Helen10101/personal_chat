import 'package:flutter/material.dart';
import 'package:personal_chat/widgets/add_screen_widgets/icons_grid.dart';

import '../../constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/home_screen_widgets/item_home_screen.dart';
import '../add_screen/add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _pin = false;
  bool _themeChange = false;
  CustomThemeKeys _themeKey;

  void _changeTheme(BuildContext buildContext, CustomThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  List<MyItem> pageEvent = <MyItem>[
    const MyItem(
      title: 'Fly',
      icon: Icons.airplanemode_on_sharp,
    ),
    const MyItem(
      title: 'Travel',
      icon: Icons.directions_car,
    ),
    const MyItem(
      title: 'Work',
      icon: Icons.work,
    ),
  ];

  // Method for more functionalities with page
  void _showPageFunctions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(
                Icons.push_pin_outlined,
                color: Colors.red,
              ),
              title: const Text('Pin/Unpin'),
              onTap: () {
                pageEvent.insert(0, pageEvent[index]);
                pageEvent.removeAt(index + 1);
                setState(() => _pin = true);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.red,
              ),
              title: const Text('Edit'),
              onTap: () async {
                var editPageInfo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddScreen(
                      isEdit: true,
                      pageTitle: pageEvent[index].title,
                      pageIcon: pageEvent[index].icon,
                    ),
                  ),
                );
                var iconIndex = editPageInfo[1] as int;
                var editPageName = editPageInfo[0].toString();
                setState(() {
                  pageEvent[index] = MyItem(
                    title: editPageName,
                    icon: icons[iconIndex],
                  );
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text('Delete'),
              onTap: () {
                pageEvent.removeAt(index);
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.red,
              ),
              title: const Text('Get info'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(pageEvent[index].icon),
                                padding: const EdgeInsets.all(10.0),
                              ),
                              Text(
                                pageEvent[index].title,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 1,
                            color: Colors.red,
                          ),
                          const Text(
                            'Created:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('Today at 12:07 AM'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok.'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              const BoxShadow(
                blurRadius: 1,
                color: shadowColor,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 1,
                  color: shadowColor,
                  offset: Offset(-2, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                _themeChange = !_themeChange;
                if (_themeChange == true) {
                  _themeKey = CustomThemeKeys.light;
                } else {
                  _themeKey = CustomThemeKeys.dark;
                }

                _changeTheme(context, _themeKey);
              },
              icon: _themeChange
                  ? const Icon(
                      Icons.wb_incandescent,
                      color: themeIconLight,
                      size: 30,
                    )
                  : const Icon(
                      Icons.wb_incandescent_outlined,
                      color: themeIconDark,
                      size: 30,
                    ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pageEvent.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () => _showPageFunctions(index),
            child: pageEvent[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List createScreenInfo = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
          var iconIndex = createScreenInfo[1] as int;
          var createScreenName = createScreenInfo[0].toString();

          pageEvent.add(MyItem(
            title: createScreenName,
            icon: icons[iconIndex],
          ));
          (context as Element).markNeedsBuild();
        },
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(
          Icons.add,
          color: black,
        ),
      ),
    );
  }
}
