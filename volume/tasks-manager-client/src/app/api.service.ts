import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class ApiService {
  constructor(private http: HttpClient) {}
  baseUrl = 'https://edimossilva-task-manager.herokuapp.com/';
  loginResource = 'auth/login';
  loginUrl = `${this.baseUrl}${this.loginResource}`;

  doLogin(username: string, password: string) {
    const body = {
      username,
      password,
    };
    return this.http.post<any>(this.loginUrl, body);
  }
}
