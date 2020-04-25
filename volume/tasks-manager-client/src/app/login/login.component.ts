import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  constructor() {}

  username: String;
  password: String;

  ngOnInit(): void {}

  login(): void {
    window.alert('click');
  }
}
