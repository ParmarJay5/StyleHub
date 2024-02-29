import 'package:StyleHub/Users/Carts/cartScreen.dart';
import 'package:StyleHub/homeScreens/HomePage.dart';
import 'package:StyleHub/homeScreens/Profile/profilePage.dart';
import 'package:flutter/material.dart';
import '../Users/Favorite/favoritePage.dart';

// class homeScreen extends StatefulWidget {
//   const homeScreen({super.key});
//
//   @override
//   State<homeScreen> createState() => _homeScreenState();
// }
//
// class _homeScreenState extends State<homeScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _pages = [
//     homePage(),
//     favoritePage(),
//     cartPage(),
//     profilePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.black,),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite, color: Colors.black,),
//             label: 'Favorite',
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_bag, color: Colors.black,),
//               label: "Cart"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: Colors.black,),
//             label: 'Profile',
//           ),
//         ],
//       ),
//
//     );
//   }
// }


//
// class homeScreen extends StatefulWidget {
//   int? currentIndex;
//
//   const homeScreen({Key? key, this.currentIndex = 0}) : super(key: key);
//
//   @override
//   State<homeScreen> createState() => _homeScreenState();
// }
//
// class _homeScreenState extends State<homeScreen> {
//
//
//
//   final List<Widget> _pages = [
//     homePage(),
//     favoritePage(),
//     CartScreen(),
//     ProfilePage(),
//   ];
//
//   Future<bool> _onWillPop() async {
//     if (widget.currentIndex == 0) {
//       return true; // Allow back button to pop the current screen
//     } else {
//       setState(() {
//         widget.currentIndex = 0; // Set selected index to 0 (Home) when pressing back button
//       });
//       return false; // Do not allow back button to pop the current screen
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             backgroundColor: Colors.lightBlue,
//             icon: Icon(Icons.home, color: Colors.white,),
//             // label: 'Home',
//             label: 'Home'
//             // l
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.lightBlue,
//             icon: Icon(Icons.favorite, color: Colors.white,),
//             label: 'Favorite',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.lightBlue,
//             icon: Icon(Icons.shopping_bag, color: Colors.white,),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.lightBlue,
//             icon: Icon(Icons.person, color: Colors.white,),
//             label: 'Profile',
//           ),
//         ],
//
//         selectedLabelStyle: TextStyle(color: Colors.black), // Change label color when selected
//       ),
//     );
//   }
// }


class BottomNavigationHome extends StatefulWidget {
  int? selectedIndex;

  BottomNavigationHome({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<BottomNavigationHome> createState() => _BottomNavigationHomeState();
}

class _BottomNavigationHomeState extends State<BottomNavigationHome> {
  List<Widget> widgetsPage = [
    const homePage(),
    FavoriteScreen(),
     CartPage(),
    const ProfilePage(),
  ];

  Future<bool> _onWillPop() async {
    if (widget.selectedIndex == 0) {
      return true; // Allow back button to pop the current screen
    } else {
      setState(() {
        widget.selectedIndex = 0; // Set selected index to 0 (Home) when pressing back button
      });
      return false; // Do not allow back button to pop the current screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Register the callback for back button press
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: widget.selectedIndex!.toInt(),
          onTap: (value) {
            setState(() {
              widget.selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.lightBlue,
              label: "Home",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.lightBlue,
              label: "Favorite",
              icon: Icon(
                Icons.favorite,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.lightBlue,
              label: "Cart",
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              label: "User",
              backgroundColor: Colors.lightBlue,
              icon: Icon(
                Icons.person_outline_outlined,
              ),
            ),
          ],
        ),
        body: widgetsPage.elementAt(widget.selectedIndex!.toInt()),
      ),
    );
  }
}
