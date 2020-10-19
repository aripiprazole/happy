import Vue from "vue";
import VueRouter, { RouteConfig } from "vue-router";
import Home from "@/views/home/Home.vue";
import OrphanagesMap from "@/views/orphanages-map/OrphanagesMap.vue";
import Orphanage from "@/views/orphanage/Orphanage.vue";
import CreateOrphanage from "@/views/create-orphanage/CreateOrphanage.vue";

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
  {
    path: "/",
    name: "Home",
    component: Home
  },
  {
    path: "/app",
    name: "OrphanagesMap",
    component: OrphanagesMap
  },
  {
    path: "/orphanages/new",
    name: "CreateOrphanage",
    component: CreateOrphanage
  },
  {
    path: "/orphanages/:id",
    name: "Orphanage",
    component: Orphanage
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
