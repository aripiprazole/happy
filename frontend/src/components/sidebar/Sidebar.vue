<template>
  <aside class="sidebar">
    <img :src="mapMarker" alt="Happy" />

    <footer>
      <button type="button" v-on:click="goBack">
        <v-icon :size="24" color="#FFF">{{ mdiArrowLeft }}</v-icon>
      </button>
    </footer>
  </aside>
</template>

<script lang="ts">
import Vue from "vue";
import { mdiArrowLeft } from "@mdi/js";

import mapMarker from "@/assets/map-marker.svg";

export default Vue.extend({
  data: () => ({
    mdiArrowLeft,
    mapMarker
  }),

  methods: {
    goBack() {
      this.$router.go(-1);
    }
  }
});
</script>

<style src="./Sidebar.scss" lang="scss" scoped></style>
