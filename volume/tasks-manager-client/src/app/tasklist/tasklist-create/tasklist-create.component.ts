import { Component, OnInit } from '@angular/core';
import { Tasklist } from '../../model/tasklist';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-tasklist-create',
  templateUrl: './tasklist-create.component.html',
  styleUrls: ['./tasklist-create.component.css'],
})
export class TasklistCreateComponent implements OnInit {
  constructor(private api: ApiService) {}
  tasklist: Tasklist = <Tasklist>{};
  ngOnInit(): void {}

  handleSuccess(response): void {
    console.log(response);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  createTasklist(): void {
    this.api
      .createTaskList(this.tasklist)
      .subscribe((response) => this.handleSuccess(response), this.handleFail);
  }
}
