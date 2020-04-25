import { Injectable } from '@angular/core';
import { User } from './user';
@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor() {}

  user: User;

  setUser(user) {
    console.log(this.getUsername());
    this.user = <User>{
      id: user.userId,
      username: user.username,
      token: user.token,
    };
  }

  getUsername() {
    return this?.user?.username || 'unregistred';
  }
}
