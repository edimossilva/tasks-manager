import { Injectable } from '@angular/core';
@Injectable({
  providedIn: 'root',
})
export class AuthService {
  token: string;
  constructor() {}

  isLogged() {
    return this.getToken() !== null;
  }

  getToken() {
    if (this.token) {
      return this.token;
    }

    const userJson = localStorage.getItem('user');
    if (userJson) {
      const user = JSON.parse(userJson);
      this.token = user.token;
      return this.token;
    }
    return null;
  }
}
