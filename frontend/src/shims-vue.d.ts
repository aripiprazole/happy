import { State } from "./store";

declare module "*.vue" {
  import Vue from "vue";

  export default Vue;
}

declare module "*.svg" {
  declare const path: string;

  export default path;
}

declare module "vue/types/vue" {
  interface Vue {
    $store: Store<State>;
  }
}
