import 'package:fitness_app/features/smart_coach/data/models/chat_message_model_adapter.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

@module
abstract class HiveModule {
  @preResolve
  @lazySingleton
  Future<Box<SessionModel>> get sessionBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(ChatMessageModelAdapter());
    Hive.registerAdapter(SessionModelAdapter());
    return await Hive.openBox<SessionModel>('sessions');
  }
}
