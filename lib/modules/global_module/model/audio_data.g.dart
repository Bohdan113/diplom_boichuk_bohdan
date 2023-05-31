// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioDataAdapter extends TypeAdapter<AudioData> {
  @override
  final int typeId = 1;

  @override
  AudioData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioData(
      data: (fields[0] as List?)?.cast<AudioModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AudioData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioData _$AudioDataFromJson(Map<String, dynamic> json) => AudioData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AudioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudioDataToJson(AudioData instance) => <String, dynamic>{
      'data': instance.data,
    };
