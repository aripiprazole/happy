<template>
  <div id="home-page">
    <div class="container">
      <img :src="logo" alt="Happy" />

      <main>
        <h1>Leve felicidade para o mundo</h1>
        <p>Visite orfanatos e mude o dia de muitas crianças.</p>
      </main>

      <section class="location">
        <strong>Betim</strong>
        <span>Minas Gerais</span>
      </section>

      <router-link to="/app" class="enter-app">
        <v-icon>{{ mdiArrowRight }}</v-icon>
      </router-link>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mdiArrowRight } from "@mdi/js";

import logo from "@/assets/logo.svg";

export default Vue.extend({
  data: () => ({
    mdiArrowRight,
    logo
  })
});
</script>

<style lang="scss" src="./Home.scss" scoped></style>
