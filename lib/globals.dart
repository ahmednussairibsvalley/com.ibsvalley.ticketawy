import 'package:stack/stack.dart';
import 'package:ticketawy/controller.dart';

class Globals{
  static String userId = '';
  static Controller controller;
  static Stack<int> pagesStack = Stack();
  static int categoryId = 1;
  static int eventId = 0;
  static int reservationOption = 0;
  static String currentCategoryName = '';
  static String userPassword = 'esraa123';
  static bool skipped = false;
  static String keyWord = '';
  static String imageBaseUrl = 'https://beta.ticketawy.com/Media/Events_Logo';
}

class PagesIndices {
  static final int homePageIndex = 0;
  static final int profilePageIndex = 1;
  static final int faqPageIndex = 2;
  static final int ideasPageIndex = 3;
  static final int contactPageIndex = 4;
  static final int categoryPageIndex = 5;
  static final int eventPageIndex = 6;
  static final int selectSeatPageIndex = 7;
  static final int buyTicketsPageIndex = 8;
  static final int paymentPageIndex = 9;
  static final int categoriesPageIndex = 10;
  static final int myWishListPageIndex = 11;
  static final int searchPageIndex = 12;
}

class ReservationOptions{
  static final int byTickets = 0;
  static final int bySeats = 1;
}

