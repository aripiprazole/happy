import { OrphanageResponse } from "@/dtos/Orphanage";
import Orphanage from "@/models/Orphanage";
import { AxiosInstance, AxiosRequestConfig } from "axios";

class OrphanageService {
  public constructor(private readonly http: AxiosInstance) {}

  public async findAllOrphanages(): Promise<Orphanage[]> {
    const response = await this.http.get<OrphanageResponse[]>("/orphanages");

    return response.data.map(Orphanage.fromResponse);
  }

  public async findOrphanageById(id: number): Promise<Orphanage> {
    const response = await this.http.get<OrphanageResponse>(
      `/orphanages/${id}`
    );

    return Orphanage.fromResponse(response.data);
  }

  public async createOrphanage(data: FormData): Promise<Orphanage> {
    const path = "/orphanages";
    const config: AxiosRequestConfig = {
      headers: {
        "Content-Type": "multipart/form-data"
      }
    };

    const response = await this.http.post<OrphanageResponse>(
      path,
      data,
      config
    );

    return Orphanage.fromResponse(response.data);
  }
}

export default OrphanageService;
