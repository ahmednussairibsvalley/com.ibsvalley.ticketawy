import 'package:stack/stack.dart';

/// This class contains the global classes and fields
/// which the whole project depends on.


/// The global fields.
class Globals{

  /// the user ID.
  static String userId = '';

  /// Stack of home pages indices
  static Stack<int> pagesStack = Stack();

  /// Category ID
  static int categoryId = 1;

  /// Event ID
  static int eventId = 0;

  /// Event reservation option (0 for ticket, 1 for seats)
  static int reservationOption = 0;

  /// Current category name
  static String currentCategoryName = '';

  /// User password
  static String userPassword = '';

  /// login skipped?
  static bool skipped = false;

  /// search keyword
  static String keyWord = '';

  /// the event image base URL.
  static String imageBaseUrl = 'https://beta.ticketawy.com/Media/Events_Logo';

  /// Order ID
  static String orderId = '';

  /// List of added orders.
  static List orderTickets = [];

  ///Is the tickets page opened after the order is processed
  static bool ticketsPageOpenedAfterOrder = false;

  /// Current categories page index
  static int currentCategoryPageIndex = 0;
}


/// The home pages indices.
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
  static final int ticketPageIndex = 13;
}

/// The event reservation options (tickets or seats).
class ReservationOptions{
  static final int byTickets = 0;
  static final int bySeats = 1;
}

