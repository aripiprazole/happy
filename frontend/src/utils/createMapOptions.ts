import { MapOptions } from "leaflet";

const createMapOptions = (): MapOptions => ({
  dragging: false,
  touchZoom: false,
  zoomControl: false,
  scrollWheelZoom: false,
  doubleClickZoom: false
});

export default createMapOptions;
