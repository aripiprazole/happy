import createMapIcon from "./createMapIcon";
import createMapOptions from "./createMapOptions";
import createMarkerPopupOptions from "./createMarkerPopupOptions";

const createDefaultMapData = () => ({
  zoom: 16,
  markerIcon: createMapIcon(),
  mapOptions: createMapOptions(),
  mapTileLayer: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  markerPopupOptions: createMarkerPopupOptions(),
  markerInteractive: false
});

export default createDefaultMapData;
