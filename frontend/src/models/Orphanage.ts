import { OrphanageResponse } from "@/dtos/Orphanage";

class Orphanage {
  public constructor(
    public readonly id: number,
    public readonly name: string,
    public readonly latitude: number,
    public readonly longitude: number,
    public readonly about: string,
    public readonly instructions: string,
    public readonly openingHours: string,
    public readonly openOnWeekends: boolean,
    public readonly images: string[]
  ) {}

  public static fromResponse(response: OrphanageResponse) {
    return new Orphanage(
      response.id,
      response.name,
      response.latitude,
      response.longitude,
      response.about,
      response.instructions,
      response.opening_hours,
      response.open_on_weekends,
      response.images
    );
  }
}

export default Orphanage;
