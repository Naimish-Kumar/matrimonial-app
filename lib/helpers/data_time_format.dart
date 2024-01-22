
import 'package:intl/intl.dart';

String yearMonthDay(DateTime dateTime){
  return DateFormat('y-MM-dd').format(dateTime);
}