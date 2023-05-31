// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'audio_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class AudioModel {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final int? maxTime;
  @HiveField(2)
  final String? path;
  @HiveField(3)
  final DateTime? createAudio;
  @HiveField(4)
  final DateTime? pin;
  bool isPlay;

  AudioModel({
    this.title,
    this.maxTime,
    this.createAudio,
    this.pin,
    this.isPlay = false,
    this.path,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) => _$AudioModelFromJson(json);

  Map<String, dynamic> toJson() => _$AudioModelToJson(this);

  @override
  String toString() {
    return 'AudioModel{title: $title, maxTime: $maxTime, path: $path, createAudio: $createAudio, pin: $pin}';
  }
}
