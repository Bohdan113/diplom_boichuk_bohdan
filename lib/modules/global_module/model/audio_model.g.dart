// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioModelAdapter extends TypeAdapter<AudioModel> {
  @override
  final int typeId = 0;

  @override
  AudioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioModel(
      title: fields[0] as String?,
      maxTime: fields[1] as int?,
      createAudio: fields[3] as DateTime?,
      pin: fields[4] as DateTime?,
      path: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AudioModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.maxTime)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.createAudio)
      ..writeByte(4)
      ..write(obj.pin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioModel _$AudioModelFromJson(Map<String, dynamic> json) => AudioModel(
      title: json['title'] as String?,
      maxTime: json['maxTime'] as int?,
      createAudio: json['createAudio'] == null
          ? null
          : DateTime.parse(json['createAudio'] as String),
      pin: json['pin'] == null ? null : DateTime.parse(json['pin'] as String),
      isPlay: json['isPlay'] as bool? ?? false,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$AudioModelToJson(AudioModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'maxTime': instance.maxTime,
      'path': instance.path,
      'createAudio': instance.createAudio?.toIso8601String(),
      'pin': instance.pin?.toIso8601String(),
      'isPlay': instance.isPlay,
    };
