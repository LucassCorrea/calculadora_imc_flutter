import 'package:calculadora_imc_flutter/ui/pages/config_page.dart';
import 'package:calculadora_imc_flutter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Map dados = <int, Map<dynamic, dynamic>>{
      0: {
        "titulo": "Página Inicial",
        "icon": Icons.home,
        "route": const HomePage(),
      },
      1: {
        "titulo": "Configurações",
        "icon": Icons.settings,
        "route": const ConfigPage(),
      },
    };

    return SafeArea(
      child: Drawer(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: dados.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(dados[index]['titulo']),
            leading: Icon(
              dados[index]['icon'],
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => dados[index]['route'],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            height: 3,
            thickness: 0.5,
          ),
        ),
      ),
    );
  }
}
