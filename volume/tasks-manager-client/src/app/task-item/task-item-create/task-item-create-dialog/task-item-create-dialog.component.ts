import { TaskitemStoreService } from './../../../shared/services/taskitem/taskitem-store.service';
import { Component, OnInit, Inject, Input } from '@angular/core';
import { ApiService } from 'src/app/shared/services/api/api.service';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Task } from 'src/app/model/task';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-task-item-create-dialog',
  templateUrl: './task-item-create-dialog.component.html',
  styleUrls: ['./task-item-create-dialog.component.css'],
})
export class TaskItemCreateDialogComponent implements OnInit {
  task: Task = {} as Task;
  constructor(
    private api: ApiService,
    public dialogRef: MatDialogRef<TaskItemCreateDialogComponent>,
    private taskitemStoreService: TaskitemStoreService,
    @Inject(MAT_DIALOG_DATA) public data: number
  ) {}

  ngOnInit(): void {}

  onCancelClick(): void {
    this.dialogRef.close();
  }

  onCreateClick(): void {
    const taskListId = this.data;
    this.api.createTaskInTaskList(this.task, taskListId).subscribe(
      (response) => this.handleSuccess(response),
      (error) => this.handleFail(error)
    );
  }

  handleSuccess(response): void {
    const tasklistId = this.data;
    const taskItemJson = response.data;
    this.taskitemStoreService.save(tasklistId, taskItemJson);
    this.dialogRef.close();
  }

  handleFail(error: HttpErrorResponse): void {
    console.error(error.error.error_message);
    this.dialogRef.close({
      error: true,
      errorMessage: error.error.error_message,
    });
  }
}
