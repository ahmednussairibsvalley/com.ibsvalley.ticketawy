import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_container/responsive_container.dart';

import 'home_pages/search_results.dart';
import 'home_pages/ticket_page.dart';
import 'home_pages/mywishlist.dart';
import 'home_pages/select_seat.dart';
import 'home_pages/categories_page.dart';
import 'home_pages/contact_page.dart';
import 'home_pages/event_details.dart';
import 'home_pages/faq_page.dart';
import 'home_pages/ideas_page.dart';
import 'home_pages/category.dart';
import 'home_pages/home_page.dart';
import 'home_pages/profile_page.dart';

import 'custom_widgets/CustomShowDialog.dart';

import 'login.dart';
import 'register.dart';
import '../globals.dart';

/// Class for home pages
class Home extends StatefulWidget {

  /// the current page index
  final int currentPageIndex;

  Home({this.currentPageIndex = -1,});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  /// Scaffold key for the drawer
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// the search text field controller
  TextEditingController _searchController = TextEditingController();

  /// the page index
  int index = PagesIndices.homePageIndex;

  /// the previous page index
  int _previousPageIndex = -1;

  @override
  void initState() {
    super.initState();
    index = widget.currentPageIndex >= 0?widget.currentPageIndex:PagesIndices.homePageIndex;
  }

  @override
  Widget build(BuildContext context) {

    /// Map for the drawer
    final Map<String, Function> leftDrawerMap = Globals.skipped?
    {
      'Home' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        while(Globals.pagesStack.isNotEmpty){
          Globals.pagesStack.pop();
        }
        setState(() {
          index = PagesIndices.homePageIndex;
        });
        Navigator.of(context).pop();
      },
//      'FAQ' : (){
//        setState(() {
//          index = PagesIndices.faqPageIndex;
//        });
//        Navigator.of(context).pop();
//      },
      'Ideas' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        setState(() {
          index = PagesIndices.ideasPageIndex;
        });
        Navigator.of(context).pop();
      },
      'Contact Us' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        setState(() {
          index = PagesIndices.contactPageIndex;
        });
        Navigator.of(context).pop();
      },
      'Sign In' : (){
        Globals.currentCategoryPageIndex = 0;
        int _index = index;
        Navigator.of(context).pop();
        if(_index == PagesIndices.eventPageIndex)
          Navigator.of(context).pushReplacement(MaterialPageRoute
            (builder: (context) => Login(openedByDrawer: true, openedFromHome: false,
            openedFromEventDescription: true,)));
        else
          Navigator.of(context).pushReplacement(MaterialPageRoute
            (builder: (context) => Login(openedByDrawer: true,)));
      },
      'Sign Up' : (){
        Globals.currentCategoryPageIndex = 0;
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Register(openedFromHome: true,)));
      },
    }
    :{
      'Home' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        while(Globals.pagesStack.isNotEmpty){
          Globals.pagesStack.pop();
        }
        setState(() {
          index = PagesIndices.homePageIndex;
        });
        Navigator.of(context).pop();
      },
      'My Profile' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        setState(() {
          index = PagesIndices.profilePageIndex;
        });
        Navigator.of(context).pop();
      },
      'My Wishlist' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        setState(() {
          index = PagesIndices.myWishListPageIndex;
        });
        Navigator.of(context).pop();
      },
//      'FAQ' : (){
//        setState(() {
//          index = PagesIndices.faqPageIndex;
//        });
//        Navigator.of(context).pop();
//      },
      'Ideas' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        setState(() {
          index = PagesIndices.ideasPageIndex;
        });
        Navigator.of(context).pop();
      },
      'Contact Us' : (){
        Globals.currentCategoryPageIndex = 0;
        _searchController.value = _searchController.value.copyWith(text: '');
        setState(() {
          index = PagesIndices.contactPageIndex;
        });
        Navigator.of(context).pop();
      },
      'Sign Out' : () async{
        Globals.currentCategoryPageIndex = 0;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('userId');
        prefs.remove('fullName');
        prefs.remove('phoneNumber');
        prefs.remove('password');
        //Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/login');
      },
    };

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Image.asset('assets/drawer_header.png', fit: BoxFit.cover,),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: List.generate(leftDrawerMap.keys.toList().length, (index){
                    return ListTile(
                      title: _drawerItem(leftDrawerMap.keys.toList()[index]),
                      onTap: leftDrawerMap['${leftDrawerMap.keys.toList()[index]}'],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[

            // The background.
            Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/login.jpg')
                  )
              ),
            ),

            // The header.
            ResponsiveContainer(
              heightPercent: 20, widthPercent: 100,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){
                  if(index != PagesIndices.homePageIndex){
                    setState(() {
                      index = PagesIndices.homePageIndex;
                    });
                  }
                },
                child: Image.asset('assets/header.png',
                  height: Platform.isIOS?95:110,
                ),
              ),
            ),

            // The top left icon.
            Positioned(
              left: 0.0, top: 0.0,
              child: Padding(
                padding: EdgeInsets.all(_width > 350? 13.0:12.0),
                child: GestureDetector(
                  onTap: (){
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Image.asset('assets/top_left_list_icon.png',
                    height: 40,
                    width: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // The body
            Positioned(
              bottom: 0.0, right: 0.0, left: 0.0,
              child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  if(index != PagesIndices.searchPageIndex)
                    _searchController.value = _searchController.value.copyWith(text: '');
                },
                child: Column(
                  children: <Widget>[

                    Stack(
                      children: <Widget>[
                        DrawerDivider(color: Colors.white, height: 2.3, width: 15,),
                      ],
                    ),

                    Stack(
                      children: <Widget>[

                        // The white background.
                        SizedBox(
                          width: _width,
                          height: _height * 0.75,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),

                        // Here is the events data.
                        Positioned(
                          left: 0.0, right: 0.0, bottom: 0.0, top: _width> 360?
                        index == PagesIndices.homePageIndex?2:35:
                        index == PagesIndices.homePageIndex?1:30,
                          child: index == PagesIndices.homePageIndex? HomePage(
                            onPress: (id, categoryName){
                              Globals.categoryId = id;
                              Globals.currentCategoryName = categoryName;
                              setState(() {
                                index = PagesIndices.categoryPageIndex;
                              });
                            },
                            onEventPressed: (id){
                              Globals.eventId = id;
                              setState(() {
                                index = PagesIndices.eventPageIndex;
                              });
                            },
                            onHotOfferPressed: (id){
                              Globals.eventId = id;
                              setState(() {
                                index = PagesIndices.eventPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.profilePageIndex? ProfilePage(
                            onHistoryItemPressed: (value){
                              Globals.orderId = value;
                              setState(() {
                                index = PagesIndices.ticketPageIndex;
                              });
                            },
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onPreviousPagePressed: (){
                              Globals.pagesStack.pop();
                              setState(() {
                                index = Globals.pagesStack.pop();
                              });
                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.ideasPageIndex? IdeasPage(
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onPreviousPagePressed: (){
                              Globals.pagesStack.pop();
                              setState(() {
                                index = Globals.pagesStack.pop();
                              });
                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.faqPageIndex? FaqPage(
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onPreviousPagePressed: (){
                              Globals.pagesStack.pop();
                              setState(() {
                                index = Globals.pagesStack.pop();
                              });
                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.contactPageIndex? ContactPage(
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },

                            onPreviousPagePressed: (){
                              Globals.pagesStack.pop();
                              if(Globals.pagesStack.isNotEmpty){
                                setState(() {
                                  index = Globals.pagesStack.pop();
                                });
                              } else {
                                setState(() {
                                  index = PagesIndices.homePageIndex;
                                });
                              }

                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.categoryPageIndex? CategoryPage(
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onBack: (){
                              Globals.pagesStack.pop();
                              if(Globals.pagesStack.isNotEmpty){
                                setState(() {
                                  index = Globals.pagesStack.pop();
                                });
                              } else {
                                setState(() {
                                  index = PagesIndices.homePageIndex;
                                });
                              }

                            },
                            onCategoryPressed: (id){
                              Globals.eventId = id;
                              setState(() {
                                index = PagesIndices.eventPageIndex;
                              });
                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.eventPageIndex? EventDetails(
                            onOrderCompleted: (value){
                              Globals.orderId = value;
                              Globals.ticketsPageOpenedAfterOrder = true;
                              setState(() {
                                index = PagesIndices.ticketPageIndex;
                              });
                            },
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onPreviousPagePressed: (){
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onEventBooked: (){
                              if(Globals.reservationOption == ReservationOptions.bySeats){
                                setState(() {
                                  index = PagesIndices.selectSeatPageIndex;
                                });
                              } else {
                                setState(() {
                                  index = PagesIndices.buyTicketsPageIndex;
                                });
                              }
                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.selectSeatPageIndex? SelectSeat(
                            onPreviousPagePressed: (){
                              Globals.pagesStack.pop();
                              if(Globals.pagesStack.isNotEmpty){
                                setState(() {
                                  index = Globals.pagesStack.pop();
                                });
                              } else {
                                setState(() {
                                  index = PagesIndices.homePageIndex;
                                });
                              }

                            },
                            onSeatsBooked: (){
                              setState(() {
                                index = PagesIndices.paymentPageIndex;
                              });
                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.myWishListPageIndex? MyWishListPage(
                            onWillPop: (){
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onCategoryPressed: (id){
                              Globals.eventId = id;
                              setState(() {
                                index = PagesIndices.eventPageIndex;
                              });
                            },
                            onBack: (){
                              Globals.pagesStack.pop();
                              if(Globals.pagesStack.isNotEmpty){
                                setState(() {
                                  index = Globals.pagesStack.pop();
                                });
                              } else {
                                setState(() {
                                  index = PagesIndices.homePageIndex;
                                });
                              }

                            },
                            onAllCategoriesPressed: (){
                              setState(() {
                                index = PagesIndices.categoriesPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.categoriesPageIndex? AllCategoriesPage(
                            onWillPop: (){
                              Globals.currentCategoryPageIndex = 0;
                              while(Globals.pagesStack.isNotEmpty){
                                Globals.pagesStack.pop();
                              }
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                            onPreviousPagePressed: (){
                              Globals.currentCategoryPageIndex = 0;
                              Globals.pagesStack.pop();
                              if(Globals.pagesStack.isNotEmpty){
                                setState(() {
                                  index = Globals.pagesStack.pop();
                                });
                              } else {
                                setState(() {
                                  index = PagesIndices.homePageIndex;
                                });
                              }

                            },
                            onCategoryPressed: (id, categoryName){
                              Globals.categoryId = id;
                              Globals.currentCategoryName = categoryName;
                              setState(() {
                                index = PagesIndices.categoryPageIndex;
                              });
                            },
                            onAllEventsPressed: (){
                              setState(() {
                                index = PagesIndices.homePageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.searchPageIndex?SearchResults(
                            onEventClicked: (id){
                              FocusScope.of(context).requestFocus(FocusNode());
                              _searchController.value = _searchController.value.copyWith(text: '');
                              Globals.eventId = id;
                              setState(() {
                                index = PagesIndices.eventPageIndex;
                              });
                            },
                          ):
                          index == PagesIndices.ticketPageIndex?TicketsPage(
                            onWillPop: (){
                              setState(() {
                                if(Globals.ticketsPageOpenedAfterOrder) {
                                  index = PagesIndices.homePageIndex;
                                  Globals.ticketsPageOpenedAfterOrder = false;
                                }
                                else
                                  index = PagesIndices.profilePageIndex;
                              });
                            },
                          ):
                          Container(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Search field
            index != PagesIndices.homePageIndex?
            Positioned(
              right: 50.0, left: 50.0, bottom: _height * .71,
              child: Material(
                color: Colors.transparent,
                elevation: 10.0,
                shadowColor: Colors.black,
                child: TextFormField(
                  controller: _searchController,
                  onTap: (){
                    if(index != PagesIndices.searchPageIndex)
                      _previousPageIndex = index;
                  },
                  onChanged: (value) async{
                    var connectivityResult = await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi){
                      return;
                    }
                    if(value.length > 2){
                      Globals.keyWord = value;

                      if(Globals.keyWord.isEmpty){
                        setState(() {
                          index = _previousPageIndex;
                        });
                      } else {
                        setState(() {
                          index = PagesIndices.searchPageIndex;
                        });
                      }
                    }else {
                      setState(() {
                        index = _previousPageIndex;
                      });
                    }


                  },
                  decoration: InputDecoration(
                      hintText: 'Search for an event ...',
                      contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: _width > 360?20:10, top: _width > 360?20:10),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                            onTap: () async{
                              FocusScope.of(context).requestFocus(FocusNode());
                              var connectivityResult = await Connectivity().checkConnectivity();
                              if (connectivityResult != ConnectivityResult.mobile &&
                                  connectivityResult != ConnectivityResult.wifi){
                                _showNoConnectivityDialog();
                                return;
                              }
                              Globals.keyWord = _searchController.text;

                              if(Globals.keyWord.isEmpty){
                                setState(() {
                                  index = _previousPageIndex;
                                });
                                Fluttertoast.showToast(
                                    msg: 'Search field is empty',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.black38,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else {
                                setState(() {
                                  index = PagesIndices.searchPageIndex;
                                });
                              }

                            },
                            child: Icon(Icons.search, size: 30,)
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1, style: BorderStyle.none
                          )
                      )
                  ),
                ),
              ),
            ):
            Container(),

          ],
        ),
      ),
    );
  }

  /// The drawer item
  Widget _drawerItem(String title){
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('$title',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Verdana',
                color: Color(0xff656565)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const DrawerDivider(color: Colors.grey),
        ),
      ],
    );
  }

  /// Shows no internet connectivity dialog
  _showNoConnectivityDialog(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return CustomAlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 260.0,
              height: 230.0,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: Text('Please check your internet connection and try again.',
                          style: TextStyle(
                            color: Color(0xfffe6700),
                            fontSize: 20,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                      )
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text('Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfffe6700),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

/// Class for drawer divider
class DrawerDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double width;

  const DrawerDivider({this.height = 1, this.color = Colors.black, this.width = 10});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
