import 'package:stack/stack.dart';
import 'package:ticketawy/controller.dart';

class Globals{
  static Controller controller;
  static Stack<int> pagesStack = Stack();
  static int reservationOption = 0;
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
}

class ReservationOptions{
  static final int byTickets = 0;
  static final int bySeats = 1;
}

