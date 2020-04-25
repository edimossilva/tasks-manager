import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';

@Injectable({
  providedIn: 'root',
})
export class ApiService {
  constructor(private http: HttpClient, private authService: AuthService) {}
  baseUrl = 'https://edimossilva-task-manager.herokuapp.com/';
  loginUrl = `${this.baseUrl}auth/login`;
  tasklistsUrl = `${this.baseUrl}task_lists`;

  getHeaders() {
    const token = this.authService.getToken();
    return {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      }),
    };
  }

  doLogin(username: string, password: string) {
    const body = {
      username,
      password,
    };
    return this.http.post<any>(this.loginUrl, body);
  }

  getTaskLists() {
    const token = this.authService.getToken();

    return this.http.get<any>(this.tasklistsUrl, this.getHeaders());
  }
}
