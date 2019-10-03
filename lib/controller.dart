import 'model/category.dart';
import 'model/event.dart';


// I have edited changes in blablabla
class Controller{

  List<Event> _events;
  List<Category> _categories;
  List<Event> _homeEvents;
  List<Event> _hotEvents;

  Controller(){
    _events = List();
    _categories = List();
    _homeEvents = List();
    _hotEvents = List();
    _testData();
  }

  populateCategories(List categoriesList){
    for(int i = 0; i < categoriesList.length; i++){
      Category category = Category.fromJson(categoriesList[i]);

      switch(category.title){
        case 'MUSIC':
          category.imageUrl = 'assets/category_music.jpg';
          break;
        case 'THEATERS':
          category.imageUrl = 'assets/category_theatre.jpg';
          break;
        case 'COURSES':
          category.imageUrl = 'assets/category_courses.jpg';
          break;
        case 'SPORTING':
          category.imageUrl = 'assets/category_sporting.jpg';
          break;
        case 'ENTERTAINMENT':
          category.imageUrl = 'assets/category_entertainment.jpg';
          break;
        case 'OTHERS':
          category.imageUrl = 'assets/category_others.jpg';
          break;
      }

      _categories.add(category);
    }
  }

  populateHomeEvents(List homeEventsList){
    for(int i = 0; i < homeEventsList.length; i++){
      _homeEvents.add(Event.fromJson(homeEventsList[i]));
    }
  }

  populateHotEvents(List hotEvents){
    for(int i = 0 ; i < hotEvents.length; i++){
      _hotEvents.add(Event.fromJson(hotEvents[i]));
    }
  }

  _testData(){
    _events.add(Event(1, 'Yanni Event', 'https://s3.amazonaws.com/busites_www/yanni/home_bg_2_1525800103.jpg', 30, 1));
    _events.add(Event(2, 'Hiking Event', 'https://www.liffed.com/wp-content/uploads/2018/09/de853fb9_3088_4da5_b4a7_a54ef2181ecb_a21b0077-99fe-4b74-9a87-11bd3f3b82a3.jpg', 50, 0));
    _events.add(Event(3, 'Biking Event', 'http://theindycog.com/wp-content/uploads/2019/05/FeaturedPost-2-Main-Benefits-of-Attending-Biking-Events-648x362.jpg', 60, 1));
    _events.add(Event(4, 'Zunrich Event', 'https://cdn.zuerich.com/sites/default/files/styles/sharing/public/web_zuerich_home_topevents_1600x900.jpg', 10, 0));
    _events.add(Event(5, 'Freshwater Wedding', 'http://freshwaterevents.com/sites/default/files/image3_3_1.jpg', 20, 1));

//    _categories.add(Category(1, 'Sports Events', 'https://365thingsinhouston.com/wp-content/uploads/2019/05/top-games-and-sports-this-week-houston-june-2019-696x407.jpg'));
//    _categories.add(Category(2, 'Adventure Events', 'https://www.thehatt.co.uk/files/corporate/lost-team-building9.jpg'));
//    _categories.add(Category(3, 'School Events', 'https://www.chelseapiers.com/cpny/cache/file/571BA408-2219-2737-80B1619C8E58C2B9_source.jpg'));
//    _categories.add(Category(4, 'Ceremony', 'https://pleasantdale.com/wp-content/uploads/2016/12/1169-20161015-KatieJeremy-RE.jpg'));
//    _categories.add(Category(5, 'Business Events', 'http://www.mediacominc.com/wp/wp-content/uploads/2014/03/business-events.jpg'));
  }

  List<Event> get events => _events;

  set events(List<Event> value) {
    _events = value;
  }

  List<Category> get categories => _categories;

  set categories(List<Category> value) {
    _categories = value;
  }

  List<Event> get hotEvents => _hotEvents;

  set hotEvents(List<Event> value) {
    _hotEvents = value;
  }

  List<Event> get homeEvents => _homeEvents;

  set homeEvents(List<Event> value) {
    _homeEvents = value;
  }


}