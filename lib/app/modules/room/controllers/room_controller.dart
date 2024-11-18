import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoomController extends GetxController {
  String rupiah(amount) {
    amount = double.tryParse(amount) ?? 0.0;

    final formatter = NumberFormat.currency(
      locale: 'id', // Locale Indonesia
      symbol: 'Rp', // Simbol Rupiah
      decimalDigits: 0, // Jumlah angka di belakang koma
    );
    return formatter.format(amount);
  }
}
