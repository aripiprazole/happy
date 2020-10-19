<template>
  <div id="create-orphanage-page">
    <sidebar />

    <main class="container">
      <form class="create-orphanage-form" @submit.prevent="onSubmit">
        <fieldset>
          <legend>Dados</legend>

          <l-map
            class="orphanage-map"
            :center="center"
            :zoom="zoom"
            v-on:click="onPositionUpdate"
          >
            <l-tile-layer :url="mapTileLayer" />

            <l-marker
              v-if="latitude != 0 && longitude != 0"
              :lat-lng="[latitude, longitude]"
              :icon="markerIcon"
            />
          </l-map>

          <div class="input-block">
            <label for="name">Nome</label>
            <input v-model="name" id="name" />
          </div>

          <div class="input-block">
            <label for="about">
              Sobre <span class="comment">Máximo de 300 caracteres</span>
            </label>

            <textarea id="about" maxlength="300" v-model="about" />
          </div>

          <div class="input-block">
            <label for="images">Fotos</label>

            <div class="images-container">
              <img
                class="preview-image"
                v-for="image in previewImages"
                :key="image"
                :src="image"
                :alt="name"
              />

              <label for="images" class="new-image">
                <v-icon :size="24" color="#15b6d6">
                  {{ mdiPlus }}
                </v-icon>
              </label>

              <input
                id="images"
                type="file"
                multiple
                hidden
                @change="setImages"
              />
            </div>
          </div>
        </fieldset>

        <fieldset>
          <legend>Visitação</legend>

          <div class="input-block">
            <label for="opening_hours">Horario de funcionamento</label>
            <input v-model="openingHours" id="opening_hours" />
          </div>

          <div class="input-block">
            <label for="instructions">
              Instruções <span class="comment">Máximo de 300 caracteres</span>
            </label>

            <textarea
              id="instructions"
              maxlength="300"
              v-model="instructions"
            />
          </div>

          <div class="input-block">
            <label for="open_on_weekends">Atende fim de semana</label>

            <div class="button-select">
              <button
                type="button"
                :class="openOnWeekends && 'active'"
                @click="setOpenOnWeekends(true)"
              >
                Sim
              </button>
              <button
                type="button"
                :class="!openOnWeekends && 'active'"
                @click="setOpenOnWeekends(false)"
              >
                Não
              </button>
            </div>
          </div>
        </fieldset>

        <button class="confirm-button" type="submit">
          Confirmar
        </button>
      </form>
    </main>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mdiArrowLeft, mdiPlus } from "@mdi/js";
import { LeafletMouseEvent } from "leaflet";
import { LMap, LTileLayer, LMarker } from "vue2-leaflet";

import createDefaultMapData from "@/utils/createDefaultMapData";

import {
  CreateOrphanageActions,
  mapCreateOrphanageState,
  OrphanageCreateData
} from "@/store/modules/create-orphanage";
import { mapLocationState } from "@/store/modules/location";

import Sidebar from "@/components/sidebar/Sidebar.vue";

const createDefaultFormData = (): OrphanageCreateData => ({
  name: "",
  about: "",
  instructions: "",
  openingHours: "",
  openOnWeekends: false,
  latitude: 0,
  longitude: 0,
  images: new Array<File>()
});

export default Vue.extend({
  components: { LMap, LTileLayer, LMarker, Sidebar },

  data: () => ({
    ...createDefaultMapData(),
    ...createDefaultFormData(),
    mdiArrowLeft,
    mdiPlus,
    previewImages: new Array<string>()
  }),

  computed: {
    ...mapCreateOrphanageState(),
    ...mapLocationState(),

    center() {
      const { latitude, longitude } = this.location.position;

      return [latitude, longitude];
    }
  },

  watch: {
    orphanage() {
      this.$router.push("/app");
    }
  },

  methods: {
    onPositionUpdate(event: LeafletMouseEvent) {
      this.latitude = event.latlng.lat;
      this.longitude = event.latlng.lng;
    },

    setOpenOnWeekends(value: boolean) {
      this.openOnWeekends = value;
    },

    setImages(event: Event) {
      if (!event.target) return;

      const target = event.target as HTMLInputElement;
      if (!target.files) return;

      const images = Array.from(target.files);

      this.images = images;
      this.previewImages = images.map(URL.createObjectURL);
    },

    onSubmit() {
      if (this.loading) return;

      this.$store.dispatch(CreateOrphanageActions.CREATE_ORPHANAGE, this);
    }
  }
});
</script>

<style src="./CreateOrphanage.scss" lang="scss" scoped></style>
