import 'package:quran_api/services/quran.dart';

class QuranModel {
  //late String surah;
  // late int numberOfAyah;
  // late int numberAyahInSurah;

  Future<String?> getRandomAyah() async {
    try {
      Map<String, dynamic> surahInfo = await QuranApi().generateRandomAyah();
      return surahInfo['data']['text']['arab'];
    } on Exception catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
