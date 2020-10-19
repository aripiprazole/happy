import { Module, mapState } from "vuex";
import { Accessors } from "vue/types/options";
import { State } from "..";
import OrphanageService from "@/services/OrphanageService";
import Orphanage from "@/models/Orphanage";

export type OrphanageMapState = {
  orphanages: Orphanage[];
  loading: boolean;
  error: Error | null;
};

export enum OrphanageMapActions {
  FETCH_ORPHANAGES = "@orphanage-map/fetch",
  FETCH_ERROR = "@orphanage-map/fetch-error",
  FETCH_SUCCESS = "@orphanage-map/fetch-success",
  ADD_ORPHANAGE = "@orphanage-map/add-orphanage"
}

export const mapOrphanageMapState = () =>
  mapState<State>({
    orphanages: (state: State) => state.orphanages.orphanages,
    loading: (state: State) => state.orphanages.loading,
    error: (state: State) => state.orphanages.error
  }) as Accessors<OrphanageMapState>;

const createOrphanageMapModule = (
  orphanageService: OrphanageService
): Module<OrphanageMapState, State> => ({
  state: () => ({
    orphanages: [],
    loading: true,
    error: null
  }),

  actions: {
    [OrphanageMapActions.FETCH_ORPHANAGES]: async context => {
      context.commit(OrphanageMapActions.FETCH_ORPHANAGES);

      try {
        const orphanages = await orphanageService.findAllOrphanages();

        context.commit(OrphanageMapActions.FETCH_SUCCESS, orphanages);
      } catch (error) {
        context.commit(OrphanageMapActions.FETCH_ERROR, error);
      }
    }
  },

  mutations: {
    [OrphanageMapActions.FETCH_ORPHANAGES]: state => {
      state.orphanages = [];
      state.loading = true;
      state.error = null;
    },

    [OrphanageMapActions.FETCH_SUCCESS]: (state, orphanages: Orphanage[]) => {
      state.orphanages = orphanages;
      state.loading = false;
      state.error = null;
    },

    [OrphanageMapActions.FETCH_ERROR]: (state, error: Error) => {
      state.orphanages = [];
      state.loading = false;
      state.error = error;
    },

    [OrphanageMapActions.ADD_ORPHANAGE]: (state, orphanage: Orphanage) => {
      state.orphanages = [...state.orphanages, orphanage];
      state.loading = false;
      state.error = null;
    }
  }
});

export default createOrphanageMapModule;
