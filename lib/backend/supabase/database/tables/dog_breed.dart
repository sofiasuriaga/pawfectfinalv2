import '../database.dart';

class DogBreedTable extends SupabaseTable<DogBreedRow> {
  @override
  String get tableName => 'dog_breed';

  @override
  DogBreedRow createRow(Map<String, dynamic> data) => DogBreedRow(data);
}

class DogBreedRow extends SupabaseDataRow {
  DogBreedRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DogBreedTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get breedName => getField<String>('Breed Name');
  set breedName(String? value) => setField<String>('Breed Name', value);
}
