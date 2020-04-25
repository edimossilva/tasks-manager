import { Component, OnInit } from '@angular/core';
import { ApiService } from '../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { UserService } from '../shared/services/user/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  constructor(private api: ApiService, private userService: UserService) {}

  username: string;
  password: string;
  ngOnInit(): void {
    this.username = 'registered_user1';
    this.password = '111';
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  login(): void {
    this.api
      .doLogin(this.username, this.password)
      .subscribe((data) => this.userService.setUser(data), this.handleFail);
  }
}
