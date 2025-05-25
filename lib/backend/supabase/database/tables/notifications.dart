import '../database.dart';

class NotificationsTable extends SupabaseTable<NotificationsRow> {
  @override
  String get tableName => 'notifications';

  @override
  NotificationsRow createRow(Map<String, dynamic> data) =>
      NotificationsRow(data);
}

class NotificationsRow extends SupabaseDataRow {
  NotificationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => NotificationsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get sentAt => getField<String>('sent_at');
  set sentAt(String? value) => setField<String>('sent_at', value);

  String? get body => getField<String>('body');
  set body(String? value) => setField<String>('body', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  String? get token => getField<String>('token');
  set token(String? value) => setField<String>('token', value);

  String? get notificationUserIds => getField<String>('notification_user_ids');
  set notificationUserIds(String? value) =>
      setField<String>('notification_user_ids', value);
}
