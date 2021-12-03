import { BadRequestException, Injectable } from '@nestjs/common';
import { HttpService } from "@nestjs/axios";
import { DataLoopConfigFactory, DATALOOP_AUTH_ENDPOINT, DATALOOP_ENDPOINT, IDataloopOAuthInput } from "./dataloop.classes";
import { map, Observable, switchMap, tap } from "rxjs";

/* eslint camelcase: off */
@Injectable()
export class DataloopService {
  private _token: string = null;
  public get token(): string {
    return this._token;
  }

  constructor(
    private http: HttpService
  ) { 
    // bind an interceptor that will dynamically provide the last token retrieved
    this.http.axiosRef.interceptors.request.use(request => {
      request.headers = {
        ...request.headers,
        Authorization: `bearer ${this.token}`,
      };
      return request;
    });
  }

  public getJwt(config: IDataloopOAuthInput): Observable<string> {
    return this.http.post(`${DATALOOP_AUTH_ENDPOINT}/oauth/token`, config).pipe(
      map(({ data }) => data as string),
      tap(token => {
        this._token = token;
      })
    );
  }

  public downloadAnnotations(datasetId: string): Observable<any> {
    if (!datasetId) throw new BadRequestException("Missing request data");
    return this.getJwt(DataLoopConfigFactory()).pipe(
      switchMap(() => this.http.get(`${DATALOOP_ENDPOINT}/datasets/${datasetId}/annotations/json`))
    );
  }
}
