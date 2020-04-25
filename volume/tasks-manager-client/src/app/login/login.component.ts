import { Component, OnInit } from '@angular/core';
import { ApiService } from '../api.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  constructor(private api: ApiService) {}

  username: string;
  password: string;

  ngOnInit(): void {
    this.username = 'registered_user1';
    this.password = '111';
  }

  handleSuccess(data): void {
    console.log(data.token);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error);
  }

  login(): void {
    this.api
      .doLogin(this.username, this.password)
      .subscribe(this.handleSuccess, this.handleFail);
  }
}
