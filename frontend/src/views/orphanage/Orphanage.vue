<template>
  <div id="orphanage-page">
    <sidebar />

    <main v-if="!loading && !error && orphanage" class="container">
      <div class="orphanage-details">
        <img :src="activeImage" :alt="orphanage.name" />

        <div class="images">
          <button
            v-for="image in orphanage.images"
            :key="image"
            :class="activeImage === image ? 'active' : ''"
            type="button"
            @click="setActiveImage(image)"
          >
            <img :src="image" :alt="orphanage.name" />
          </button>
        </div>

        <div class="orphanage-details-content">
          <h1>{{ orphanage.name }}</h1>
          <p>{{ orphanage.about }}</p>

          <div class="map-container">
            <l-map
              class="orphanage-map"
              :center="[orphanage.latitude, orphanage.longitude]"
              :zoom="zoom"
              :options="mapOptions"
            >
              <l-tile-layer :url="mapTileLayer" />

              <l-marker
                :lat-lng="[orphanage.latitude, orphanage.longitude]"
                :icon="markerIcon"
              />
            </l-map>

            <footer>
              <a :href="googleMapUrl" target="_blank" rel="noopener noreferrer">
                Ver rotas no Google Maps
              </a>
            </footer>
          </div>

          <hr />

          <h2>Instruções para visita</h2>
          <p>
            {{ orphanage.instructions }}
          </p>

          <div class="open-details">
            <div class="hour">
              <v-icon :size="32" color="#15b6d6">
                {{ mdiClock }}
              </v-icon>

              Segunda à Sexta <br />
              {{ orphanage.openingHours }}
            </div>

            <div v-if="orphanage.openOnWeekends" class="open-on-weekends">
              <v-icon :size="32" color="#39cc83">
                {{ mdiInformation }}
              </v-icon>

              Atendemos <br />
              fim de semana
            </div>
            <div v-else class="dont-open-on-weekends">
              <v-icon :size="32" color="#ff669d">
                {{ mdiInformation }}
              </v-icon>

              Não atendemos <br />
              fim de semana
            </div>
          </div>

          <button type="button" class="contact-button">
            <v-icon style="display: block" :size="30" color="#fff">
              {{ mdiWhatsapp }}
            </v-icon>

            Entrar em contato
          </button>
        </div>
      </div>
    </main>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mdiArrowLeft, mdiWhatsapp, mdiClock, mdiInformation } from "@mdi/js";

import { LMap, LTileLayer, LMarker } from "vue2-leaflet";

import createDefaultMapData from "@/utils/createDefaultMapData";

import { OrphanageActions, mapOrphanageState } from "@/store/modules/orphanage";

import Sidebar from "@/components/sidebar/Sidebar.vue";

export default Vue.extend({
  components: { LMap, LTileLayer, LMarker, Sidebar },

  data: () => ({
    ...createDefaultMapData(),
    mdiArrowLeft,
    mdiWhatsapp,
    mdiClock,
    mdiInformation
  }),

  computed: {
    ...mapOrphanageState(),

    googleMapUrl() {
      if (!this.orphanage) return "";

      const url = "https://www.google.com/maps/dir/";

      const { latitude, longitude } = this.orphanage;

      return `${url}?api=1&destination=${latitude},${longitude}`;
    }
  },

  methods: {
    setActiveImage(image: string) {
      this.$store.dispatch(OrphanageActions.UPDATE_ACTIVE_IMAGE, image);
    }
  },

  created() {
    const orphanageId = parseFloat(this.$route.params["id"]);

    this.$store.dispatch(OrphanageActions.FETCH_ORPHANAGE, orphanageId);
  }
});
</script>

<style src="./Orphanage.scss" lang="scss" scoped></style>
<style src="./Leaflet.scss" lang="scss"></style>
