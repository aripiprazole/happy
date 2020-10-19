import { icon } from "leaflet";

import mapMarker from "@/assets/map-marker.svg";

const createMapIcon = () =>
  icon({
    iconUrl: mapMarker,
    iconSize: [58, 68],
    iconAnchor: [29, 68],
    popupAnchor: [0, -68]
  });

export default createMapIcon;
