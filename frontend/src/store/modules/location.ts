import { Module, mapState } from "vuex";
import { Accessors } from "vue/types/options";
import { State } from "..";

export type Position = {
  latitude: number;
  longitude: number;
};

export type LocationState = {
  position: Position;
  loading: boolean;
  error: Error | null;
};

export enum LocationActions {
  FETCH_LOCATION = "@location/fetch-location",
  FETCH_SUCCESS = "@location/fetch-location-success",
  FETCH_ERROR = "@location/fetch-location-error"
}

export const mapLocationState = () =>
  mapState<State>({
    location: (state: State) => state.location
  }) as Accessors<{ location: LocationState }>;

export const createDefaultPosition = (): Position => ({
  latitude: 0,
  longitude: 0
});

const createLocationModule = (): Module<LocationState, State> => ({
  state: () => ({
    position: createDefaultPosition(),
    loading: true,
    error: null
  }),

  actions: {
    [LocationActions.FETCH_LOCATION]: context => {
      context.commit(LocationActions.FETCH_LOCATION);

      navigator.geolocation.getCurrentPosition(
        geoLocationPosition => {
          const position = {
            latitude: geoLocationPosition.coords.latitude,
            longitude: geoLocationPosition.coords.longitude
          };

          context.commit(LocationActions.FETCH_SUCCESS, position);
        },
        error => {
          context.commit(LocationActions.FETCH_ERROR, error);
        }
      );
    }
  },

  mutations: {
    [LocationActions.FETCH_LOCATION]: state => {
      state.position = createDefaultPosition();
      state.loading = true;
      state.error = null;
    },

    [LocationActions.FETCH_SUCCESS]: (state, position: Position) => {
      state.position = position;
      state.loading = true;
      state.error = null;
    },

    [LocationActions.FETCH_ERROR]: (state, error: Error) => {
      state.position = createDefaultPosition();
      state.loading = true;
      state.error = error;
    }
  }
});

export default createLocationModule;
