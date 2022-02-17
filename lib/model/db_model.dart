import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'db_model.g.dart';


@HiveType(typeId: 0)
class DBModel extends HiveObject{
 @HiveField(0) 
dynamic path;
DBModel({ required this.path});
 
}
