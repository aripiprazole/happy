// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orphanages-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrphanagesStore on OrphanagesStoreBase, Store {
  final _$orphanagesAtom = Atom(name: 'OrphanagesStoreBase.orphanages');

  @override
  ObservableList<Orphanage> get orphanages {
    _$orphanagesAtom.reportRead();
    return super.orphanages;
  }

  @override
  set orphanages(ObservableList<Orphanage> value) {
    _$orphanagesAtom.reportWrite(value, super.orphanages, () {
      super.orphanages = value;
    });
  }

  final _$errorAtom = Atom(name: 'OrphanagesStoreBase.error');

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

  final _$loadingAtom = Atom(name: 'OrphanagesStoreBase.loading');

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

  final _$fetchOrphanagesAsyncAction =
      AsyncAction('OrphanagesStoreBase.fetchOrphanages');

  @override
  Future<void> fetchOrphanages() {
    return _$fetchOrphanagesAsyncAction.run(() => super.fetchOrphanages());
  }

  final _$OrphanagesStoreBaseActionController =
      ActionController(name: 'OrphanagesStoreBase');

  @override
  void addOrphanage(Orphanage orphanage) {
    final _$actionInfo = _$OrphanagesStoreBaseActionController.startAction(
        name: 'OrphanagesStoreBase.addOrphanage');
    try {
      return super.addOrphanage(orphanage);
    } finally {
      _$OrphanagesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orphanages: ${orphanages},
error: ${error},
loading: ${loading}
    ''';
  }
}
