import 'model/event.dart';

class Controller{

  List<Event> _events;

  Controller(){
    _events = List();
    _testData();
  }

  _testData(){
    _events.add(Event(1, 'Yanni Event', 'https://www.ticketsmarche.com/mm/Yanni-Slider.jpg'));
    _events.add(Event(2, 'Hiking Event', 'https://www.liffed.com/wp-content/uploads/2018/09/de853fb9_3088_4da5_b4a7_a54ef2181ecb_a21b0077-99fe-4b74-9a87-11bd3f3b82a3.jpg'));
    _events.add(Event(3, 'Biking Event', 'http://theindycog.com/wp-content/uploads/2019/05/FeaturedPost-2-Main-Benefits-of-Attending-Biking-Events-648x362.jpg'));
    _events.add(Event(4, 'Zunrich Event', 'https://cdn.zuerich.com/sites/default/files/styles/sharing/public/web_zuerich_home_topevents_1600x900.jpg'));
    _events.add(Event(5, 'Freshwater Wedding', 'http://freshwaterevents.com/sites/default/files/image3_3_1.jpg'));
  }

  List<Event> get events => _events;

  set events(List<Event> value) {
    _events = value;
  }


}