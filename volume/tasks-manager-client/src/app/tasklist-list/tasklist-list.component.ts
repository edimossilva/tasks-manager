import { Component, OnInit } from '@angular/core';
import { ApiService } from '../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { Tasklist } from '../model/tasklist';

@Component({
  selector: 'app-tasklist-list',
  templateUrl: './tasklist-list.component.html',
  styleUrls: ['./tasklist-list.component.css'],
})
export class TasklistListComponent implements OnInit {
  constructor(private api: ApiService) {}
  tasklists: Tasklist[];

  handleSuccess(response): void {
    this.tasklists = response.data;
    console.log(this.tasklists[0].frequence_type);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  ngOnInit(): void {
    this.api
      .getTaskLists()
      .subscribe((response) => this.handleSuccess(response), this.handleFail);
  }
}
