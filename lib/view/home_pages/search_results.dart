import 'package:flutter/material.dart';
import '../../globals.dart';
import '../../util.dart' as util;

class SearchResults extends StatelessWidget {
  final Function(int) onEventClicked;

  SearchResults({@required this.onEventClicked});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: util.search(Globals.keyWord),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            return EventsPage(
              onCategoryPressed: onEventClicked,
              list: snapshot.data,
            );
          }
          return Container();
        }
        return Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}

class EventsPage extends StatelessWidget {
//  List list = Globals.controller.events;
  final List list;
  final Function(int) onCategoryPressed;

  EventsPage({@required this.list, @required this.onCategoryPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .9,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(list.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: (){
                onCategoryPressed(list[index]['event_Id']);
              },
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.network(
                            'https://beta.ticketawy.com/Media/Events_Logo/${list[index]['logo']}',
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                          Globals.skipped?Container():Positioned(
                              top: 3.0,
                              right: 3,
                              child: WishListButton(eventId: list[index]['event_Id'])),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('${list[index]['event_name']}'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffff6600),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${list[index]['price']} EGP / Ticket',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class WishListButton extends StatefulWidget {

  final int eventId;

  WishListButton({@required this.eventId,});

  @override
  _WishListButtonState createState() => _WishListButtonState();
}

class _WishListButtonState extends State<WishListButton> {

  bool _addedToWishList = false;

  initValues() async{
    List response = await util.getWishList();
    if(response != null){
      for(int i = 0; i < response.length ; i++){
        if(response[i]['id'] == widget.eventId){
          _addedToWishList = true;
          break;
        }
      }
    }

  }

  @override
  void initState() {
    super.initState();
    if(!Globals.skipped)
      initValues();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FutureBuilder(
        future: util.getWishList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              List list = snapshot.data;
              if(list != null){
                for (int i = 0; i < list.length ; i++){
                  if(list[i]['id'] == widget.eventId){
                    _addedToWishList = true;
                    break;
                  }
                }
              }
            }
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange,
              ),
              child: IconButton(padding: EdgeInsets.only(top: 2),alignment: Alignment.center,
                  icon: Icon(
                    _addedToWishList?Icons.favorite:Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async{
                    Map response = await util.addToRemoveFromWishList(widget.eventId);
                    if(response['result']){
                      setState(() {
                        _addedToWishList = _addedToWishList?false:true;
                      });
                    }
                  }),
            );
          }
          return Container(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}