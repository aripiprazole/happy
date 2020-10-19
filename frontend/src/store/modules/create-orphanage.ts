import { Module, mapState } from "vuex";
import { Accessors } from "vue/types/options";
import { OrphanageMapActions } from "./orphanage-map";
import { State } from "..";
import Orphanage from "@/models/Orphanage";
import OrphanageService from "@/services/OrphanageService";

export type OrphanageCreateData = {
  name: string;
  latitude: number;
  longitude: number;
  about: string;
  instructions: string;
  openingHours: string;
  openOnWeekends: boolean;
  images: File[];
};

export type CreateOrphanageState = {
  orphanage: Orphanage | null;
  loading: boolean;
  error: Error | null;
};

export enum CreateOrphanageActions {
  CREATE_ORPHANAGE = "@create-orphanage/create-orphanage",
  CREATE_SUCCESS = "@create-orphanage/create-orphanage-success",
  CREATE_ERROR = "@create-orphanage/create-orphanage-error"
}

export const mapCreateOrphanageState = () =>
  mapState<State>({
    orphanage: (state: State) => state.createOrphanage.orphanage,
    loading: (state: State) => state.createOrphanage.loading,
    error: (state: State) => state.createOrphanage.error
  }) as Accessors<CreateOrphanageState>;

const createFormDataByData = (data: OrphanageCreateData) => {
  const formData = new FormData();

  formData.append("name", data.name);
  formData.append("about", data.about);
  formData.append("instructions", data.instructions);
  formData.append("opening_hours", data.openingHours);
  formData.append("openOnWeekends", data.openOnWeekends.toString());
  formData.append("latitude", data.latitude.toString());
  formData.append("longitude", data.longitude.toString());

  data.images.forEach(image => formData.append("images", image));

  return formData;
};

const createCreateOrphanageModule = (
  orphanageService: OrphanageService
): Module<CreateOrphanageState, State> => ({
  state: () => ({
    orphanage: null,
    loading: false,
    error: null
  }),

  actions: {
    [CreateOrphanageActions.CREATE_ORPHANAGE]: async (
      context,
      data: OrphanageCreateData
    ) => {
      context.commit(CreateOrphanageActions.CREATE_ORPHANAGE);

      try {
        const formData = createFormDataByData(data);
        const orphanage = await orphanageService.createOrphanage(formData);

        context.commit(CreateOrphanageActions.CREATE_SUCCESS, orphanage);
        context.commit(OrphanageMapActions.ADD_ORPHANAGE, orphanage);
      } catch (error) {
        context.commit(CreateOrphanageActions.CREATE_ERROR, error);
      }
    }
  },

  mutations: {
    [CreateOrphanageActions.CREATE_ORPHANAGE]: state => {
      state.orphanage = null;
      state.loading = true;
      state.error = null;
    },

    [CreateOrphanageActions.CREATE_SUCCESS]: (state, orphanage: Orphanage) => {
      state.orphanage = orphanage;
      state.loading = false;
      state.error = null;
    },

    [CreateOrphanageActions.CREATE_ERROR]: (state, error: Error) => {
      state.orphanage = null;
      state.loading = false;
      state.error = error;
    }
  }
});

export default createCreateOrphanageModule;
