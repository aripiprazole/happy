import 'package:happy/models/orphanage.dart';
import 'package:happy/services/orphanage-service.dart';
import 'package:mobx/mobx.dart';

part 'create-orphanage-store.g.dart';

class CreateOrphanageStore = CreateOrphanageStoreBase
    with _$CreateOrphanageStore;

abstract class CreateOrphanageStoreBase with Store {
  final OrphanageService orphanageService;

  CreateOrphanageStoreBase(this.orphanageService);

  @observable
  Orphanage orphanage;

  @observable
  Exception error;

  @observable
  bool loading;

  @action
  Future<Orphanage> createOrphanage(Map<String, dynamic> data) async {
    loading = true;

    try {
      orphanage = await orphanageService.createOrphanage(data);
    } catch (error) {
      if (error is Exception) this.error = error;
    }

    loading = false;

    return orphanage;
  }
}
