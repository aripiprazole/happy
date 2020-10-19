import 'package:happy/models/orphanage.dart';
import 'package:happy/services/orphanage-service.dart';
import 'package:mobx/mobx.dart';

part 'orphanages-store.g.dart';

class OrphanagesStore = OrphanagesStoreBase with _$OrphanagesStore;

abstract class OrphanagesStoreBase with Store {
  final OrphanageService orphanageService;

  OrphanagesStoreBase(this.orphanageService);

  @observable
  ObservableList<Orphanage> orphanages = ObservableList();

  @observable
  Exception error;

  @observable
  bool loading;

  @action
  Future<void> fetchOrphanages() async {
    print('FETCHING ORPHANAGES');
    loading = true;

    try {
      final orphanages = await orphanageService.findAllOrphanages();
      this.orphanages = ObservableList.of(orphanages);
    } catch (error) {
      if (error is Exception) this.error = error;
    }

    loading = false;
  }

  @action
  void addOrphanage(Orphanage orphanage) {
    orphanages.add(orphanage);
  }
}
