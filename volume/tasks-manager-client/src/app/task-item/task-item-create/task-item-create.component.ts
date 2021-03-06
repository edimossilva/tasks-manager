import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';
import { ApiService } from '../../shared/services/api/api.service';
import { Task } from '../../model/task';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';
import { TaskItemCreateDialogComponent } from './task-item-create-dialog/task-item-create-dialog.component';

@Component({
  selector: 'app-task-item-create',
  templateUrl: './task-item-create.component.html',
  styleUrls: ['./task-item-create.component.css'],
})
export class AddTaskComponent implements OnInit {
  task: Task = new Task();

  constructor(private api: ApiService, public dialog: MatDialog) {}
  ngOnInit(): void {}
  @Input() tasklistId: number;

  handleSuccess(response): void {
    console.log(response);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  addTask(): void {
    this.api
      .createTaskInTaskList(this.task, this.tasklistId)
      .subscribe((response) => this.handleSuccess(response), this.handleFail);
  }

  openCreateTaskItemDialog(): void {
    this.dialog.open(TaskItemCreateDialogComponent, {
      width: '250px',
      data: this.tasklistId,
    });
  }
}
