import 'package:admin_chat/View/tela_cliente.dart';
import 'package:admin_chat/View/tela_listar_inst.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class TelaBase extends StatefulWidget {
  @override
  Tela_BaseState createState() => Tela_BaseState();
}

class Tela_BaseState extends State<TelaBase> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            leading: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.04,
                    backgroundImage: NetworkImage(
                      'https://cdni.rt.com/actualidad/public_images/2016.07/article/579ae067c36188ce6e8b4576.jpg',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Maria',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            selectedLabelTextStyle: TextStyle(
              color: Colors.blueAccent,
            ),
            unselectedLabelTextStyle: TextStyle(
              color: Colors.black45,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.black45,
            ),
            selectedIconTheme: IconThemeData(
              color: Colors.blueAccent,
            ),
            selectedIndex: _selectedIndex,
            extended: MediaQuery.of(context).size.width >= 1000 ? true : false,
            onDestinationSelected: (int index) {
              setState(() {
                if (index == 2) {
                  Navigator.pushReplacementNamed(context, '/');
                }
                _selectedIndex = index != 2 ? index : _selectedIndex;
                print(index);
              });
            },
            labelType: MediaQuery.of(context).size.width > 1000
                ? null
                : NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(IcoFontIcons.doctor),
                selectedIcon: Icon(IcoFontIcons.doctor),
                label: Text('Usuário'),
              ),
              NavigationRailDestination(
                icon: Icon(IcoFontIcons.institution),
                selectedIcon: Icon(IcoFontIcons.institution),
                label: Text('Instituições'),
              ),
              NavigationRailDestination(
                icon: Icon(IcoFontIcons.signOut),
                selectedIcon: Icon(IcoFontIcons.signOut),
                label: Text('Sair'),
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            width: 0,
          ),
          VerticalDivider(
            thickness: 1,
            width: 80,
          ),

          // This is the main content.
          Expanded(
            child: pages(),
          ),

          VerticalDivider(
            thickness: 1,
            width: 80,
          ),
        ],
      ),
    );
  }

  Widget pages() {
    switch (_selectedIndex) {
      case 0:
        return TelaCliente();
      case 1:
        return TelaListarInstituicao();
        break;
      default:
    }
  }
}
