import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class GetInfoService {

  constructor(private httpClient: HttpClient) { }

  studentLogin(data){
    return this.httpClient.post("http://localhost:5000/loginStudent",data)
  }
  studentSignin(data){
    return this.httpClient.post("http://localhost:5000/registerStudent",data);
  }

  certifierLogin(data){
    return this.httpClient.post("http://localhost:5000/loginOrganization",data);
  }
  certifierSignin(data){
    return this.httpClient.post("http://localhost:5000/registerOrganization",data)
  }
  
}
