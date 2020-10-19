import Vue from "vue";
import Vuex from "vuex";

import { createAxiosApi } from "@/services/Api";
import OrphanageService from "@/services/OrphanageService";

import createOrphanageMapModule, {
  OrphanageMapState
} from "./modules/orphanage-map";

import createCreateOrphanageModule, {
  CreateOrphanageState
} from "./modules/create-orphanage";

import createLocationModule, { LocationState } from "./modules/location";
import createOrphanageModule, { OrphanageState } from "./modules/orphanage";

Vue.use(Vuex);

export type State = {
  orphanages: OrphanageMapState;
  orphanage: OrphanageState;
  createOrphanage: CreateOrphanageState;
  location: LocationState;
};

const orphanageService = new OrphanageService(createAxiosApi());

const store = new Vuex.Store<State>({
  mutations: {},
  actions: {},
  modules: {
    orphanages: createOrphanageMapModule(orphanageService),
    orphanage: createOrphanageModule(orphanageService),
    createOrphanage: createCreateOrphanageModule(orphanageService),
    location: createLocationModule()
  }
});

export default store;
