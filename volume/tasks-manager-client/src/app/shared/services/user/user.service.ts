import { Injectable } from '@angular/core';
import { User } from './user';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor() {}

  user: User;

  setUser(user) {
    this.user = <User>{
      id: user.userId,
      username: user.username,
      token: user.token,
    };

    const userJson = JSON.stringify(this.user);
    localStorage.setItem('user', userJson);
  }

  getUser() {
    if (this.user) {
      return this.user;
    }

    const userJson = localStorage.getItem('user');
    if (userJson) {
      this.user = JSON.parse(userJson);
      return this.user;
    }

    return null;
  }

  getUsername() {
    return this?.user?.username || 'unregistred';
  }
}
