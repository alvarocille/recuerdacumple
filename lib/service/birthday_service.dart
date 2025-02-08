import '../dao/birthday_crud.dart';
import '../models/birthday.dart';

class BirthdayService {
  final BirthdayCRUD _birthdayCRUD = BirthdayCRUD();

  Future<List<Birthday>> getUserBirthdays(int userId) async {
    return await _birthdayCRUD.getUserEvents(userId);
  }

  Future<List<Birthday>> getFriendsBirthdays(int userId) async {
    return await _birthdayCRUD.getFriendsBirthdays(userId);
  }
}