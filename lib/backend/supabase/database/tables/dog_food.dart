import '../database.dart';

class DogFoodTable extends SupabaseTable<DogFoodRow> {
  @override
  String get tableName => 'dog_food';

  @override
  DogFoodRow createRow(Map<String, dynamic> data) => DogFoodRow(data);
}

class DogFoodRow extends SupabaseDataRow {
  DogFoodRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DogFoodTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get foodName => getField<String>('food_name');
  set foodName(String? value) => setField<String>('food_name', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);
}
