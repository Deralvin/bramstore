import 'package:bramstore/constants/theme.dart';
import 'package:bramstore/ui/views/cart_view.dart';
import 'package:bramstore/ui/views/history_view.dart';

import 'package:bramstore/ui/views/home_view.dart';
import 'package:bramstore/ui/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomNavView extends StatefulWidget {
  @override
  _BotttomNavViewState createState() => _BotttomNavViewState();
}

class _BotttomNavViewState extends State<BottomNavView> {
  int selectedIndex = 0;
  final WidgetOptions = [HomeView(), HistoryView(), CartView(), ProfileView()];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.light, statusBarColor: seconddark));

    return Scaffold(
      backgroundColor: kprimarycolor,
      body: WidgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          selectedItemColor: kprimarycolor,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: selectedIndex, //New
          onTap: onItemTapped,
          unselectedItemColor: Color.fromARGB(255, 77, 75, 75),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
