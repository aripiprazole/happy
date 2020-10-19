import { Module, mapState } from "vuex";
import { Accessors } from "vue/types/options";
import { State } from "..";
import OrphanageService from "@/services/OrphanageService";
import Orphanage from "@/models/Orphanage";

export type OrphanageState = {
  orphanage: Orphanage | null;
  loading: boolean;
  error: Error | null;

  activeImage: string;
};

export enum OrphanageActions {
  FETCH_ORPHANAGE = "@orphanage/fetch",
  FETCH_ERROR = "@orphanage/fetch-error",
  FETCH_SUCCESS = "@orphanage/fetch-success",

  UPDATE_ACTIVE_IMAGE = "@orphanage/update-active-image"
}

export const mapOrphanageState = () =>
  mapState<State>({
    orphanage: (state: State) => state.orphanage.orphanage,
    loading: (state: State) => state.orphanage.loading,
    error: (state: State) => state.orphanage.error,
    activeImage: (state: State) => state.orphanage.activeImage
  }) as Accessors<OrphanageState>;

const createOrphanageModule = (
  orphanageService: OrphanageService
): Module<OrphanageState, State> => ({
  state: () => ({
    orphanage: null,
    loading: true,
    error: null,
    activeImage: ""
  }),

  actions: {
    [OrphanageActions.FETCH_ORPHANAGE]: async (context, id: number) => {
      context.commit(OrphanageActions.FETCH_ORPHANAGE);

      try {
        const orphanage = await orphanageService.findOrphanageById(id);
        context.commit(OrphanageActions.FETCH_SUCCESS, orphanage);

        const firstImage = orphanage.images[0];
        if (firstImage)
          context.commit(OrphanageActions.UPDATE_ACTIVE_IMAGE, firstImage);
      } catch (error) {
        context.commit(OrphanageActions.FETCH_ERROR, error);
      }
    },

    [OrphanageActions.UPDATE_ACTIVE_IMAGE]: (context, image: string) => {
      context.commit(OrphanageActions.UPDATE_ACTIVE_IMAGE, image);
    }
  },

  mutations: {
    [OrphanageActions.FETCH_ORPHANAGE]: state => {
      state.orphanage = null;
      state.loading = true;
      state.error = null;
    },

    [OrphanageActions.UPDATE_ACTIVE_IMAGE]: (state, image: string) => {
      state.activeImage = image;
    },

    [OrphanageActions.FETCH_SUCCESS]: (state, orphanage: Orphanage) => {
      state.orphanage = orphanage;
      state.loading = false;
      state.error = null;
    },

    [OrphanageActions.FETCH_ERROR]: (state, error: Error) => {
      state.orphanage = null;
      state.loading = false;
      state.error = error;
    }
  }
});

export default createOrphanageModule;
