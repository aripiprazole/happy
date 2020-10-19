<template>
  <div id="orphanages-map-page">
    <aside class="sidebar">
      <header>
        <img :src="mapMarker" alt="Happy!" />

        <h2>Escolha um orfanato no mapa</h2>
        <p>Muitas crianças estão esperando a sua visita :)</p>
      </header>

      <footer>
        <strong>Betim</strong>
        <span>Minas Gerais</span>
      </footer>
    </aside>

    <l-map class="orphanages-map" :center="center" :zoom="zoom">
      <l-tile-layer :url="mapTileLayer" />

      <l-marker
        v-for="orphanage in orphanages"
        v-bind:lat-lng="[orphanage.latitude, orphanage.longitude]"
        :key="orphanage.id"
        :icon="markerIcon"
      >
        <l-popup :options="markerPopupOptions" class="map-popup">
          {{ orphanage.name }}

          <router-link :to="`/orphanages/${orphanage.id}`">
            <v-icon color="#fff ">{{ mdiArrowRight }}</v-icon>
          </router-link>
        </l-popup>
      </l-marker>
    </l-map>

    <router-link to="/orphanages/new" class="create-orphanage">
      <v-icon color="#fff">{{ mdiPlus }}</v-icon>
    </router-link>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mdiPlus, mdiArrowRight } from "@mdi/js";

import { LMap, LTileLayer, LMarker, LPopup } from "vue2-leaflet";

import mapMarker from "@/assets/map-marker.svg";

import createDefaultMapData from "@/utils/createDefaultMapData";

import {
  mapOrphanageMapState,
  OrphanageMapActions
} from "@/store/modules/orphanage-map";
import { mapLocationState } from "@/store/modules/location";

export default Vue.extend({
  components: { LMap, LTileLayer, LMarker, LPopup },

  data: () => ({
    ...createDefaultMapData(),
    mdiPlus,
    mdiArrowRight,
    mapMarker
  }),

  computed: {
    ...mapOrphanageMapState(),
    ...mapLocationState(),

    center() {
      const { latitude, longitude } = this.location.position;

      return [latitude, longitude];
    }
  },

  created() {
    this.$store.dispatch(OrphanageMapActions.FETCH_ORPHANAGES);
  }
});
</script>

<style lang="scss" src="./OrphanagesMap.scss" scoped></style>
<style lang="scss" src="./Leaflet.scss"></style>
