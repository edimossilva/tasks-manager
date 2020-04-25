import { Injectable } from '@angular/core';
@Injectable({
  providedIn: 'root',
})
export class AuthService {
  token: string;
  constructor() {}

  isLogged() {
    if (this.token) {
      return true;
    }

    const userJson = localStorage.getItem('user');
    if (userJson) {
      const user = JSON.parse(userJson);
      this.token = user.token;
      return true;
    }

    return null;
  }
}
