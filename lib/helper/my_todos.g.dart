// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_todos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyTodosAdapter extends TypeAdapter<MyTodos> {
  @override
  final int typeId = 1;

  @override
  MyTodos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyTodos(
      (fields[0] as List).cast<Todo>(),
    );
  }

  @override
  void write(BinaryWriter writer, MyTodos obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.todoItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyTodosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
