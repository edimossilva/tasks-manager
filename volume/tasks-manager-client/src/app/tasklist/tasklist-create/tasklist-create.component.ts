import { Component, OnInit } from '@angular/core';
import { Tasklist } from '../../model/tasklist';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';
import { TasklistCreateDialogComponent } from './tasklist-create-dialog/tasklist-create-dialog.component';

@Component({
  selector: 'app-tasklist-create',
  templateUrl: './tasklist-create.component.html',
  styleUrls: ['./tasklist-create.component.css'],
})
export class TasklistCreateComponent implements OnInit {
  tasklist: Tasklist = <Tasklist>{};

  constructor(private api: ApiService, public dialog: MatDialog) {}
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

  openCreateTaskItemDialog(): void {
    this.dialog.open(TasklistCreateDialogComponent, {
      width: '250px',
      data: this.tasklist,
    });
  }
}
