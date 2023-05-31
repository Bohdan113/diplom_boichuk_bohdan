// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/model/audio_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'audio_data.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class AudioData {
  @HiveField(0)
  List<AudioModel>? data;

  AudioData({
    this.data,
  });

  factory AudioData.fromJson(Map<String, dynamic> json) => _$AudioDataFromJson(json);

  Map<String, dynamic> toJson() => _$AudioDataToJson(this);

  @override
  String toString() {
    return 'AudioData{data: $data}';
  }
}
