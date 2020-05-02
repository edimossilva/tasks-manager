import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import { JwtHelperService } from '@auth0/angular-jwt';

@Injectable({
  providedIn: 'root',
})
export class AuthService implements CanActivate {
  token: string;

  constructor(public router: Router, public jwtHelper: JwtHelperService) {}

  isLogged() {
    const token = this.getToken();
    return !this.jwtHelper.isTokenExpired(token);
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

  canActivate(): boolean {
    if (!this.isLogged()) {
      this.router.navigate(['login']);
      return false;
    }
    return true;
  }
}
