// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-orphanage-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateOrphanageStore on CreateOrphanageStoreBase, Store {
  final _$orphanageAtom = Atom(name: 'CreateOrphanageStoreBase.orphanage');

  @override
  Orphanage get orphanage {
    _$orphanageAtom.reportRead();
    return super.orphanage;
  }

  @override
  set orphanage(Orphanage value) {
    _$orphanageAtom.reportWrite(value, super.orphanage, () {
      super.orphanage = value;
    });
  }

  final _$errorAtom = Atom(name: 'CreateOrphanageStoreBase.error');

  @override
  Exception get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadingAtom = Atom(name: 'CreateOrphanageStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$createOrphanageAsyncAction =
      AsyncAction('CreateOrphanageStoreBase.createOrphanage');

  @override
  Future<Orphanage> createOrphanage(Map<String, dynamic> data) {
    return _$createOrphanageAsyncAction.run(() => super.createOrphanage(data));
  }

  @override
  String toString() {
    return '''
orphanage: ${orphanage},
error: ${error},
loading: ${loading}
    ''';
  }
}
