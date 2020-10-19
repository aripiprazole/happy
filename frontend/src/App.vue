<template>
  <router-view />
</template>

<script lang="ts">
import Vue from "vue";

import { LocationActions } from "@/store/modules/location";

export default Vue.extend({
  created() {
    this.$store.dispatch(LocationActions.FETCH_LOCATION);
  }
});
</script>

<style lang="scss">
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  color: #fff;
  background: #ebf2f5;
}

body,
input,
button,
textarea {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  font: 600 18px Nunito, sans-serif;
}

html,
body,
#app {
  height: 100%;
}
</style>
